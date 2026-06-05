-- ============================================
-- 选课系统菜单修复迁移脚本
-- 1. 新增教师/学生侧边栏缺失的核心功能菜单
-- 2. 调整现有子菜单排序
-- 3. 移除消息中心权限
-- ============================================

-- 1. 新增教师核心功能菜单 (parent_id=2018 教师工作台)
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, remark)
VALUES
(2035, '课程管理', 2018, 1, '/teacher/course', 'C', '0', 'teacher:course:view', '#', 'admin', NOW(), '查看自己的授课课程'),
(2036, '我的课表', 2018, 2, '/teacher/schedule', 'C', '0', 'teacher:schedule:view', '#', 'admin', NOW(), '查看教师课表'),
(2037, '成绩统计', 2018, 3, '/teacher/statistics', 'C', '0', 'teacher:statistics:view', '#', 'admin', NOW(), '查看学生成绩统计');

-- 2. 调整教师现有子菜单排序 (向后推移)
UPDATE sys_menu SET order_num = 4 WHERE menu_id = 2024; -- 开课申请
UPDATE sys_menu SET order_num = 5 WHERE menu_id = 2025; -- 课程公告
UPDATE sys_menu SET order_num = 6 WHERE menu_id = 2026; -- 学生评价
UPDATE sys_menu SET order_num = 7 WHERE menu_id = 2027; -- 成绩申诉
UPDATE sys_menu SET order_num = 8 WHERE menu_id = 2028; -- 个人设置

-- 3. 新增学生核心功能菜单 (parent_id=2019 学生工作台)
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, remark)
VALUES
(2038, '浏览课程', 2019, 1, '/student/course', 'C', '0', 'student:course:view', '#', 'admin', NOW(), '浏览可选课程并选课'),
(2039, '我的选课', 2019, 2, '/student/course/my', 'C', '0', 'student:course:own:view', '#', 'admin', NOW(), '查看已选课程和退课'),
(2040, '成绩查询', 2019, 3, '/student/grade', 'C', '0', 'student:grade:view', '#', 'admin', NOW(), '查询各科成绩'),
(2041, '我的课表', 2019, 4, '/student/schedule', 'C', '0', 'student:schedule:view', '#', 'admin', NOW(), '查看个人课表'),
(2042, '考试时间', 2019, 5, '/student/exam', 'C', '0', 'student:exam:view', '#', 'admin', NOW(), '查看考试时间安排');

-- 4. 调整学生现有子菜单排序 (向后推移)
UPDATE sys_menu SET order_num = 6 WHERE menu_id = 2029; -- 课程公告
UPDATE sys_menu SET order_num = 7 WHERE menu_id = 2030; -- 学生评教
UPDATE sys_menu SET order_num = 8 WHERE menu_id = 2031; -- 成绩申诉
UPDATE sys_menu SET order_num = 9 WHERE menu_id = 2032; -- 学分统计
UPDATE sys_menu SET order_num = 10 WHERE menu_id = 2033; -- 个人设置

-- 5. 分配新菜单给角色
-- 教师角色(100): 新增菜单 2035,2036,2037
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (100, 2035), (100, 2036), (100, 2037);
-- 学生角色(101): 新增菜单 2038,2039,2040,2041,2042
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (101, 2038), (101, 2039), (101, 2040), (101, 2041), (101, 2042);

-- 6. 移除消息中心权限 (menu_id=2034)
DELETE FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2034;
DELETE FROM sys_role_menu WHERE role_id = 101 AND menu_id = 2034;

-- 验证
SELECT '教师菜单(共' || COUNT(*) || '项):' AS summary FROM sys_role_menu WHERE role_id = 100;
SELECT '学生菜单(共' || COUNT(*) || '项):' AS summary FROM sys_role_menu WHERE role_id = 101;
