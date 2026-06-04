-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)

--

-- Host: localhost    Database: course_selection

-- ------------------------------------------------------

-- Server version	8.0.39



/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!50503 SET NAMES utf8mb4 */;

/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;

/*!40103 SET TIME_ZONE='+00:00' */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;



--

-- Table structure for table `admin`

--



DROP TABLE IF EXISTS `admin`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `admin` (

  `admin_id` char(8) NOT NULL,

  `admin_name` varchar(20) NOT NULL,

  `password_hash` varchar(128) NOT NULL,

  `status` tinyint NOT NULL DEFAULT '1',

  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`admin_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `admin`

--



LOCK TABLES `admin` WRITE;

/*!40000 ALTER TABLE `admin` DISABLE KEYS */;

INSERT INTO `admin` VALUES ('A001','系统管理员','e10adc3949ba59abbe56e057f20f883e',1,'2026-05-27 17:17:09');

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `audit_log`

--



DROP TABLE IF EXISTS `audit_log`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `audit_log` (

  `log_id` bigint NOT NULL AUTO_INCREMENT,

  `admin_id` char(8) NOT NULL,

  `action` varchar(100) NOT NULL,

  `detail` text,

  `ip_addr` varchar(45) DEFAULT NULL,

  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`log_id`),

  KEY `idx_admin_id` (`admin_id`),

  KEY `idx_created_at` (`created_at`),

  CONSTRAINT `fk_audit_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `audit_log`

--



LOCK TABLES `audit_log` WRITE;

/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;

/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `class`

--



DROP TABLE IF EXISTS `class`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `class` (

  `tno` char(8) NOT NULL,

  `cno` char(8) NOT NULL,

  `semester` varchar(20) NOT NULL,

  `class_time` varchar(50) DEFAULT NULL,

  `admin_id` char(8) NOT NULL,

  PRIMARY KEY (`tno`,`cno`),

  KEY `fk_class_course` (`cno`),

  KEY `fk_class_admin` (`admin_id`),

  CONSTRAINT `fk_class_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),

  CONSTRAINT `fk_class_course` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`),

  CONSTRAINT `fk_class_teacher` FOREIGN KEY (`tno`) REFERENCES `teacher` (`tno`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `class`

--



LOCK TABLES `class` WRITE;

/*!40000 ALTER TABLE `class` DISABLE KEYS */;

INSERT INTO `class` VALUES ('T2021001','C001','2025-2026-2','周一3-4节 周三1-2节','A001'),('T2021001','C003','2025-2026-2','周二5-6节 周五3-4节','A001'),('T2021002','C002','2025-2026-2','周一1-2节 周四3-4节','A001'),('T2021003','C004','2025-2026-2','周二1-2节 周四1-2节','A001'),('T2021003','C005','2025-2026-2','周三3-4节 周五1-2节','A001'),('T2021004','C007','2025-2026-2','周一5-6节 周三5-6节','A001'),('T2021005','C009','2025-2026-2','周二3-4节 周四5-6节','A001'),('T2021006','C011','2025-2026-2','周一7-8节 周四7-8节','A001'),('T2021006','C012','2025-2026-2','周三1-2节 周五5-6节','A001');

/*!40000 ALTER TABLE `class` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `course`

--



DROP TABLE IF EXISTS `course`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `course` (

  `cno` char(8) NOT NULL,

  `cname` varchar(50) NOT NULL,

  `credit` decimal(3,1) NOT NULL,

  `hours` int NOT NULL,

  `course_type` tinyint NOT NULL DEFAULT '0',

  `dept_id` int NOT NULL,

  `admin_id` char(8) NOT NULL,

  PRIMARY KEY (`cno`),

  KEY `idx_dept_id` (`dept_id`),

  KEY `idx_admin_id` (`admin_id`),

  CONSTRAINT `fk_course_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),

  CONSTRAINT `fk_course_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),

  CONSTRAINT `chk_course_type` CHECK ((`course_type` in (0,1)))

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `course`

--



LOCK TABLES `course` WRITE;

/*!40000 ALTER TABLE `course` DISABLE KEYS */;

INSERT INTO `course` VALUES ('C001','数据结构与算法',4.0,64,0,1,'A001'),('C002','操作系统',3.5,56,0,1,'A001'),('C003','计算机网络',3.0,48,0,1,'A001'),('C004','高等数学',5.0,80,0,2,'A001'),('C005','线性代数',3.0,48,0,2,'A001'),('C006','概率论与数理统计',3.0,48,1,2,'A001'),('C007','大学物理',4.0,64,0,3,'A001'),('C008','量子力学导论',2.0,32,1,3,'A001'),('C009','大学英语',4.0,64,0,4,'A001'),('C010','英语写作',2.0,32,1,4,'A001'),('C011','微观经济学',3.0,48,0,5,'A001'),('C012','管理学原理',3.0,48,0,5,'A001'),('C013','市场营销学',2.5,40,1,5,'A001'),('C014','素描基础',2.0,32,0,6,'A001'),('C015','色彩构成',3.0,48,0,6,'A001');

/*!40000 ALTER TABLE `course` ENABLE KEYS */;

UNLOCK TABLES;

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;

/*!50003 SET @saved_cs_results     = @@character_set_results */ ;

/*!50003 SET @saved_col_connection = @@collation_connection */ ;

/*!50003 SET character_set_client  = gbk */ ;

/*!50003 SET character_set_results = gbk */ ;

/*!50003 SET collation_connection  = gbk_chinese_ci */ ;

/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;

DELIMITER ;;

/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_course_delete` BEFORE DELETE ON `course` FOR EACH ROW BEGIN

    DELETE FROM courseselection WHERE cno = OLD.cno;

    DELETE FROM class WHERE cno = OLD.cno;

END */;;

DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;

/*!50003 SET character_set_client  = @saved_cs_client */ ;

/*!50003 SET character_set_results = @saved_cs_results */ ;

/*!50003 SET collation_connection  = @saved_col_connection */ ;



--

-- Table structure for table `courseselection`

--



DROP TABLE IF EXISTS `courseselection`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `courseselection` (

  `sno` char(10) NOT NULL,

  `cno` char(8) NOT NULL,

  `semester` varchar(20) NOT NULL,

  `normal_score` decimal(5,2) DEFAULT NULL,

  `test_score` decimal(5,2) DEFAULT NULL,

  PRIMARY KEY (`sno`,`cno`),

  KEY `fk_cs_course` (`cno`),

  CONSTRAINT `fk_cs_course` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`),

  CONSTRAINT `fk_cs_student` FOREIGN KEY (`sno`) REFERENCES `student` (`sno`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `courseselection`

--



LOCK TABLES `courseselection` WRITE;

/*!40000 ALTER TABLE `courseselection` DISABLE KEYS */;

INSERT INTO `courseselection` VALUES ('2021001001','C001','2025-2026-2',85.00,78.00),('2021001001','C004','2025-2026-2',90.00,88.00),('2021001001','C009','2025-2026-2',NULL,NULL),('2021001002','C001','2025-2026-2',92.00,85.00),('2021001002','C002','2025-2026-2',NULL,NULL),('2021001002','C007','2025-2026-2',NULL,NULL),('2021001003','C004','2025-2026-2',76.00,70.00),('2021001003','C005','2025-2026-2',NULL,NULL),('2021001003','C006','2025-2026-2',NULL,NULL),('2021002001','C009','2025-2026-2',88.00,92.00),('2021002001','C010','2025-2026-2',NULL,NULL),('2021002002','C011','2025-2026-2',NULL,NULL),('2021002002','C012','2025-2026-2',NULL,NULL),('2021003001','C007','2025-2026-2',NULL,NULL),('2021003001','C008','2025-2026-2',NULL,NULL),('2021003002','C001','2025-2026-2',NULL,NULL),('2021003002','C003','2025-2026-2',NULL,NULL),('2021004001','C014','2025-2026-2',NULL,NULL),('2021004001','C015','2025-2026-2',NULL,NULL),('2021004002','C004','2025-2026-2',NULL,NULL),('2021004002','C011','2025-2026-2',NULL,NULL),('2021005001','C002','2025-2026-2',NULL,NULL),('2021005001','C009','2025-2026-2',NULL,NULL),('2021005002','C005','2025-2026-2',NULL,NULL),('2021005002','C007','2025-2026-2',NULL,NULL),('2021006001','C012','2025-2026-2',NULL,NULL),('2021006001','C013','2025-2026-2',NULL,NULL),('2021006002','C014','2025-2026-2',NULL,NULL);

/*!40000 ALTER TABLE `courseselection` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `department`

--



DROP TABLE IF EXISTS `department`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `department` (

  `dept_id` int NOT NULL AUTO_INCREMENT,

  `dept_name` varchar(30) NOT NULL,

  `address` varchar(100) DEFAULT NULL,

  `phone_code` varchar(20) DEFAULT NULL,

  PRIMARY KEY (`dept_id`),

  UNIQUE KEY `uk_dept_name` (`dept_name`)

) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `department`

--



LOCK TABLES `department` WRITE;

/*!40000 ALTER TABLE `department` DISABLE KEYS */;

INSERT INTO `department` VALUES (1,'计算机科学与技术学院','理科楼A座3层','0371-67781234'),(2,'数学与统计学院','理科楼B座2层','0371-67781235'),(3,'物理与电子工程学院','工科实验楼1层','0371-67781236'),(4,'外国语学院','文科楼5层','0371-67781237'),(5,'经济管理学院','文科楼3层','0371-67781238'),(6,'艺术设计学院','艺术楼2层','0371-67781239');

/*!40000 ALTER TABLE `department` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `gen_table`

--



DROP TABLE IF EXISTS `gen_table`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `gen_table` (

  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',

  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',

  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',

  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',

  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',

  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',

  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',

  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',

  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',

  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',

  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',

  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',

  `form_col_num` int DEFAULT '1' COMMENT '表单布局（单列 双列 三列）',

  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',

  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',

  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`table_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `gen_table`

--



LOCK TABLES `gen_table` WRITE;

/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;

/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `gen_table_column`

--



DROP TABLE IF EXISTS `gen_table_column`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `gen_table_column` (

  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',

  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',

  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',

  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',

  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',

  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',

  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',

  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',

  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',

  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',

  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',

  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',

  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',

  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',

  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',

  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',

  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',

  `sort` int DEFAULT NULL COMMENT '排序',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  PRIMARY KEY (`column_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `gen_table_column`

--



LOCK TABLES `gen_table_column` WRITE;

/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;

/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_blob_triggers`

--



DROP TABLE IF EXISTS `qrtz_blob_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_blob_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  `blob_data` blob COMMENT '存放持久化Trigger对象',

  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),

  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Blob类型的触发器表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_blob_triggers`

--



LOCK TABLES `qrtz_blob_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_calendars`

--



DROP TABLE IF EXISTS `qrtz_calendars`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_calendars` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',

  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',

  PRIMARY KEY (`sched_name`,`calendar_name`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日历信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_calendars`

--



LOCK TABLES `qrtz_calendars` WRITE;

/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_cron_triggers`

--



DROP TABLE IF EXISTS `qrtz_cron_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_cron_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',

  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',

  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),

  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cron类型的触发器表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_cron_triggers`

--



LOCK TABLES `qrtz_cron_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_fired_triggers`

--



DROP TABLE IF EXISTS `qrtz_fired_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_fired_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',

  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',

  `fired_time` bigint NOT NULL COMMENT '触发的时间',

  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',

  `priority` int NOT NULL COMMENT '优先级',

  `state` varchar(16) NOT NULL COMMENT '状态',

  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',

  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',

  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',

  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',

  PRIMARY KEY (`sched_name`,`entry_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='已触发的触发器表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_fired_triggers`

--



LOCK TABLES `qrtz_fired_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_job_details`

--



DROP TABLE IF EXISTS `qrtz_job_details`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_job_details` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `job_name` varchar(200) NOT NULL COMMENT '任务名称',

  `job_group` varchar(200) NOT NULL COMMENT '任务组名',

  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',

  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',

  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',

  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',

  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',

  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',

  `job_data` blob COMMENT '存放持久化job对象',

  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务详细信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_job_details`

--



LOCK TABLES `qrtz_job_details` WRITE;

/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_locks`

--



DROP TABLE IF EXISTS `qrtz_locks`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_locks` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',

  PRIMARY KEY (`sched_name`,`lock_name`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='存储的悲观锁信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_locks`

--



LOCK TABLES `qrtz_locks` WRITE;

/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_paused_trigger_grps`

--



DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_paused_trigger_grps` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  PRIMARY KEY (`sched_name`,`trigger_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='暂停的触发器表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_paused_trigger_grps`

--



LOCK TABLES `qrtz_paused_trigger_grps` WRITE;

/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_scheduler_state`

--



DROP TABLE IF EXISTS `qrtz_scheduler_state`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_scheduler_state` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',

  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',

  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',

  PRIMARY KEY (`sched_name`,`instance_name`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度器状态表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_scheduler_state`

--



LOCK TABLES `qrtz_scheduler_state` WRITE;

/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_simple_triggers`

--



DROP TABLE IF EXISTS `qrtz_simple_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_simple_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',

  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',

  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',

  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),

  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='简单触发器的信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_simple_triggers`

--



LOCK TABLES `qrtz_simple_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_simprop_triggers`

--



DROP TABLE IF EXISTS `qrtz_simprop_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_simprop_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',

  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',

  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',

  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',

  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',

  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',

  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',

  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',

  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',

  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',

  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',

  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',

  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',

  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),

  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='同步机制的行锁表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_simprop_triggers`

--



LOCK TABLES `qrtz_simprop_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `qrtz_triggers`

--



DROP TABLE IF EXISTS `qrtz_triggers`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `qrtz_triggers` (

  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',

  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',

  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',

  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',

  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',

  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',

  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',

  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',

  `priority` int DEFAULT NULL COMMENT '优先级',

  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',

  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',

  `start_time` bigint NOT NULL COMMENT '开始时间',

  `end_time` bigint DEFAULT NULL COMMENT '结束时间',

  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',

  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',

  `job_data` blob COMMENT '存放持久化job对象',

  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),

  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),

  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='触发器详细信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `qrtz_triggers`

--



LOCK TABLES `qrtz_triggers` WRITE;

/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;

/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `student`

--



DROP TABLE IF EXISTS `student`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `student` (

  `sno` char(10) NOT NULL,

  `sname` varchar(20) NOT NULL,

  `sex` char(1) DEFAULT NULL,

  `birth` date DEFAULT NULL,

  `native_place` varchar(50) DEFAULT NULL,

  `phone` varchar(20) DEFAULT NULL,

  `password_hash` varchar(128) NOT NULL,

  `status` tinyint NOT NULL DEFAULT '1',

  `dept_id` int NOT NULL,

  `created_by` char(8) DEFAULT NULL,

  PRIMARY KEY (`sno`),

  KEY `idx_dept_id` (`dept_id`),

  KEY `fk_student_createdby` (`created_by`),

  CONSTRAINT `fk_student_createdby` FOREIGN KEY (`created_by`) REFERENCES `admin` (`admin_id`),

  CONSTRAINT `fk_student_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),

  CONSTRAINT `chk_student_sex` CHECK ((`sex` in ('男','女')))

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `student`

--



LOCK TABLES `student` WRITE;

/*!40000 ALTER TABLE `student` DISABLE KEYS */;

INSERT INTO `student` VALUES ('2021001001','张文博','男','2002-03-15','河南郑州','13603711234','e10adc3949ba59abbe56e057f20f883e',1,1,NULL),('2021001002','李思雨','女','2002-07-22','河南洛阳','13603711235','e10adc3949ba59abbe56e057f20f883e',1,1,NULL),('2021001003','王浩然','男','2001-11-08','湖北武汉','13603711236','e10adc3949ba59abbe56e057f20f883e',1,1,NULL),('2021002001','赵雅婷','女','2002-05-30','湖南长沙','13603711237','e10adc3949ba59abbe56e057f20f883e',1,2,NULL),('2021002002','陈志远','男','2002-01-18','河南信阳','13603711238','e10adc3949ba59abbe56e057f20f883e',1,2,NULL),('2021003001','刘佳琪','女','2001-09-12','安徽合肥','13603711239','e10adc3949ba59abbe56e057f20f883e',1,3,NULL),('2021003002','孙明辉','男','2002-06-25','山东济南','13603711240','e10adc3949ba59abbe56e057f20f883e',1,3,NULL),('2021004001','周晓萌','女','2002-04-03','河北石家庄','13603711241','e10adc3949ba59abbe56e057f20f883e',1,4,NULL),('2021004002','吴雨桐','女','2002-08-17','河南开封','13603711242','e10adc3949ba59abbe56e057f20f883e',1,4,NULL),('2021005001','郑鹏飞','男','2002-02-28','山西太原','13603711243','e10adc3949ba59abbe56e057f20f883e',1,5,NULL),('2021005002','黄诗涵','女','2001-12-05','河南南阳','13603711244','e10adc3949ba59abbe56e057f20f883e',1,5,NULL),('2021006001','林俊杰','男','2002-10-20','福建福州','13603711245','e10adc3949ba59abbe56e057f20f883e',1,6,NULL),('2021006002','杨雨晴','女','2002-01-09','江苏南京','13603711246','e10adc3949ba59abbe56e057f20f883e',1,6,NULL);

/*!40000 ALTER TABLE `student` ENABLE KEYS */;

UNLOCK TABLES;

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;

/*!50003 SET @saved_cs_results     = @@character_set_results */ ;

/*!50003 SET @saved_col_connection = @@collation_connection */ ;

/*!50003 SET character_set_client  = gbk */ ;

/*!50003 SET character_set_results = gbk */ ;

/*!50003 SET collation_connection  = gbk_chinese_ci */ ;

/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;

DELIMITER ;;

/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_student_delete` BEFORE DELETE ON `student` FOR EACH ROW BEGIN

    DELETE FROM courseselection WHERE sno = OLD.sno;

END */;;

DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;

/*!50003 SET character_set_client  = @saved_cs_client */ ;

/*!50003 SET character_set_results = @saved_cs_results */ ;

/*!50003 SET collation_connection  = @saved_col_connection */ ;



--

-- Table structure for table `sys_config`

--



DROP TABLE IF EXISTS `sys_config`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_config` (

  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',

  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',

  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',

  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',

  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`config_id`)

) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_config`

--



LOCK TABLES `sys_config` WRITE;

/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;

INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-05-27 15:14:18','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-05-27 15:14:18','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-05-27 15:14:18','',NULL,'深黑主题theme-dark，浅色主题theme-light，深蓝主题theme-blue'),(4,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-05-27 15:14:18','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(5,'用户管理-密码字符范围','sys.account.chrtype','0','Y','admin','2026-05-27 15:14:18','',NULL,'默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）'),(6,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-05-27 15:14:18','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(7,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-05-27 15:14:18','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框'),(8,'主框架页-菜单导航显示风格','sys.index.menuStyle','default','Y','admin','2026-05-27 15:14:18','',NULL,'菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）'),(9,'主框架页-是否开启页脚','sys.index.footer','true','Y','admin','2026-05-27 15:14:18','',NULL,'是否开启底部页脚显示（true显示，false隐藏）'),(10,'主框架页-是否开启页签','sys.index.tagsView','true','Y','admin','2026-05-27 15:14:18','',NULL,'是否开启菜单多页签显示（true显示，false隐藏）'),(11,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-05-27 15:14:18','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_dept`

--



DROP TABLE IF EXISTS `sys_dept`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_dept` (

  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',

  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',

  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',

  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',

  `order_num` int DEFAULT '0' COMMENT '显示顺序',

  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',

  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',

  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',

  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',

  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  PRIMARY KEY (`dept_id`)

) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_dept`

--



LOCK TABLES `sys_dept` WRITE;

/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;

INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-05-27 15:14:17','',NULL);

/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_dict_data`

--



DROP TABLE IF EXISTS `sys_dict_data`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_dict_data` (

  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',

  `dict_sort` int DEFAULT '0' COMMENT '字典排序',

  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',

  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',

  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',

  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',

  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',

  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',

  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`dict_code`)

) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_dict_data`

--



LOCK TABLES `sys_dict_data` WRITE;

/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;

INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-05-27 15:14:18','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-05-27 15:14:18','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-05-27 15:14:18','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-05-27 15:14:18','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-05-27 15:14:18','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-05-27 15:14:18','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-05-27 15:14:18','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-05-27 15:14:18','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-05-27 15:14:18','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-05-27 15:14:18','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-05-27 15:14:18','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-05-27 15:14:18','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-05-27 15:14:18','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-05-27 15:14:18','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-05-27 15:14:18','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-05-27 15:14:18','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-05-27 15:14:18','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-05-27 15:14:18','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-05-27 15:14:18','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-05-27 15:14:18','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-05-27 15:14:18','',NULL,'停用状态');

/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_dict_type`

--



DROP TABLE IF EXISTS `sys_dict_type`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_dict_type` (

  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',

  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',

  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',

  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`dict_id`),

  UNIQUE KEY `dict_type` (`dict_type`)

) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_dict_type`

--



LOCK TABLES `sys_dict_type` WRITE;

/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;

INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2026-05-27 15:14:18','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2026-05-27 15:14:18','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2026-05-27 15:14:18','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2026-05-27 15:14:18','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2026-05-27 15:14:18','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2026-05-27 15:14:18','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2026-05-27 15:14:18','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2026-05-27 15:14:18','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2026-05-27 15:14:18','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2026-05-27 15:14:18','',NULL,'登录状态列表');

/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_job`

--



DROP TABLE IF EXISTS `sys_job`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_job` (

  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',

  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',

  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',

  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',

  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',

  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',

  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',

  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',

  PRIMARY KEY (`job_id`,`job_name`,`job_group`)

) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_job`

--



LOCK TABLES `sys_job` WRITE;

/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;

INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-05-27 15:14:18','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-05-27 15:14:18','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-05-27 15:14:18','',NULL,'');

/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_job_log`

--



DROP TABLE IF EXISTS `sys_job_log`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_job_log` (

  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',

  `job_name` varchar(64) NOT NULL COMMENT '任务名称',

  `job_group` varchar(64) NOT NULL COMMENT '任务组名',

  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',

  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',

  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',

  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',

  `start_time` datetime DEFAULT NULL COMMENT '执行开始时间',

  `end_time` datetime DEFAULT NULL COMMENT '执行结束时间',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  PRIMARY KEY (`job_log_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_job_log`

--



LOCK TABLES `sys_job_log` WRITE;

/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;

/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_logininfor`

--



DROP TABLE IF EXISTS `sys_logininfor`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_logininfor` (

  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',

  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',

  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',

  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',

  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',

  `os` varchar(50) DEFAULT '' COMMENT '操作系统',

  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',

  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',

  `login_time` datetime DEFAULT NULL COMMENT '访问时间',

  PRIMARY KEY (`info_id`),

  KEY `idx_sys_logininfor_s` (`status`),

  KEY `idx_sys_logininfor_lt` (`login_time`)

) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_logininfor`

--



LOCK TABLES `sys_logininfor` WRITE;

/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;

INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 15:24:37'),(101,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 16:08:32'),(102,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 16:11:08'),(103,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 16:15:15'),(104,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 16:41:11'),(105,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 17:20:24'),(106,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 17:20:40'),(107,'admin','127.0.0.1','内网IP','Curl 8.11.0','','1','验证码错误','2026-05-27 17:34:33'),(108,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:05:30'),(109,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:05:33'),(110,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:07:02'),(111,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:11:59'),(112,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:26:03'),(113,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:06'),(114,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(115,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(116,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(117,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(118,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(119,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(120,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(121,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(122,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(123,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(124,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(125,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(126,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(127,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(128,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(129,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(130,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(131,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(132,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(133,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(134,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:46'),(135,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 20:32:57'),(136,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:33:01'),(137,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 20:34:07'),(138,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-27 21:00:13'),(139,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:00:22'),(140,'2021001001','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 21:00:32'),(141,'2021001001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:01:13'),(142,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:02:47'),(143,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:06:23'),(144,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:07:25'),(145,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-27 21:07:37'),(146,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:07:42'),(147,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 21:11:25'),(148,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:11:27'),(149,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-27 21:22:25'),(150,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-27 21:22:28'),(151,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-28 10:40:31'),(152,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 10:40:34'),(153,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 10:41:15'),(154,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 10:41:19'),(155,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 10:42:10'),(156,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-28 10:42:42'),(157,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-28 10:42:44'),(158,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','密码输入错误1次','2026-05-28 10:42:47'),(159,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','密码输入错误2次','2026-05-28 10:42:50'),(160,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-28 10:42:53'),(161,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','验证码错误','2026-05-28 10:42:56'),(162,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','密码输入错误3次','2026-05-28 10:42:58'),(163,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','1','密码输入错误1次','2026-05-28 10:44:28'),(164,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 10:46:43'),(165,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 10:46:54'),(166,'2021001001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 10:46:58'),(167,'2021001001','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 10:47:33'),(168,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 10:47:37'),(169,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 11:05:53'),(170,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 11:08:25'),(171,'admin','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 11:08:41'),(172,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 11:08:42'),(173,'T2021001','127.0.0.1','内网IP','Chrome 148','Windows10','0','退出成功','2026-05-28 11:08:46'),(174,'2021001001','127.0.0.1','内网IP','Chrome 148','Windows10','0','登录成功','2026-05-28 11:08:47');

/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_menu`

--



DROP TABLE IF EXISTS `sys_menu`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_menu` (

  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',

  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',

  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',

  `order_num` int DEFAULT '0' COMMENT '显示顺序',

  `url` varchar(200) DEFAULT '#' COMMENT '请求地址',

  `target` varchar(20) DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',

  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',

  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',

  `is_refresh` char(1) DEFAULT '1' COMMENT '是否刷新（0刷新 1不刷新）',

  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',

  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT '' COMMENT '备注',

  PRIMARY KEY (`menu_id`)

) ENGINE=InnoDB AUTO_INCREMENT=2020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_menu`

--



LOCK TABLES `sys_menu` WRITE;

/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'#','','M','0','1','','fa fa-gear','admin','2026-05-27 15:14:17','',NULL,'系统管理目录'),(2,'系统监控',0,2,'#','','M','0','1','','fa fa-video-camera','admin','2026-05-27 15:14:17','',NULL,'系统监控目录'),(3,'系统工具',0,3,'#','','M','0','1','','fa fa-bars','admin','2026-05-27 15:14:17','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip','menuBlank','C','0','1','','fa fa-location-arrow','admin','2026-05-27 15:14:17','',NULL,'若依官网地址'),(100,'用户管理',1,1,'/system/user','','C','0','1','system:user:view','fa fa-user-o','admin','2026-05-27 15:14:17','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'/system/role','','C','0','1','system:role:view','fa fa-user-secret','admin','2026-05-27 15:14:17','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'/system/menu','','C','0','1','system:menu:view','fa fa-th-list','admin','2026-05-27 15:14:17','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'/system/dept','','C','0','1','system:dept:view','fa fa-outdent','admin','2026-05-27 15:14:17','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'/system/post','','C','0','1','system:post:view','fa fa-address-card-o','admin','2026-05-27 15:14:17','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'/system/dict','','C','0','1','system:dict:view','fa fa-bookmark-o','admin','2026-05-27 15:14:17','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'/system/config','','C','0','1','system:config:view','fa fa-sun-o','admin','2026-05-27 15:14:17','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'/system/notice','','C','0','1','system:notice:view','fa fa-bullhorn','admin','2026-05-27 15:14:17','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'#','','M','0','1','','fa fa-pencil-square-o','admin','2026-05-27 15:14:17','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'/monitor/online','','C','0','1','monitor:online:view','fa fa-user-circle','admin','2026-05-27 15:14:17','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'/monitor/job','','C','0','1','monitor:job:view','fa fa-tasks','admin','2026-05-27 15:14:17','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'/monitor/data','','C','0','1','monitor:data:view','fa fa-bug','admin','2026-05-27 15:14:17','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'/monitor/server','','C','0','1','monitor:server:view','fa fa-server','admin','2026-05-27 15:14:17','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'/monitor/cache','','C','0','1','monitor:cache:view','fa fa-cube','admin','2026-05-27 15:14:17','',NULL,'缓存监控菜单'),(114,'表单构建',3,1,'/tool/build','','C','0','1','tool:build:view','fa fa-wpforms','admin','2026-05-27 15:14:17','',NULL,'表单构建菜单'),(115,'代码生成',3,2,'/tool/gen','','C','0','1','tool:gen:view','fa fa-code','admin','2026-05-27 15:14:17','',NULL,'代码生成菜单'),(116,'系统接口',3,3,'/tool/swagger','','C','0','1','tool:swagger:view','fa fa-gg','admin','2026-05-27 15:14:17','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'/monitor/operlog','','C','0','1','monitor:operlog:view','fa fa-address-book','admin','2026-05-27 15:14:17','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'/monitor/logininfor','','C','0','1','monitor:logininfor:view','fa fa-file-image-o','admin','2026-05-27 15:14:17','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'#','','F','0','1','system:user:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1001,'用户新增',100,2,'#','','F','0','1','system:user:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1002,'用户修改',100,3,'#','','F','0','1','system:user:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1003,'用户删除',100,4,'#','','F','0','1','system:user:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1004,'用户导出',100,5,'#','','F','0','1','system:user:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1005,'用户导入',100,6,'#','','F','0','1','system:user:import','#','admin','2026-05-27 15:14:17','',NULL,''),(1006,'重置密码',100,7,'#','','F','0','1','system:user:resetPwd','#','admin','2026-05-27 15:14:17','',NULL,''),(1007,'角色查询',101,1,'#','','F','0','1','system:role:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1008,'角色新增',101,2,'#','','F','0','1','system:role:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1009,'角色修改',101,3,'#','','F','0','1','system:role:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1010,'角色删除',101,4,'#','','F','0','1','system:role:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1011,'角色导出',101,5,'#','','F','0','1','system:role:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1012,'菜单查询',102,1,'#','','F','0','1','system:menu:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1013,'菜单新增',102,2,'#','','F','0','1','system:menu:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1014,'菜单修改',102,3,'#','','F','0','1','system:menu:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1015,'菜单删除',102,4,'#','','F','0','1','system:menu:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1016,'部门查询',103,1,'#','','F','0','1','system:dept:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1017,'部门新增',103,2,'#','','F','0','1','system:dept:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1018,'部门修改',103,3,'#','','F','0','1','system:dept:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1019,'部门删除',103,4,'#','','F','0','1','system:dept:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1020,'岗位查询',104,1,'#','','F','0','1','system:post:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1021,'岗位新增',104,2,'#','','F','0','1','system:post:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1022,'岗位修改',104,3,'#','','F','0','1','system:post:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1023,'岗位删除',104,4,'#','','F','0','1','system:post:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1024,'岗位导出',104,5,'#','','F','0','1','system:post:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1025,'字典查询',105,1,'#','','F','0','1','system:dict:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1026,'字典新增',105,2,'#','','F','0','1','system:dict:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1027,'字典修改',105,3,'#','','F','0','1','system:dict:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1028,'字典删除',105,4,'#','','F','0','1','system:dict:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1029,'字典导出',105,5,'#','','F','0','1','system:dict:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1030,'参数查询',106,1,'#','','F','0','1','system:config:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1031,'参数新增',106,2,'#','','F','0','1','system:config:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1032,'参数修改',106,3,'#','','F','0','1','system:config:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1033,'参数删除',106,4,'#','','F','0','1','system:config:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1034,'参数导出',106,5,'#','','F','0','1','system:config:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1035,'公告查询',107,1,'#','','F','0','1','system:notice:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1036,'公告新增',107,2,'#','','F','0','1','system:notice:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1037,'公告修改',107,3,'#','','F','0','1','system:notice:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1038,'公告删除',107,4,'#','','F','0','1','system:notice:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1039,'操作查询',500,1,'#','','F','0','1','monitor:operlog:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1040,'操作删除',500,2,'#','','F','0','1','monitor:operlog:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1041,'详细信息',500,3,'#','','F','0','1','monitor:operlog:detail','#','admin','2026-05-27 15:14:17','',NULL,''),(1042,'日志导出',500,4,'#','','F','0','1','monitor:operlog:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1043,'登录查询',501,1,'#','','F','0','1','monitor:logininfor:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1044,'登录删除',501,2,'#','','F','0','1','monitor:logininfor:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1045,'日志导出',501,3,'#','','F','0','1','monitor:logininfor:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1046,'账户解锁',501,4,'#','','F','0','1','monitor:logininfor:unlock','#','admin','2026-05-27 15:14:17','',NULL,''),(1047,'在线查询',109,1,'#','','F','0','1','monitor:online:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1048,'批量强退',109,2,'#','','F','0','1','monitor:online:batchForceLogout','#','admin','2026-05-27 15:14:17','',NULL,''),(1049,'单条强退',109,3,'#','','F','0','1','monitor:online:forceLogout','#','admin','2026-05-27 15:14:17','',NULL,''),(1050,'任务查询',110,1,'#','','F','0','1','monitor:job:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1051,'任务新增',110,2,'#','','F','0','1','monitor:job:add','#','admin','2026-05-27 15:14:17','',NULL,''),(1052,'任务修改',110,3,'#','','F','0','1','monitor:job:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1053,'任务删除',110,4,'#','','F','0','1','monitor:job:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1054,'状态修改',110,5,'#','','F','0','1','monitor:job:changeStatus','#','admin','2026-05-27 15:14:17','',NULL,''),(1055,'任务详细',110,6,'#','','F','0','1','monitor:job:detail','#','admin','2026-05-27 15:14:17','',NULL,''),(1056,'任务导出',110,7,'#','','F','0','1','monitor:job:export','#','admin','2026-05-27 15:14:17','',NULL,''),(1057,'生成查询',115,1,'#','','F','0','1','tool:gen:list','#','admin','2026-05-27 15:14:17','',NULL,''),(1058,'生成修改',115,2,'#','','F','0','1','tool:gen:edit','#','admin','2026-05-27 15:14:17','',NULL,''),(1059,'生成删除',115,3,'#','','F','0','1','tool:gen:remove','#','admin','2026-05-27 15:14:17','',NULL,''),(1060,'预览代码',115,4,'#','','F','0','1','tool:gen:preview','#','admin','2026-05-27 15:14:17','',NULL,''),(1061,'生成代码',115,5,'#','','F','0','1','tool:gen:code','#','admin','2026-05-27 15:14:17','',NULL,''),(2000,'选课管理',0,5,'#','','M','0','1','','fa fa-graduation-cap','admin','2026-05-27 15:49:01','',NULL,''),(2001,'院系管理',2000,1,'/admin/department','','C','0','1','admin:department:view','fa fa-building-o','admin','2026-05-27 15:49:07','',NULL,''),(2002,'学生管理',2000,2,'/admin/student','','C','0','1','admin:student:view','fa fa-user','admin','2026-05-27 16:03:44','',NULL,''),(2003,'教师管理',2000,3,'/admin/teacher','','C','0','1','admin:teacher:view','fa fa-user-circle-o','admin','2026-05-27 16:03:44','',NULL,''),(2004,'课程管理',2000,2,'/admin/course','','C','0','1','admin:course:view','#','admin','2026-05-27 17:12:38','',NULL,'课程管理菜单'),(2005,'课程管理-按钮',2004,1,'','','F','0','1','admin:course:list','#','admin','2026-05-27 17:12:38','',NULL,''),(2006,'课程管理-按钮',2004,2,'','','F','0','1','admin:course:add','#','admin','2026-05-27 17:12:38','',NULL,''),(2007,'课程管理-按钮',2004,3,'','','F','0','1','admin:course:edit','#','admin','2026-05-27 17:12:38','',NULL,''),(2008,'课程管理-按钮',2004,4,'','','F','0','1','admin:course:remove','#','admin','2026-05-27 17:12:38','',NULL,''),(2009,'授课管理',2000,3,'/admin/class','','C','0','1','admin:class:view','#','admin','2026-05-27 17:12:38','',NULL,'授课管理菜单'),(2010,'授课管理-按钮',2009,1,'','','F','0','1','admin:class:list','#','admin','2026-05-27 17:12:38','',NULL,''),(2011,'授课管理-按钮',2009,2,'','','F','0','1','admin:class:add','#','admin','2026-05-27 17:12:38','',NULL,''),(2012,'授课管理-按钮',2009,3,'','','F','0','1','admin:class:edit','#','admin','2026-05-27 17:12:38','',NULL,''),(2013,'授课管理-按钮',2009,4,'','','F','0','1','admin:class:remove','#','admin','2026-05-27 17:12:38','',NULL,''),(2014,'选课记录',2000,4,'/admin/courseselection','','C','0','1','admin:courseselection:view','#','admin','2026-05-27 17:12:38','',NULL,'选课记录菜单'),(2015,'选课记录-按钮',2014,1,'','','F','0','1','admin:courseselection:list','#','admin','2026-05-27 17:12:38','',NULL,''),(2016,'选课记录-按钮',2014,2,'','','F','0','1','admin:courseselection:edit','#','admin','2026-05-27 17:12:38','',NULL,''),(2017,'选课记录-按钮',2014,3,'','','F','0','1','admin:courseselection:remove','#','admin','2026-05-27 17:12:38','',NULL,''),(2018,'教师工作台',0,5,'/teacher/index','','C','0','1','teacher:index:view','#','admin','2026-05-27 17:28:29','',NULL,'教师工作台'),(2019,'学生工作台',0,6,'/student/index','','C','0','1','student:index:view','#','admin','2026-05-27 17:28:29','',NULL,'学生工作台');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_notice`

--



DROP TABLE IF EXISTS `sys_notice`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_notice` (

  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',

  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',

  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',

  `notice_content` longblob COMMENT '公告内容',

  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(255) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`notice_id`)

) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_notice`

--



LOCK TABLES `sys_notice` WRITE;

/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;

INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2026-05-27 15:14:18','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2026-05-27 15:14:18','',NULL,'管理员'),(3,'若依开源框架介绍','1',_binary '<p><span style=\"color: rgb(230, 0, 0);\">项目介绍</span></p><p><font color=\"#333333\">RuoYi开源项目是为企业用户定制的后台脚手架框架，为企业打造的一站式解决方案，降低企业开发成本，提升开发效率。主要包括用户管理、角色管理、部门管理、菜单管理、参数管理、字典管理、</font><span style=\"color: rgb(51, 51, 51);\">岗位管理</span><span style=\"color: rgb(51, 51, 51);\">、定时任务</span><span style=\"color: rgb(51, 51, 51);\">、</span><span style=\"color: rgb(51, 51, 51);\">服务监控、登录日志、操作日志、代码生成等功能。其中，还支持多数据源、数据权限、国际化、Redis缓存、Docker部署、滑动验证码、第三方认证登录、分布式事务、</span><font color=\"#333333\">分布式文件存储</font><span style=\"color: rgb(51, 51, 51);\">、分库分表处理等技术特点。</span></p><p><img src=\"https://foruda.gitee.com/images/1705030583977401651/5ed5db6a_1151004.png\" style=\"width: 64px;\"><br></p><p><span style=\"color: rgb(230, 0, 0);\">官网及演示</span></p><p><span style=\"color: rgb(51, 51, 51);\">若依官网地址：&nbsp;</span><a href=\"http://ruoyi.vip\" target=\"_blank\">http://ruoyi.vip</a><a href=\"http://ruoyi.vip\" target=\"_blank\"></a></p><p><span style=\"color: rgb(51, 51, 51);\">若依文档地址：&nbsp;</span><a href=\"http://doc.ruoyi.vip\" target=\"_blank\">http://doc.ruoyi.vip</a><br></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【不分离版】：&nbsp;</span><a href=\"http://demo.ruoyi.vip\" target=\"_blank\">http://demo.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【分离版本】：&nbsp;</span><a href=\"http://vue.ruoyi.vip\" target=\"_blank\">http://vue.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【微服务版】：&nbsp;</span><a href=\"http://cloud.ruoyi.vip\" target=\"_blank\">http://cloud.ruoyi.vip</a></p><p><span style=\"color: rgb(51, 51, 51);\">演示地址【移动端版】：&nbsp;</span><a href=\"http://h5.ruoyi.vip\" target=\"_blank\">http://h5.ruoyi.vip</a></p><p><br style=\"color: rgb(48, 49, 51); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px;\"></p>','0','admin','2026-05-27 15:14:18','',NULL,'管理员');

/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_notice_read`

--



DROP TABLE IF EXISTS `sys_notice_read`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_notice_read` (

  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',

  `notice_id` int NOT NULL COMMENT '公告id',

  `user_id` bigint NOT NULL COMMENT '用户id',

  `read_time` datetime NOT NULL COMMENT '阅读时间',

  PRIMARY KEY (`read_id`),

  UNIQUE KEY `uk_user_notice` (`user_id`,`notice_id`) COMMENT '同一用户同一公告只记录一次'

) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='公告已读记录表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_notice_read`

--



LOCK TABLES `sys_notice_read` WRITE;

/*!40000 ALTER TABLE `sys_notice_read` DISABLE KEYS */;

INSERT INTO `sys_notice_read` VALUES (1,3,1,'2026-05-27 16:36:55');

/*!40000 ALTER TABLE `sys_notice_read` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_oper_log`

--



DROP TABLE IF EXISTS `sys_oper_log`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_oper_log` (

  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',

  `title` varchar(50) DEFAULT '' COMMENT '模块标题',

  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',

  `method` varchar(200) DEFAULT '' COMMENT '方法名称',

  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',

  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',

  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',

  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',

  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',

  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',

  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',

  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',

  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',

  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',

  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',

  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',

  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',

  PRIMARY KEY (`oper_id`),

  KEY `idx_sys_oper_log_bt` (`business_type`),

  KEY `idx_sys_oper_log_s` (`status`),

  KEY `idx_sys_oper_log_ot` (`oper_time`)

) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_oper_log`

--



LOCK TABLES `sys_oper_log` WRITE;

/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;

INSERT INTO `sys_oper_log` VALUES (100,'院系管理',1,'com.ruoyi.web.controller.admin.DepartmentController.addSave()','POST',1,'admin','研发部门','/admin/department/add','127.0.0.1','内网IP','{\"deptName\":[\"计算机科学与技术学院\"],\"address\":[\"理科楼A座3层\"],\"phoneCode\":[\"0371-67781234\"]}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \') values (\n             \'计算机科学与技术学院\', \n             \'理科�\' at line 5\r\n### The error may exist in URL [jar:file:/C:/Users/14393/.m2/repository/com/ruoyi/ruoyi-system/4.8.3/ruoyi-system-4.8.3.jar!/mapper/department/DepartmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.DepartmentMapper.insertDepartment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into department(              dept_name,               address,               phone_code,          ) values (              ?,               ?,               ?,          )\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \') values (\n             \'计算机科学与技术学院\', \n             \'理科�\' at line 5\n; bad SQL grammar []','2026-05-27 16:16:20',1233),(101,'教师管理',3,'com.ruoyi.web.controller.admin.TeacherController.remove()','POST',1,'admin','研发部门','/admin/teacher/remove','127.0.0.1','内网IP','{\"ids\":[\"T2021007\"]}','{\"msg\":\"操作成功\",\"code\":0}',0,NULL,'2026-05-27 20:26:41',62),(102,'授课管理',2,'com.ruoyi.web.controller.admin.ClassController.editSave()','POST',1,'admin','研发部门','/admin/class/edit','127.0.0.1','内网IP','{\"tno\":[\"T2021001\"],\"cno\":[\"C001\"],\"semester\":[\"2025-2026-2\"],\"classTime\":[\"测试时间-已修改\"]}','{\"msg\":\"操作成功\",\"code\":0}',0,NULL,'2026-05-27 20:41:47',43),(103,'选课记录',2,'com.ruoyi.web.controller.admin.CourseSelectionController.editSave()','POST',1,'admin','研发部门','/admin/courseselection/edit','127.0.0.1','内网IP','{\"sno\":[\"2021001001\"],\"cno\":[\"C001\"],\"normalScore\":[\"95\"],\"testScore\":[\"91\"]}','{\"msg\":\"操作成功\",\"code\":0}',0,NULL,'2026-05-27 20:42:24',6),(104,'授课管理',2,'com.ruoyi.web.controller.admin.ClassController.editSave()','POST',1,'admin','研发部门','/admin/class/edit','127.0.0.1','内网IP','{\"tno\":[\"T2021001\"],\"cno\":[\"C001\"],\"semester\":[\"2025-2026-2\"],\"classTime\":[\"周一3-4节 周三1-2节\"]}','{\"msg\":\"操作成功\",\"code\":0}',0,NULL,'2026-05-27 20:42:47',5),(105,'选课记录',2,'com.ruoyi.web.controller.admin.CourseSelectionController.editSave()','POST',1,'admin','研发部门','/admin/courseselection/edit','127.0.0.1','内网IP','{\"sno\":[\"2021001001\"],\"cno\":[\"C001\"],\"normalScore\":[\"85\"],\"testScore\":[\"78\"]}','{\"msg\":\"操作成功\",\"code\":0}',0,NULL,'2026-05-27 20:43:00',12);

/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_post`

--



DROP TABLE IF EXISTS `sys_post`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_post` (

  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',

  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',

  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',

  `post_sort` int NOT NULL COMMENT '显示顺序',

  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`post_id`)

) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_post`

--



LOCK TABLES `sys_post` WRITE;

/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;

INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2026-05-27 15:14:17','',NULL,''),(2,'se','项目经理',2,'0','admin','2026-05-27 15:14:17','',NULL,''),(3,'hr','人力资源',3,'0','admin','2026-05-27 15:14:17','',NULL,''),(4,'user','普通员工',4,'0','admin','2026-05-27 15:14:17','',NULL,'');

/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_role`

--



DROP TABLE IF EXISTS `sys_role`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_role` (

  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',

  `role_name` varchar(30) NOT NULL COMMENT '角色名称',

  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',

  `role_sort` int NOT NULL COMMENT '显示顺序',

  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',

  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',

  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`role_id`)

) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_role`

--



LOCK TABLES `sys_role` WRITE;

/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1','0','0','admin','2026-05-27 15:14:17','',NULL,'超级管理员'),(2,'普通角色','common',2,'2','0','0','admin','2026-05-27 15:14:17','',NULL,'普通角色'),(100,'教师','teacher',3,'1','0','0','','2026-05-27 20:31:49','',NULL,NULL),(101,'学生','student',4,'1','0','0','','2026-05-27 20:31:49','',NULL,NULL);

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_role_dept`

--



DROP TABLE IF EXISTS `sys_role_dept`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_role_dept` (

  `role_id` bigint NOT NULL COMMENT '角色ID',

  `dept_id` bigint NOT NULL COMMENT '部门ID',

  PRIMARY KEY (`role_id`,`dept_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_role_dept`

--



LOCK TABLES `sys_role_dept` WRITE;

/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;

INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);

/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_role_menu`

--



DROP TABLE IF EXISTS `sys_role_menu`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_role_menu` (

  `role_id` bigint NOT NULL COMMENT '角色ID',

  `menu_id` bigint NOT NULL COMMENT '菜单ID',

  PRIMARY KEY (`role_id`,`menu_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_role_menu`

--



LOCK TABLES `sys_role_menu` WRITE;

/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` VALUES (1,2000),(1,2001),(1,2002),(1,2003),(1,2004),(1,2005),(1,2006),(1,2007),(1,2008),(1,2009),(1,2010),(1,2011),(1,2012),(1,2013),(1,2014),(1,2015),(1,2016),(1,2017),(1,2018),(1,2019),(2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060),(2,1061);

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_user`

--



DROP TABLE IF EXISTS `sys_user`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_user` (

  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',

  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',

  `login_name` varchar(30) NOT NULL COMMENT '登录账号',

  `user_name` varchar(30) DEFAULT '' COMMENT '用户昵称',

  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户 01注册用户）',

  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',

  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',

  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',

  `avatar` varchar(100) DEFAULT '' COMMENT '头像路径',

  `password` varchar(50) DEFAULT '' COMMENT '密码',

  `salt` varchar(20) DEFAULT '' COMMENT '盐加密',

  `status` char(1) DEFAULT '0' COMMENT '账号状态（0正常 1停用）',

  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',

  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',

  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',

  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',

  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',

  `create_time` datetime DEFAULT NULL COMMENT '创建时间',

  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',

  `update_time` datetime DEFAULT NULL COMMENT '更新时间',

  `remark` varchar(500) DEFAULT NULL COMMENT '备注',

  PRIMARY KEY (`user_id`)

) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_user`

--



LOCK TABLES `sys_user` WRITE;

/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','29c67a30398638269fe600f73a054934','111111','0','0','127.0.0.1','2026-05-28 11:08:25',NULL,'admin','2026-05-27 15:14:17','',NULL,'管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','8e6d98b90472783cc73c17047ddccf36','222222','0','0','127.0.0.1',NULL,NULL,'admin','2026-05-27 15:14:17','',NULL,'测试员'),(100,NULL,'2021001001','张文博','00','','','0','','8379a64a3102477422bf26a612c7acd4','490439','0','0','127.0.0.1','2026-05-28 11:08:47',NULL,'','2026-05-27 20:31:49','',NULL,NULL),(101,NULL,'2021001002','李思雨','00','','','0','','4d6c4fe02de48fdb9682005d34ab3912','205436','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(102,NULL,'2021001003','王浩然','00','','','0','','40339770bc50665177af6c50366669de','065122','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(103,NULL,'2021002001','赵雅婷','00','','','0','','b04665e688754d604b255da93ecad95b','278183','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(104,NULL,'2021002002','陈志远','00','','','0','','4dd30afa4b1ecd1313fefe21ef366615','555445','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(105,NULL,'2021003001','刘佳琪','00','','','0','','b45e3ebc328cd01fe301de0e131577af','829857','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(106,NULL,'2021003002','孙明辉','00','','','0','','42958708d6a1237f69b2817d51008002','776996','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(107,NULL,'2021004001','周晓萌','00','','','0','','f0efca1037f0cbf3e37b55ebb0cba922','355435','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(108,NULL,'2021004002','吴雨桐','00','','','0','','5fda8949c7d2618b4f41843a27235453','109512','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(109,NULL,'2021005001','郑鹏飞','00','','','0','','24ff3db56b1b85d2799d019e890ed8c3','766252','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(110,NULL,'2021005002','黄诗涵','00','','','0','','1226d65fdc144f897c6527a36270e562','105612','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(111,NULL,'2021006001','林俊杰','00','','','0','','a75db6e59dd97bbbc073160cd6b56bb2','686207','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(112,NULL,'2021006002','杨雨晴','00','','','0','','7ea701af420fd4a0ddc2d0373a6e6f0d','131850','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(113,NULL,'T2021001','刘建国','00','','','0','','304460fe048901fd1bd21d67ae72218f','863645','0','0','127.0.0.1','2026-05-28 11:08:43',NULL,'','2026-05-27 20:31:49','',NULL,NULL),(114,NULL,'T2021002','陈晓燕','00','','','0','','c76ef8441b0069c0f00bb305ed5459a2','596044','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(115,NULL,'T2021003','杨伟强','00','','','0','','76158ecc60963e732e0b8014aa0eec84','726858','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(116,NULL,'T2021004','赵明远','00','','','0','','15c2b3d960571b5e352b70dcc6f6dc7e','547462','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(117,NULL,'T2021005','王丽华','00','','','0','','eacd6dced315df1b3c05775089fe9e47','171863','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(118,NULL,'T2021006','张海峰','00','','','0','','3be71188610949dd44fae746eaa24e53','821960','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL),(119,NULL,'T2021007','李芳菲','00','','','0','','7c10c31a3b9d46e2abdb15422140c7b2','875912','0','0','',NULL,NULL,'','2026-05-27 20:31:49','',NULL,NULL);

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_user_online`

--



DROP TABLE IF EXISTS `sys_user_online`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_user_online` (

  `sessionId` varchar(50) NOT NULL DEFAULT '' COMMENT '用户会话id',

  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',

  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',

  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',

  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',

  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',

  `os` varchar(50) DEFAULT '' COMMENT '操作系统',

  `status` varchar(10) DEFAULT '' COMMENT '在线状态on_line在线off_line离线',

  `start_timestamp` datetime DEFAULT NULL COMMENT 'session创建时间',

  `last_access_time` datetime DEFAULT NULL COMMENT 'session最后访问时间',

  `expire_time` int DEFAULT '0' COMMENT '超时时间，单位为分钟',

  `session_data` blob COMMENT '序列化的Session数据，用于服务重启后恢复会话',

  PRIMARY KEY (`sessionId`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='在线用户记录';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_user_online`

--



LOCK TABLES `sys_user_online` WRITE;

/*!40000 ALTER TABLE `sys_user_online` DISABLE KEYS */;

INSERT INTO `sys_user_online` VALUES ('509eade9-536c-4e87-9c93-f438322c14f7','T2021001',NULL,'127.0.0.1','内网IP','Chrome 148','Windows10','on_line','2026-05-28 10:47:37','2026-05-28 11:05:28',1800000,_binary '�\�\0sr\0+com.ruoyi.common.core.session.OnlineSession\0\0\0\0\0\0\0\0L\0avatart\0Ljava/lang/String;L\0browserq\0~\0L\0deptNameq\0~\0L\0hostq\0~\0L\0	loginNameq\0~\0L\0osq\0~\0L\0statust\0%Lcom/ruoyi/common/enums/OnlineStatus;L\0userIdt\0Ljava/lang/Long;xr\0*org.apache.shiro.session.mgt.SimpleSession���Ռbn\0\0xpw\0�t\0$509eade9-536c-4e87-9c93-f438322c14f7sr\0java.util.Datehj�KYt\0\0xpw\0\0�lz\�xsq\0~\0w\0\0�l�H0xw\0\0\0\0\0w@sr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0Hcom.ruoyi.framework.shiro.session.OnlineSessionDAOLAST_SYNC_DB_TIMESTAMPq\0~\0	t\0Porg.apache.shiro.subject.support.DefaultSubjectContext_AUTHENTICATED_SESSION_KEYsr\0java.lang.Boolean\� r�՜�\�\0Z\0valuexpt\0Morg.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEYsr\02org.apache.shiro.subject.SimplePrincipalCollection�X%ƣJ\0L\0realmPrincipalst\0Ljava/util/Map;xpsr\0java.util.LinkedHashMap4�N\\l��\0Z\0accessOrderxq\0~\0\n?@\0\0\0\0\0w\0\0\0\0\0\0t\0+com.ruoyi.framework.shiro.realm.UserRealm_0sr\0java.util.LinkedHashSet\�l\�Z�\�*\0\0xr\0java.util.HashSet�D�����4\0\0xpw\0\0\0?@\0\0\0\0\0sr\0+com.ruoyi.common.core.domain.entity.SysUser\0\0\0\0\0\0\0\0L\0avatarq\0~\0L\0delFlagq\0~\0L\0deptt\0-Lcom/ruoyi/common/core/domain/entity/SysDept;L\0deptIdq\0~\0L\0emailq\0~\0L\0	loginDatet\0Ljava/util/Date;L\0loginIpq\0~\0L\0	loginNameq\0~\0L\0parentIdq\0~\0L\0passwordq\0~\0L\0phonenumberq\0~\0[\0postIdst\0[Ljava/lang/Long;L\0\rpwdUpdateDateq\0~\0L\0roleIdq\0~\0[\0roleIdsq\0~\0L\0rolest\0Ljava/util/List;L\0saltq\0~\0L\0sexq\0~\0L\0statusq\0~\0L\0userIdq\0~\0L\0userNameq\0~\0L\0userTypeq\0~\0xr\0\'com.ruoyi.common.core.domain.BaseEntity\0\0\0\0\0\0\0\0L\0createByq\0~\0L\0\ncreateTimeq\0~\0L\0paramsq\0~\0L\0remarkq\0~\0L\0searchValueq\0~\0L\0updateByq\0~\0L\0\nupdateTimeq\0~\0xpt\0\0sq\0~\0w\0\0�ikoxpppt\0\0pt\0\0t\00sr\0+com.ruoyi.common.core.domain.entity.SysDept\0\0\0\0\0\0\0\0L\0	ancestorsq\0~\0L\0delFlagq\0~\0L\0deptIdq\0~\0L\0deptNameq\0~\0L\0emailq\0~\0L\0	excludeIdq\0~\0L\0leaderq\0~\0L\0orderNumt\0Ljava/lang/Integer;L\0parentIdq\0~\0L\0\nparentNameq\0~\0L\0phoneq\0~\0L\0statusq\0~\0xq\0~\0ppppppppppppppppppppt\0\0sq\0~\0w\0\0�lz8xt\0	127.0.0.1t\0T2021001pt\0 304460fe048901fd1bd21d67ae72218ft\0\0ppppsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0+com.ruoyi.common.core.domain.entity.SysRole\0\0\0\0\0\0\0\0Z\0flagL\0	dataScopeq\0~\0L\0delFlagq\0~\0[\0deptIdsq\0~\0[\0menuIdsq\0~\0L\0permissionst\0Ljava/util/Set;L\0roleIdq\0~\0L\0roleKeyq\0~\0L\0roleNameq\0~\0L\0roleSortq\0~\0L\0statusq\0~\0xq\0~\0ppppppp\0t\01pppsq\0~\0w\0\0\0?@\0\0\0\0\0\0xsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\�\0\0xp\0\0\0\0\0\0\0dt\0teachert\0教师t\03t\00xt\0863645t\00t\00sq\0~\06\0\0\0\0\0\0\0qt\0	刘建国t\000xx\0wq\0~\0xxxq\0~\0$t\0\nChrome 148pt\0	127.0.0.1q\0~\0,t\0	Windows10~r\0#com.ruoyi.common.enums.OnlineStatus\0\0\0\0\0\0\0\0\0\0xr\0java.lang.Enum\0\0\0\0\0\0\0\0\0\0xpt\0on_lineq\0~\0@'),('da1699b5-5284-41cb-9fe3-e755711cfe23','2021001001',NULL,'127.0.0.1','内网IP','Chrome 148','Windows10','on_line','2026-05-28 11:08:47','2026-05-28 11:08:47',1800000,_binary '�\�\0sr\0+com.ruoyi.common.core.session.OnlineSession\0\0\0\0\0\0\0\0L\0avatart\0Ljava/lang/String;L\0browserq\0~\0L\0deptNameq\0~\0L\0hostq\0~\0L\0	loginNameq\0~\0L\0osq\0~\0L\0statust\0%Lcom/ruoyi/common/enums/OnlineStatus;L\0userIdt\0Ljava/lang/Long;xr\0*org.apache.shiro.session.mgt.SimpleSession���Ռbn\0\0xpw\0�t\0$da1699b5-5284-41cb-9fe3-e755711cfe23sr\0java.util.Datehj�KYt\0\0xpw\0\0�l�R\�xsq\0~\0w\0\0�l�R�xw\0\0\0\0\0w@sr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0Hcom.ruoyi.framework.shiro.session.OnlineSessionDAOLAST_SYNC_DB_TIMESTAMPq\0~\0	t\0Porg.apache.shiro.subject.support.DefaultSubjectContext_AUTHENTICATED_SESSION_KEYsr\0java.lang.Boolean\� r�՜�\�\0Z\0valuexpt\0Morg.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEYsr\02org.apache.shiro.subject.SimplePrincipalCollection�X%ƣJ\0L\0realmPrincipalst\0Ljava/util/Map;xpsr\0java.util.LinkedHashMap4�N\\l��\0Z\0accessOrderxq\0~\0\n?@\0\0\0\0\0w\0\0\0\0\0\0t\0+com.ruoyi.framework.shiro.realm.UserRealm_0sr\0java.util.LinkedHashSet\�l\�Z�\�*\0\0xr\0java.util.HashSet�D�����4\0\0xpw\0\0\0?@\0\0\0\0\0sr\0+com.ruoyi.common.core.domain.entity.SysUser\0\0\0\0\0\0\0\0L\0avatarq\0~\0L\0delFlagq\0~\0L\0deptt\0-Lcom/ruoyi/common/core/domain/entity/SysDept;L\0deptIdq\0~\0L\0emailq\0~\0L\0	loginDatet\0Ljava/util/Date;L\0loginIpq\0~\0L\0	loginNameq\0~\0L\0parentIdq\0~\0L\0passwordq\0~\0L\0phonenumberq\0~\0[\0postIdst\0[Ljava/lang/Long;L\0\rpwdUpdateDateq\0~\0L\0roleIdq\0~\0[\0roleIdsq\0~\0L\0rolest\0Ljava/util/List;L\0saltq\0~\0L\0sexq\0~\0L\0statusq\0~\0L\0userIdq\0~\0L\0userNameq\0~\0L\0userTypeq\0~\0xr\0\'com.ruoyi.common.core.domain.BaseEntity\0\0\0\0\0\0\0\0L\0createByq\0~\0L\0\ncreateTimeq\0~\0L\0paramsq\0~\0L\0remarkq\0~\0L\0searchValueq\0~\0L\0updateByq\0~\0L\0\nupdateTimeq\0~\0xpt\0\0sq\0~\0w\0\0�ikoxpppt\0\0pt\0\0t\00sr\0+com.ruoyi.common.core.domain.entity.SysDept\0\0\0\0\0\0\0\0L\0	ancestorsq\0~\0L\0delFlagq\0~\0L\0deptIdq\0~\0L\0deptNameq\0~\0L\0emailq\0~\0L\0	excludeIdq\0~\0L\0leaderq\0~\0L\0orderNumt\0Ljava/lang/Integer;L\0parentIdq\0~\0L\0\nparentNameq\0~\0L\0phoneq\0~\0L\0statusq\0~\0xq\0~\0ppppppppppppppppppppt\0\0sq\0~\0w\0\0�lzX\�xt\0	127.0.0.1t\0\n2021001001pt\0 8379a64a3102477422bf26a612c7acd4t\0\0ppppsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0+com.ruoyi.common.core.domain.entity.SysRole\0\0\0\0\0\0\0\0Z\0flagL\0	dataScopeq\0~\0L\0delFlagq\0~\0[\0deptIdsq\0~\0[\0menuIdsq\0~\0L\0permissionst\0Ljava/util/Set;L\0roleIdq\0~\0L\0roleKeyq\0~\0L\0roleNameq\0~\0L\0roleSortq\0~\0L\0statusq\0~\0xq\0~\0ppppppp\0t\01pppsq\0~\0w\0\0\0?@\0\0\0\0\0\0xsr\0java.lang.Long;�\�̏#\�\0J\0valuexr\0java.lang.Number����\�\0\0xp\0\0\0\0\0\0\0et\0studentt\0学生t\04t\00xt\0490439t\00t\00sq\0~\06\0\0\0\0\0\0\0dt\0	张文博t\000xx\0wq\0~\0xxxq\0~\0$t\0\nChrome 148pt\0	127.0.0.1q\0~\0,t\0	Windows10~r\0#com.ruoyi.common.enums.OnlineStatus\0\0\0\0\0\0\0\0\0\0xr\0java.lang.Enum\0\0\0\0\0\0\0\0\0\0xpt\0on_lineq\0~\0@');

/*!40000 ALTER TABLE `sys_user_online` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_user_post`

--



DROP TABLE IF EXISTS `sys_user_post`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_user_post` (

  `user_id` bigint NOT NULL COMMENT '用户ID',

  `post_id` bigint NOT NULL COMMENT '岗位ID',

  PRIMARY KEY (`user_id`,`post_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_user_post`

--



LOCK TABLES `sys_user_post` WRITE;

/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;

INSERT INTO `sys_user_post` VALUES (1,1),(2,2);

/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `sys_user_role`

--



DROP TABLE IF EXISTS `sys_user_role`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `sys_user_role` (

  `user_id` bigint NOT NULL COMMENT '用户ID',

  `role_id` bigint NOT NULL COMMENT '角色ID',

  PRIMARY KEY (`user_id`,`role_id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `sys_user_role`

--



LOCK TABLES `sys_user_role` WRITE;

/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;

INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(100,4),(100,101),(101,4),(101,101),(102,4),(102,101),(103,4),(103,101),(104,4),(104,101),(105,4),(105,101),(106,4),(106,101),(107,4),(107,101),(108,4),(108,101),(109,4),(109,101),(110,4),(110,101),(111,4),(111,101),(112,4),(112,101),(113,3),(113,100),(114,3),(114,100),(115,3),(115,100),(116,3),(116,100),(117,3),(117,100),(118,3),(118,100),(119,3),(119,100);

/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;

UNLOCK TABLES;



--

-- Table structure for table `teacher`

--



DROP TABLE IF EXISTS `teacher`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;

/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `teacher` (

  `tno` char(8) NOT NULL,

  `tname` varchar(20) NOT NULL,

  `sex` char(1) DEFAULT NULL,

  `birth` date DEFAULT NULL,

  `rank` varchar(20) DEFAULT NULL,

  `salary` decimal(10,2) DEFAULT NULL,

  `password_hash` varchar(128) NOT NULL,

  `status` tinyint NOT NULL DEFAULT '1',

  `dept_id` int NOT NULL,

  `created_by` char(8) DEFAULT NULL,

  PRIMARY KEY (`tno`),

  KEY `idx_dept_id` (`dept_id`),

  KEY `fk_teacher_createdby` (`created_by`),

  CONSTRAINT `fk_teacher_createdby` FOREIGN KEY (`created_by`) REFERENCES `admin` (`admin_id`),

  CONSTRAINT `fk_teacher_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),

  CONSTRAINT `chk_teacher_sex` CHECK ((`sex` in ('男','女')))

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;



--

-- Dumping data for table `teacher`

--



LOCK TABLES `teacher` WRITE;

/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;

INSERT INTO `teacher` VALUES ('T2021001','刘建国','男','1978-04-20','教授',12000.00,'e10adc3949ba59abbe56e057f20f883e',1,1,NULL),('T2021002','陈晓燕','女','1982-09-15','副教授',9500.00,'e10adc3949ba59abbe56e057f20f883e',1,1,NULL),('T2021003','杨伟强','男','1975-12-08','教授',13000.00,'e10adc3949ba59abbe56e057f20f883e',1,2,NULL),('T2021004','赵明远','男','1985-06-30','讲师',7500.00,'e10adc3949ba59abbe56e057f20f883e',1,3,NULL),('T2021005','王丽华','女','1980-03-22','副教授',9000.00,'e10adc3949ba59abbe56e057f20f883e',1,4,NULL),('T2021006','张海峰','男','1976-08-14','教授',12500.00,'e10adc3949ba59abbe56e057f20f883e',1,5,NULL);

/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;

UNLOCK TABLES;

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;

/*!50003 SET @saved_cs_results     = @@character_set_results */ ;

/*!50003 SET @saved_col_connection = @@collation_connection */ ;

/*!50003 SET character_set_client  = gbk */ ;

/*!50003 SET character_set_results = gbk */ ;

/*!50003 SET collation_connection  = gbk_chinese_ci */ ;

/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;

DELIMITER ;;

/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_teacher_delete` BEFORE DELETE ON `teacher` FOR EACH ROW BEGIN

    DELETE FROM class WHERE tno = OLD.tno;

END */;;

DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;

/*!50003 SET character_set_client  = @saved_cs_client */ ;

/*!50003 SET character_set_results = @saved_cs_results */ ;

/*!50003 SET collation_connection  = @saved_col_connection */ ;



--

-- Temporary view structure for view `v_course_enrollment`

--



DROP TABLE IF EXISTS `v_course_enrollment`;

/*!50001 DROP VIEW IF EXISTS `v_course_enrollment`*/;

SET @saved_cs_client     = @@character_set_client;

/*!50503 SET character_set_client = utf8mb4 */;

/*!50001 CREATE VIEW `v_course_enrollment` AS SELECT 

 1 AS `cno`,

 1 AS `cname`,

 1 AS `credit`,

 1 AS `course_type`,

 1 AS `dept_name`,

 1 AS `teacher_name`,

 1 AS `class_time`,

 1 AS `semester`,

 1 AS `enrolled_count`,

 1 AS `avg_score`*/;

SET character_set_client = @saved_cs_client;



--

-- Temporary view structure for view `v_fail_students`

--



DROP TABLE IF EXISTS `v_fail_students`;

/*!50001 DROP VIEW IF EXISTS `v_fail_students`*/;

SET @saved_cs_client     = @@character_set_client;

/*!50503 SET character_set_client = utf8mb4 */;

/*!50001 CREATE VIEW `v_fail_students` AS SELECT 

 1 AS `sno`,

 1 AS `sname`,

 1 AS `cno`,

 1 AS `cname`,

 1 AS `semester`,

 1 AS `normal_score`,

 1 AS `test_score`,

 1 AS `total_score`*/;

SET character_set_client = @saved_cs_client;



--

-- Temporary view structure for view `v_student_grades`

--



DROP TABLE IF EXISTS `v_student_grades`;

/*!50001 DROP VIEW IF EXISTS `v_student_grades`*/;

SET @saved_cs_client     = @@character_set_client;

/*!50503 SET character_set_client = utf8mb4 */;

/*!50001 CREATE VIEW `v_student_grades` AS SELECT 

 1 AS `sno`,

 1 AS `sname`,

 1 AS `cno`,

 1 AS `cname`,

 1 AS `credit`,

 1 AS `semester`,

 1 AS `normal_score`,

 1 AS `test_score`,

 1 AS `total_score`,

 1 AS `grade_point`*/;

SET character_set_client = @saved_cs_client;



--

-- Temporary view structure for view `v_teacher_schedule`

--



DROP TABLE IF EXISTS `v_teacher_schedule`;

/*!50001 DROP VIEW IF EXISTS `v_teacher_schedule`*/;

SET @saved_cs_client     = @@character_set_client;

/*!50503 SET character_set_client = utf8mb4 */;

/*!50001 CREATE VIEW `v_teacher_schedule` AS SELECT 

 1 AS `tno`,

 1 AS `tname`,

 1 AS `rank`,

 1 AS `cno`,

 1 AS `cname`,

 1 AS `credit`,

 1 AS `semester`,

 1 AS `class_time`,

 1 AS `student_count`*/;

SET character_set_client = @saved_cs_client;



--

-- Dumping routines for database 'course_selection'

--

/*!50003 DROP PROCEDURE IF EXISTS `sp_student_gpa` */;

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;

/*!50003 SET @saved_cs_results     = @@character_set_results */ ;

/*!50003 SET @saved_col_connection = @@collation_connection */ ;

/*!50003 SET character_set_client  = gbk */ ;

/*!50003 SET character_set_results = gbk */ ;

/*!50003 SET collation_connection  = gbk_chinese_ci */ ;

/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;

DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_student_gpa`(IN p_sno CHAR(10), OUT p_gpa DECIMAL(5,2))

BEGIN

    DECLARE v_total_points DECIMAL(10,2) DEFAULT 0;

    DECLARE v_total_credit DECIMAL(5,1) DEFAULT 0;



    SELECT SUM(grade_point * credit), SUM(credit)

    INTO v_total_points, v_total_credit

    FROM v_student_grades

    WHERE sno = p_sno;



    IF v_total_credit > 0 THEN

        SET p_gpa = ROUND(v_total_points / v_total_credit, 2);

    ELSE

        SET p_gpa = 0;

    END IF;

END ;;

DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;

/*!50003 SET character_set_client  = @saved_cs_client */ ;

/*!50003 SET character_set_results = @saved_cs_results */ ;

/*!50003 SET collation_connection  = @saved_col_connection */ ;



--

-- Final view structure for view `v_course_enrollment`

--



/*!50001 DROP VIEW IF EXISTS `v_course_enrollment`*/;

/*!50001 SET @saved_cs_client          = @@character_set_client */;

/*!50001 SET @saved_cs_results         = @@character_set_results */;

/*!50001 SET @saved_col_connection     = @@collation_connection */;

/*!50001 SET character_set_client      = gbk */;

/*!50001 SET character_set_results     = gbk */;

/*!50001 SET collation_connection      = gbk_chinese_ci */;

/*!50001 CREATE ALGORITHM=UNDEFINED */

/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */

/*!50001 VIEW `v_course_enrollment` AS select `c`.`cno` AS `cno`,`c`.`cname` AS `cname`,`c`.`credit` AS `credit`,`c`.`course_type` AS `course_type`,`d`.`dept_name` AS `dept_name`,`t`.`tname` AS `teacher_name`,`cl`.`class_time` AS `class_time`,`cl`.`semester` AS `semester`,count(`cs`.`sno`) AS `enrolled_count`,round(avg(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6))),2) AS `avg_score` from ((((`course` `c` left join `courseselection` `cs` on((`c`.`cno` = `cs`.`cno`))) left join `class` `cl` on((`c`.`cno` = `cl`.`cno`))) left join `teacher` `t` on((`cl`.`tno` = `t`.`tno`))) join `department` `d` on((`c`.`dept_id` = `d`.`dept_id`))) group by `c`.`cno`,`c`.`cname`,`c`.`credit`,`c`.`course_type`,`d`.`dept_name`,`t`.`tname`,`cl`.`class_time`,`cl`.`semester` */;

/*!50001 SET character_set_client      = @saved_cs_client */;

/*!50001 SET character_set_results     = @saved_cs_results */;

/*!50001 SET collation_connection      = @saved_col_connection */;



--

-- Final view structure for view `v_fail_students`

--



/*!50001 DROP VIEW IF EXISTS `v_fail_students`*/;

/*!50001 SET @saved_cs_client          = @@character_set_client */;

/*!50001 SET @saved_cs_results         = @@character_set_results */;

/*!50001 SET @saved_col_connection     = @@collation_connection */;

/*!50001 SET character_set_client      = gbk */;

/*!50001 SET character_set_results     = gbk */;

/*!50001 SET collation_connection      = gbk_chinese_ci */;

/*!50001 CREATE ALGORITHM=UNDEFINED */

/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */

/*!50001 VIEW `v_fail_students` AS select `s`.`sno` AS `sno`,`s`.`sname` AS `sname`,`c`.`cno` AS `cno`,`c`.`cname` AS `cname`,`cs`.`semester` AS `semester`,`cs`.`normal_score` AS `normal_score`,`cs`.`test_score` AS `test_score`,round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) AS `total_score` from ((`student` `s` join `courseselection` `cs` on((`s`.`sno` = `cs`.`sno`))) join `course` `c` on((`cs`.`cno` = `c`.`cno`))) where (((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)) < 60) */;

/*!50001 SET character_set_client      = @saved_cs_client */;

/*!50001 SET character_set_results     = @saved_cs_results */;

/*!50001 SET collation_connection      = @saved_col_connection */;



--

-- Final view structure for view `v_student_grades`

--



/*!50001 DROP VIEW IF EXISTS `v_student_grades`*/;

/*!50001 SET @saved_cs_client          = @@character_set_client */;

/*!50001 SET @saved_cs_results         = @@character_set_results */;

/*!50001 SET @saved_col_connection     = @@collation_connection */;

/*!50001 SET character_set_client      = gbk */;

/*!50001 SET character_set_results     = gbk */;

/*!50001 SET collation_connection      = gbk_chinese_ci */;

/*!50001 CREATE ALGORITHM=UNDEFINED */

/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */

/*!50001 VIEW `v_student_grades` AS select `s`.`sno` AS `sno`,`s`.`sname` AS `sname`,`c`.`cno` AS `cno`,`c`.`cname` AS `cname`,`c`.`credit` AS `credit`,`cs`.`semester` AS `semester`,`cs`.`normal_score` AS `normal_score`,`cs`.`test_score` AS `test_score`,round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) AS `total_score`,(case when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 90) then 4.0 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 85) then 3.7 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 82) then 3.3 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 78) then 3.0 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 75) then 2.7 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 72) then 2.3 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 68) then 2.0 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 64) then 1.5 when (round(((`cs`.`normal_score` * 0.4) + (`cs`.`test_score` * 0.6)),2) >= 60) then 1.0 else 0 end) AS `grade_point` from ((`student` `s` join `courseselection` `cs` on((`s`.`sno` = `cs`.`sno`))) join `course` `c` on((`cs`.`cno` = `c`.`cno`))) */;

/*!50001 SET character_set_client      = @saved_cs_client */;

/*!50001 SET character_set_results     = @saved_cs_results */;

/*!50001 SET collation_connection      = @saved_col_connection */;



--

-- Final view structure for view `v_teacher_schedule`

--



/*!50001 DROP VIEW IF EXISTS `v_teacher_schedule`*/;

/*!50001 SET @saved_cs_client          = @@character_set_client */;

/*!50001 SET @saved_cs_results         = @@character_set_results */;

/*!50001 SET @saved_col_connection     = @@collation_connection */;

/*!50001 SET character_set_client      = gbk */;

/*!50001 SET character_set_results     = gbk */;

/*!50001 SET collation_connection      = gbk_chinese_ci */;

/*!50001 CREATE ALGORITHM=UNDEFINED */

/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */

/*!50001 VIEW `v_teacher_schedule` AS select `t`.`tno` AS `tno`,`t`.`tname` AS `tname`,`t`.`rank` AS `rank`,`c`.`cno` AS `cno`,`c`.`cname` AS `cname`,`c`.`credit` AS `credit`,`cl`.`semester` AS `semester`,`cl`.`class_time` AS `class_time`,count(`cs`.`sno`) AS `student_count` from (((`teacher` `t` join `class` `cl` on((`t`.`tno` = `cl`.`tno`))) join `course` `c` on((`cl`.`cno` = `c`.`cno`))) left join `courseselection` `cs` on((`c`.`cno` = `cs`.`cno`))) group by `t`.`tno`,`t`.`tname`,`t`.`rank`,`c`.`cno`,`c`.`cname`,`c`.`credit`,`cl`.`semester`,`cl`.`class_time` */;

/*!50001 SET character_set_client      = @saved_cs_client */;

/*!50001 SET character_set_results     = @saved_cs_results */;

/*!50001 SET collation_connection      = @saved_col_connection */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



-- Dump completed on 2026-05-28 11:22:23

