package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.SysLogininfor;

/**
 * 系统访问日志情况信息 数据层
 * 
 * @author ruoyi
 */
public interface SysLogininforMapper
{
    /**
     * 新增系统登录日志
     * 
     * @param logininfor 访问日志对象
     */
    public void insertLogininfor(SysLogininfor logininfor);

    /**
     * 查询系统登录日志集合
     * 
     * @param logininfor 访问日志对象
     * @return 登录记录集合
     */
    public List<SysLogininfor> selectLogininforList(SysLogininfor logininfor);

    /**
     * 批量删除系统登录日志
     * 
     * @param ids 需要删除的数据
     * @return 结果
     */
    public int deleteLogininforByIds(String[] ids);

    /**
     * 清空系统登录日志
     *
     * @return 结果
     */
    public int cleanLogininfor();

    /**
     * 统计今日登录失败次数
     *
     * @return 今日失败次数
     */
    public int countTodayLoginFails();

    /**
     * 统计今日异常登录次数（成功但msg非"登录成功"的记录）
     *
     * @return 异常登录次数
     */
    public int countTodayAbnormalLogins();

    /**
     * 查询近期登录记录（最近N条）
     *
     * @param limit 条数
     * @return 登录记录集合
     */
    public List<SysLogininfor> selectRecentLogininfor(@Param("limit") int limit);

    /**
     * 统计今日各用户登录失败次数（用于标记可疑账户）
     *
     * @return 用户名和失败次数列表
     */
    public List<Map<String, Object>> selectSuspiciousAccounts();
}
