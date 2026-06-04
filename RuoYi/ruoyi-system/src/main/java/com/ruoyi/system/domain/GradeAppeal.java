package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 成绩申诉表 grade_appeal
 */
public class GradeAppeal
{
    private Long appealId;
    private String sno;
    private String cno;
    private String semester;
    private String reason;
    private Integer status;
    private String reply;
    private String handler;
    private Date createTime;
    private Date handleTime;

    // 非数据库字段，用于列表展示
    private String sname;
    private String cname;

    public Long getAppealId() { return appealId; }
    public void setAppealId(Long appealId) { this.appealId = appealId; }

    public String getSno() { return sno; }
    public void setSno(String sno) { this.sno = sno; }

    public String getCno() { return cno; }
    public void setCno(String cno) { this.cno = cno; }

    public String getSemester() { return semester; }
    public void setSemester(String semester) { this.semester = semester; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }

    public String getHandler() { return handler; }
    public void setHandler(String handler) { this.handler = handler; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public Date getHandleTime() { return handleTime; }
    public void setHandleTime(Date handleTime) { this.handleTime = handleTime; }

    public String getSname() { return sname; }
    public void setSname(String sname) { this.sname = sname; }

    public String getCname() { return cname; }
    public void setCname(String cname) { this.cname = cname; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("appealId", getAppealId())
            .append("sno", getSno())
            .append("cno", getCno())
            .append("semester", getSemester())
            .append("status", getStatus())
            .append("handler", getHandler())
            .toString();
    }
}
