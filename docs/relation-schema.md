# 关系模式

## 1. 学院 (Department)

> 学院(**院系编号**, 院系名称, 地址, 电话)
>
> `department(**dept_id** INT AUTO_INCREMENT, dept_name VARCHAR UNIQUE, address VARCHAR, phone_code VARCHAR)`

## 2. 管理员 (Admin)

> 管理员(**工号**, 姓名, 密码哈希, 账号状态, 创建时间)
>
> `admin(**admin_id** CHAR(8), admin_name VARCHAR, password_hash VARCHAR(255), status TINYINT, created_at DATETIME)`

## 3. 学生 (Student)

> 学生(**学号**, 姓名, 性别, 出生日期, 籍贯, 手机号, 密码哈希, 账号状态, 院系编号, 创建管理员工号)
>
> `student(**sno** CHAR(10), sname VARCHAR, sex CHAR(2) CHECK('男','女'), birth DATE, native_place VARCHAR, phone VARCHAR, password_hash VARCHAR(255), status TINYINT, dept_id INT, created_by CHAR(8))`
> FK: dept_id → department, created_by → admin

## 4. 教师 (Teacher)

> 教师(**工号**, 姓名, 性别, 出生日期, 职称, 薪资, 密码哈希, 账号状态, 院系编号, 创建管理员工号)
>
> `teacher(**tno** CHAR(8), tname VARCHAR, sex CHAR(2), birth DATE, rank VARCHAR, salary DECIMAL(10,2), password_hash VARCHAR(255), status TINYINT, dept_id INT, created_by CHAR(8))`
> FK: dept_id → department, created_by → admin

## 5. 课程 (Course)

> 课程(**课程号**, 课程名, 学分, 学时, 课程类型, 最大容量, 审核状态, 驳回理由, 院系编号, 管理员工号)
>
> `course(**cno** CHAR(8), cname VARCHAR, credit DECIMAL(3,1), hours INT, course_type TINYINT CHECK(0,1), max_students INT, status TINYINT(0=待审/1=通过/2=驳回), reject_reason VARCHAR(500), dept_id INT, admin_id CHAR(8))`
> FK: dept_id → department, admin_id → admin

## 6. 授课 (Class)

> 授课(**师资号, 课程号**, 学期, 上课时间, 考试时间, 管理员工号)
>
> `class(**tno** CHAR(8), **cno** CHAR(8), semester VARCHAR, class_time VARCHAR, exam_time VARCHAR, admin_id CHAR(8))`
> PK: (tno, cno), FK: tno → teacher, cno → course, admin_id → admin

## 7. 选课 (CourseSelection)

> 选课(**学号, 课程号**, 学期, 平时成绩, 考试成绩)
>
> `courseselection(**sno** CHAR(10), **cno** CHAR(8), semester VARCHAR, normal_score DECIMAL(5,1), test_score DECIMAL(5,1))`
> PK: (sno, cno), FK: sno → student, cno → course
>
> 总评 = 平时×40% + 考试×60%（实时计算，不存储，满足 3NF）

## 8. 审计日志 (AuditLog)

> `audit_log(**log_id** BIGINT AUTO_INCREMENT, admin_id CHAR(8), action VARCHAR, detail TEXT, ip_addr VARCHAR, created_at DATETIME)`
> FK: admin_id → admin

## 9. 课程公告 (CourseNotice) 🆕

> `course_notice(**notice_id** BIGINT AUTO_INCREMENT, cno CHAR(8), tno CHAR(8), title VARCHAR, content TEXT, create_time DATETIME)`
> FK: cno → course, tno → teacher

## 10. 学生评教 (CourseEvaluation) 🆕

> `course_evaluation(**eval_id** BIGINT AUTO_INCREMENT, sno CHAR(10), cno CHAR(8), tno CHAR(8), semester VARCHAR, rating TINYINT(1-5), comment VARCHAR(500), is_anonymous TINYINT, create_time DATETIME)`
> FK: sno → student, cno → course, UNIQUE(sno, cno)

## 11. 成绩申诉 (GradeAppeal) 🆕

> `grade_appeal(**appeal_id** BIGINT AUTO_INCREMENT, sno CHAR(10), cno CHAR(8), semester VARCHAR, reason VARCHAR(500), status TINYINT(0=待处理/1=已同意/2=已驳回), reply VARCHAR(500), handler VARCHAR, handle_time DATETIME, create_time DATETIME)`
> FK: sno → student, cno → course

## 12. 消息通知 (Notification) 🆕

> `notification(**notif_id** BIGINT AUTO_INCREMENT, recipient_type VARCHAR(admin/teacher/student), recipient_id VARCHAR, title VARCHAR, content VARCHAR(1000), is_read TINYINT, source_type VARCHAR, source_id VARCHAR, create_time DATETIME)`
