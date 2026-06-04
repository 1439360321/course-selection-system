-- course 表添加审核状态字段
-- 0=待审核 1=已通过 2=已驳回
ALTER TABLE course ADD COLUMN status TINYINT DEFAULT 1 COMMENT '0=待审核 1=已通过 2=已驳回';
ALTER TABLE course ADD COLUMN reject_reason VARCHAR(500) COMMENT '驳回理由';
