package com.ruoyi.system.domain;

import java.time.LocalDateTime;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 安全审计日志实体 audit_log
 *
 * @author course-selection-team
 */
public class AuditLog
{
    private Long logId;
    private String adminId;
    private String action;
    private String detail;
    private String ipAddr;
    private LocalDateTime createdAt;

    public Long getLogId() { return logId; }
    public void setLogId(Long logId) { this.logId = logId; }

    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getDetail() { return detail; }
    public void setDetail(String detail) { this.detail = detail; }

    public String getIpAddr() { return ipAddr; }
    public void setIpAddr(String ipAddr) { this.ipAddr = ipAddr; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("logId", getLogId())
            .append("adminId", getAdminId())
            .append("action", getAction())
            .append("detail", getDetail())
            .append("ipAddr", getIpAddr())
            .append("createdAt", getCreatedAt())
            .toString();
    }
}
