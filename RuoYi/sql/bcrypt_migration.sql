-- BCrypt密码升级：扩展password_hash字段长度以兼容BCrypt（约60字符输出）
ALTER TABLE student MODIFY COLUMN password_hash VARCHAR(255);
ALTER TABLE teacher MODIFY COLUMN password_hash VARCHAR(255);
ALTER TABLE sys_user MODIFY COLUMN password VARCHAR(255);
