# 关系模式（v3 — 安全增强版）

## 1. 学院

> 学院(==院系编号==, 院系名称, 地址, 电话)
> 
> 对应库表: department(==dept_id==, dept_name, address, phone_code)

## 2. 管理员

> 管理员(==工号==, 姓名, 密码哈希, 账号状态, 创建时间)
> > 账号状态：0-禁用，1-正常
>
> 对应库表: admin(==admin_id==, admin_name, password_hash, status, created_at)

## 3. 学生

> 学生(==学号==, 姓名, 性别, 出生日期, 籍贯, 手机号, 密码哈希, 账号状态, 院系编号, 创建管理员工号)
> > 手机号属个人敏感信息（PII），应用层日志不打印此字段
>
> 对应库表: student(==sno==, sname, sex, birth, native_place, phone, password_hash, status, dept_id, created_by)
>
> FK: 院系编号 → 学院, 创建管理员工号 → 管理员

## 4. 教师

> 教师(==工号==, 姓名, 性别, 出生日期, 职称, 薪资, 密码哈希, 账号状态, 院系编号, 创建管理员工号)
>
> 对应库表: teacher(==tno==, tname, sex, birth, rank, salary, password_hash, status, dept_id, created_by)
>
> FK: 院系编号 → 学院, 创建管理员工号 → 管理员

## 5. 课程

> 课程(==课程号==, 课程名, 学分, 学时, 课程类型, 院系编号, 审核管理员工号)
> > 课程类型：0 必修，1 选修
>
> 对应库表: course(==cno==, cname, credit, hours, course_type, dept_id, admin_id)
>
> FK: 院系编号 → 学院, 审核管理员工号 → 管理员

## 6. 选课（M:N 联系）

> 选课(==(学号, 课程号)==, 学期, 平时成绩, 考试成绩)
>
> 对应库表: courseselection(==(sno, cno)==, semester, normal_score, test_score)
>
> PK: (学号, 课程号)
> FK: 学号 → 学生, 课程号 → 课程
>
> > 总评成绩不存储，通过 `平时×40% + 考试×60%` 实时计算，消除 3NF 传递依赖。

## 7. 授课（M:N 联系）

> 授课(==(教师工号, 课程号)==, 学期, 上课时间, 审核管理员工号)
> > 管理员审核教师开课后，在此表建立授课记录
>
> 对应库表: class(==(tno, cno)==, semester, class_time, admin_id)
>
> PK: (教师工号, 课程号)
> FK: 教师工号 → 教师, 课程号 → 课程, 审核管理员工号 → 管理员

## 8. 审计日志（安全审计）

> 审计日志(==日志编号==, 管理员工号, 操作, 详情, 来源IP, 操作时间)
>
> 对应库表: audit_log(==log_id==, admin_id, action, detail, ip_addr, created_at)
>
> FK: 管理员工号 → 管理员
>
> > 记录管理员的关键操作（审核开课、设置选课时间段、创建/禁用账号等），实现操作可追溯。
