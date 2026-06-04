package com.ruoyi.framework.aspectj;

import java.time.LocalDateTime;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.common.annotation.SecurityLog;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.AuditLog;
import com.ruoyi.system.mapper.AuditLogMapper;

/**
 * 安全审计日志AOP处理
 *
 * @author course-selection-team
 */
@Aspect
@Component
public class SecurityLogAspect
{
    private static final Logger log = LoggerFactory.getLogger(SecurityLogAspect.class);

    @Autowired
    private AuditLogMapper auditLogMapper;

    /**
     * 处理完请求后执行（成功）
     */
    @AfterReturning(pointcut = "@annotation(securityLog)")
    public void doAfterReturning(JoinPoint joinPoint, SecurityLog securityLog)
    {
        handleLog(joinPoint, securityLog, null);
    }

    /**
     * 拦截异常操作（失败）
     */
    @AfterThrowing(value = "@annotation(securityLog)", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, SecurityLog securityLog, Exception e)
    {
        handleLog(joinPoint, securityLog, e);
    }

    /**
     * 处理审计日志记录
     */
    private void handleLog(JoinPoint joinPoint, SecurityLog securityLog, Exception e)
    {
        try
        {
            AuditLog auditLog = new AuditLog();

            // 操作人（安全获取登录名，未登录时返回 "anonymous"）
            String loginName = getLoginName();
            auditLog.setAdminId(StringUtils.substring(loginName, 0, 8));

            // 操作动作
            auditLog.setAction(securityLog.action());

            // 操作详情：标题 + 方法签名 + 成功/失败
            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            StringBuilder detail = new StringBuilder();
            detail.append(securityLog.title());
            detail.append(" [").append(className).append(".").append(methodName).append("()]");
            if (e != null)
            {
                detail.append(" - 失败: ").append(StringUtils.substring(e.getMessage(), 0, 500));
            }
            else
            {
                detail.append(" - 成功");
            }
            auditLog.setDetail(detail.toString());

            // IP地址
            auditLog.setIpAddr(ShiroUtils.getIp());

            // 操作时间
            auditLog.setCreatedAt(LocalDateTime.now());

            // 保存到数据库
            auditLogMapper.insertAuditLog(auditLog);
        }
        catch (Exception exp)
        {
            // 记录本地异常日志，不影响业务主流程
            log.error("安全审计日志记录异常:{}", exp.getMessage());
        }
    }

    /**
     * 安全获取当前登录用户名
     */
    private String getLoginName()
    {
        try
        {
            String name = ShiroUtils.getLoginName();
            if (StringUtils.isNotEmpty(name))
            {
                return name;
            }
        }
        catch (Exception e)
        {
            // 未登录或获取失败时忽略
        }
        return "anonymous";
    }
}
