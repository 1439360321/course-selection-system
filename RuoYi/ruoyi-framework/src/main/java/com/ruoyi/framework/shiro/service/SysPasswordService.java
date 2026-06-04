package com.ruoyi.framework.shiro.service;

import java.util.concurrent.atomic.AtomicInteger;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.constant.ShiroConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.user.UserPasswordNotMatchException;
import com.ruoyi.common.exception.user.UserPasswordRetryLimitExceedException;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.security.Md5Utils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import jakarta.annotation.PostConstruct;

/**
 * 登录密码方法
 * 
 * @author ruoyi
 */
@Component
public class SysPasswordService
{
    @Autowired
    private CacheManager cacheManager;

    private Cache<String, AtomicInteger> loginRecordCache;

    @Value(value = "${user.password.maxRetryCount}")
    private String maxRetryCount;

    @PostConstruct
    public void init()
    {
        loginRecordCache = cacheManager.getCache(ShiroConstants.LOGIN_RECORD_CACHE);
    }

    public void validate(SysUser user, String password)
    {
        String loginName = user.getLoginName();

        AtomicInteger retryCount = loginRecordCache.get(loginName);

        if (retryCount == null)
        {
            retryCount = new AtomicInteger(0);
            loginRecordCache.put(loginName, retryCount);
        }
        if (retryCount.incrementAndGet() > Integer.valueOf(maxRetryCount).intValue())
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.LOGIN_FAIL, MessageUtils.message("user.password.retry.limit.exceed", maxRetryCount)));
            throw new UserPasswordRetryLimitExceedException(Integer.valueOf(maxRetryCount).intValue());
        }

        if (!matches(user, password))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginName, Constants.LOGIN_FAIL, MessageUtils.message("user.password.retry.limit.count", retryCount)));
            loginRecordCache.put(loginName, retryCount);
            throw new UserPasswordNotMatchException();
        }
        else
        {
            clearLoginRecordCache(loginName);
        }
    }

    @Autowired
    private ISysUserService userService;

    private static final BCryptPasswordEncoder bcryptEncoder = new BCryptPasswordEncoder();

    public boolean matches(SysUser user, String newPassword)
    {
        String stored = user.getPassword();
        // BCrypt 密码（以 $2a$ 开头）
        if (stored != null && stored.startsWith("$2a$"))
        {
            return bcryptEncoder.matches(newPassword, stored);
        }
        // 旧 MD5 密码
        boolean md5Match = stored != null && stored.equals(Md5Utils.hash(user.getLoginName() + newPassword + user.getSalt()));
        if (md5Match)
        {
            // 透明迁移：将旧 MD5 密码自动升级为 BCrypt
            String bcryptHash = bcryptEncoder.encode(newPassword);
            user.setPassword(bcryptHash);
            user.setSalt("");
            userService.resetUserPwd(user);
        }
        return md5Match;
    }

    public void clearLoginRecordCache(String loginName)
    {
        loginRecordCache.remove(loginName);
    }

    public String encryptPassword(String loginName, String password, String salt)
    {
        return bcryptEncoder.encode(password);
    }
}
