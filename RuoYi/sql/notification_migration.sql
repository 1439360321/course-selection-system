-- =============================================
-- 通知中心迁移脚本
-- 统一通知系统，服务所有角色（admin/teacher/student）
-- =============================================

CREATE TABLE IF NOT EXISTS notification (
    notif_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '通知ID',
    recipient_type VARCHAR(20) NOT NULL COMMENT '接收者类型: admin/teacher/student',
    recipient_id VARCHAR(50) NOT NULL COMMENT '接收者标识',
    title VARCHAR(200) NOT NULL COMMENT '通知标题',
    content VARCHAR(1000) COMMENT '通知内容',
    is_read TINYINT DEFAULT 0 COMMENT '是否已读: 0未读 1已读',
    source_type VARCHAR(50) COMMENT '来源类型: course_proposal/appeal/evaluation/notice/system',
    source_id VARCHAR(50) COMMENT '来源ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知表';

-- 索引
CREATE INDEX idx_notif_recipient ON notification(recipient_type, recipient_id, is_read);
CREATE INDEX idx_notif_create_time ON notification(create_time);
