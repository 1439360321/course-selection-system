-- ============================================
-- 测试数据补充：用于验证新增功能
-- ============================================

-- 1. 补充课程数据（含status字段，用于验证开课审核）
INSERT INTO course (cno, cname, credit, hours, course_type, dept_id, admin_id, max_students, status) VALUES
('C010', '网络安全基础', 3.0, 48, 0, 1, 'A001', 60, 1),
('C011', '密码学原理', 3.5, 56, 0, 1, 'A001', 50, 1),
('C012', 'Web安全实践', 2.5, 40, 1, 1, 'A001', 40, 1),
('C013', '操作系统安全', 3.0, 48, 0, 2, 'A001', 55, 1),
('C014', '网络攻防实战', 2.0, 32, 1, 2, 'A001', 35, 0)
ON DUPLICATE KEY UPDATE cname=VALUES(cname);

-- 2. 补充课程公告测试数据
INSERT INTO course_notice (cno, tno, title, content) VALUES
('C001', 'T2021001', '关于数据库原理第一次作业', '请同学们在本周内完成第一章课后习题1-5题，下周一上课提交。'),
('C001', 'T2021001', '数据库实验课时间调整', '由于机房维护，本周五的实验课顺延至下周一同一时间。'),
('C002', 'T2021002', '数据结构期中考试通知', '期中考试将于第8周进行，考试范围为第1-7章，请同学们做好准备。'),
('C010', 'T2021003', '网络安全课程实验说明', '本学期实验内容包括：密码破解、SQL注入、XSS攻击与防护，请提前安装Kali Linux虚拟机。')
ON DUPLICATE KEY UPDATE title=VALUES(title);

-- 3. 补充登录记录（用于安全仪表盘验证）
INSERT INTO sys_logininfor (login_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES
('2021001001', '192.168.1.101', '内网', 'Chrome 120', 'Windows 10', 1, '密码错误', NOW()),
('2021001001', '192.168.1.101', '内网', 'Chrome 120', 'Windows 10', 1, '密码错误', NOW()),
('T2021001', '10.0.0.55', '内网', 'Firefox 121', 'Windows 11', 1, '密码错误', NOW()),
('admin', '192.168.1.1', '内网', 'Edge 120', 'Windows 10', 0, '登录成功', NOW()),
('2021001002', '192.168.1.102', '内网', 'Chrome 120', 'Windows 10', 0, '登录成功', NOW()),
('T2021001', '10.0.0.55', '内网', 'Firefox 121', 'Windows 11', 0, '登录成功', NOW());

-- 4. 补充选课记录（用于评教、申诉、成绩验证）
INSERT INTO courseselection (sno, cno, semester, normal_score, test_score) VALUES
('2021001001', 'C010', '2025-2026-2', 85, 78),
('2021001001', 'C011', '2025-2026-2', 92, 88),
('2021001002', 'C010', '2025-2026-2', 76, 70),
('2021001002', 'C003', '2025-2026-2', 88, 82),
('2021001003', 'C012', '2025-2026-2', 65, 58),
('2021001003', 'C004', '2025-2026-2', 90, 85)
ON DUPLICATE KEY UPDATE normal_score=VALUES(normal_score);

-- 5. 补充授课分配
INSERT INTO class (tno, cno, semester, class_time, exam_time, admin_id) VALUES
('T2021003', 'C010', '2025-2026-2', '周三 3-4节', '2025-07-10 09:00-11:00', 'A001'),
('T2021003', 'C011', '2025-2026-2', '周四 5-6节', '2025-07-12 14:00-16:00', 'A001'),
('T2021001', 'C012', '2025-2026-2', '周五 1-2节', '2025-07-14 09:00-11:00', 'A001')
ON DUPLICATE KEY UPDATE class_time=VALUES(class_time);

-- 6. 选课时间窗口配置
INSERT IGNORE INTO sys_config (config_name, config_key, config_value, config_type, create_by, create_time, remark)
VALUES
('选课开始时间', 'course.selection.start', '', 'Y', 'admin', NOW(), '选课开放开始时间，格式yyyy-MM-dd HH:mm:ss，留空表示不限制'),
('选课结束时间', 'course.selection.end', '', 'Y', 'admin', NOW(), '选课截止时间，格式yyyy-MM-dd HH:mm:ss，留空表示不限制'),
('总学分要求', 'course.credit.total', '130', 'Y', 'admin', NOW(), '毕业所需总学分'),
('必修学分要求', 'course.credit.required', '80', 'Y', 'admin', NOW(), '毕业所需必修学分'),
('选修学分要求', 'course.credit.elective', '50', 'Y', 'admin', NOW(), '毕业所需选修学分');
