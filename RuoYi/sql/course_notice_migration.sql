-- ----------------------------
-- 课程通知表（B3 课程公告）
-- ----------------------------
drop table if exists course_notice;
CREATE TABLE course_notice (
    notice_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cno CHAR(8) NOT NULL,
    tno CHAR(8) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cno) REFERENCES course(cno),
    FOREIGN KEY (tno) REFERENCES teacher(tno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
