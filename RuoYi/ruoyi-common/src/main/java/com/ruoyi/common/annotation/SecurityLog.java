package com.ruoyi.common.annotation;

import java.lang.annotation.*;

/**
 * 安全审计日志注解
 *
 * @author course-selection-team
 */
@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SecurityLog
{
    /**
     * 模块标题
     */
    public String title() default "";

    /**
     * 操作动作
     */
    public String action() default "";
}
