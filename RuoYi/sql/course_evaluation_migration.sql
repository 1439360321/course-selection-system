-- 课程评价表
-- 学生对自己选过的课程进行评价（1-5星），教师可查看汇总结果

CREATE TABLE IF NOT EXISTS course_evaluation (
    eval_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sno CHAR(10) NOT NULL,
    cno CHAR(8) NOT NULL,
    tno CHAR(8) NOT NULL,
    semester VARCHAR(20),
    rating TINYINT NOT NULL COMMENT '1-5星评分',
    comment VARCHAR(500),
    is_anonymous TINYINT DEFAULT 0 COMMENT '0=实名 1=匿名',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sno) REFERENCES student(sno),
    FOREIGN KEY (cno) REFERENCES course(cno),
    FOREIGN KEY (tno) REFERENCES teacher(tno),
    UNIQUE KEY uk_sno_cno (sno, cno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
