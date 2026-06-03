@echo off
echo Creating base tables for RuoYi framework...

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 course_selection -e "
CREATE TABLE IF NOT EXISTS sys_config (
  config_id int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  config_name varchar(100) DEFAULT '' COMMENT '参数名称',
  config_key varchar(100) DEFAULT '' COMMENT '参数键名',
  config_value varchar(500) DEFAULT '' COMMENT '参数键值',
  config_type char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  create_by varchar(64) DEFAULT '' COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT '' COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (config_id)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';

INSERT INTO sys_config VALUES 
(1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-05-27 15:14:18','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-05-27 15:14:18','',NULL,'初始化密码 123456');
"

echo Base tables created!
pause