-- ----------------------------
-- 选课时间窗口配置迁移
-- 在 sys_config 表中添加选课开始/结束时间配置项
-- ----------------------------

-- 选课开始时间 - 如果已存在则忽略（MySQL 5.7+ 支持 IGNORE）
INSERT IGNORE INTO sys_config (config_name, config_key, config_value, config_type, create_by, create_time, remark)
VALUES ('选课开始时间', 'course.selection.start', '', 'Y', 'admin', NOW(), '选课时间段开始时间，格式yyyy-MM-dd HH:mm:ss');

-- 选课结束时间 - 如果已存在则忽略
INSERT IGNORE INTO sys_config (config_name, config_key, config_value, config_type, create_by, create_time, remark)
VALUES ('选课结束时间', 'course.selection.end', '', 'Y', 'admin', NOW(), '选课时间段结束时间，格式yyyy-MM-dd HH:mm:ss');
