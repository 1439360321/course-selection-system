-- 成绩申诉表
-- 学生发起申诉 → 教师处理 → 管理员监督

CREATE TABLE IF NOT EXISTS grade_appeal (
    appeal_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sno CHAR(10) NOT NULL,
    cno CHAR(8) NOT NULL,
    semester VARCHAR(20),
    reason VARCHAR(500) NOT NULL,
    status TINYINT DEFAULT 0 COMMENT '0=待处理 1=已同意 2=已驳回',
    reply VARCHAR(500),
    handler VARCHAR(50),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    handle_time DATETIME,
    FOREIGN KEY (sno) REFERENCES student(sno),
    FOREIGN KEY (cno) REFERENCES course(cno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
