# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## 项目概述

选课系统（Course Selection System），基于若依 RuoYi v4.8.3（Spring Boot 4.x + JDK 17）的单体应用。数据库原理课程项目，3 人小组。

**当前阶段**：业务代码已完成，功能测试中。管理员 CRUD、教师端、学生端均已开发。详细进度见 `memory/project_status.md`。

## 常用命令

```bash
# 编译打包（跳过测试）
cd RuoYi && mvn clean package -Dmaven.test.skip=true

# 运行（打包后在 ruoyi-admin/target/ 下）
java -jar ruoyi-admin/target/ruoyi-admin.jar

# 开发模式直接运行（需要 Maven + JDK 17）
cd RuoYi && mvn spring-boot:run -pl ruoyi-admin

# 仅编译检查
cd RuoYi && mvn clean compile
```

或者用 Windows 脚本：`RuoYi/bin/package.bat` → `RuoYi/bin/run.bat`

## 模块架构

```
RuoYi/                          # Maven 父 POM，modules:
├── ruoyi-admin/                # 入口模块（Spring Boot 启动类 + Web 控制器）
│   └── web/controller/
│       ├── common/             # 通用控制器（首页、文件上传）
│       ├── system/             # 系统管理控制器（用户、角色、菜单等）
│       ├── monitor/            # 监控控制器（Druid、Server、日志）
│       └── tool/               # 工具控制器
├── ruoyi-common/               # 公共工具（annotation/config/enums/utils/xss）
├── ruoyi-framework/            # 框架层（Shiro安全/Druid数据源/拦截器/AOP）
├── ruoyi-system/               # 系统模块（domain + mapper + service）
│   ├── domain/                 # 实体类（SysUser, SysRole, SysDept 等）
│   ├── mapper/                 # MyBatis XML 接口
│   └── service/ + impl/        # 业务服务层
├── ruoyi-quartz/               # 定时任务
└── ruoyi-generator/            # 代码生成器（Velocity 模板）
```

**分层调用**: Controller → Service → Mapper(MyBatis) → MySQL

## 技术栈

- **后端**: Spring Boot 4.0.3 + MyBatis + Apache Shiro（认证授权）+ Thymeleaf 模板
- **数据库**: MySQL 8.x，Druid 连接池（含 SQL 监控）
- **前端**: H+ UI 模板（jQuery + Bootstrap 3.x），非前后端分离
- **缓存**: Ehcache（Shiro session 缓存）
- **工具**: PageHelper 分页、fastjson、Apache POI（Excel）、SpringDoc（API 文档）

## 关键配置

- **端口**: 80（`application.yml` → `server.port`）
- **数据库**: `jdbc:mysql://localhost:3306/ry`（`application-druid.yml`）
- **登录**: `admin/admin123`（默认账户，密码在数据库的 sys_user 表）
- **验证码**: 默认开启（数学计算类型），开发可在 `shiro.user.captchaEnabled` 关闭
- **API 文档**: 启动后访问 `/swagger-ui.html`

## 数据库设计（课程相关）

设计文档在 `docs/` 目录：
- `er-diagram.md` — ER 图（5 实体 + 8 联系）
- `relation-schema.md` — 关系模式（7 张业务表 + 审计日志表）

建表顺序（外键依赖）：department → admin → student → teacher → course → class → courseselection

## 业务代码添加指南

在此项目中添加选课系统业务代码，遵循若依现有模式：

1. **实体类**: 在 `ruoyi-system/domain/` 新增（如 `Student.java`、`Course.java`）
2. **Mapper**: 在 `ruoyi-system/mapper/` 新增接口 + 对应 XML 在 `ruoyi-admin/resources/mapper/`
3. **Service**: 在 `ruoyi-system/service/` 新增接口，`service/impl/` 新增实现
4. **Controller**: 在 `ruoyi-admin/web/controller/` 新增（如 `course/CourseController.java`）
5. **前端**: 在 `ruoyi-admin/resources/templates/` 新增 Thymeleaf 模板
