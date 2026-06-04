package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class CourseNotice
{
    private Long noticeId;
    private String cno;
    private String tno;
    private String title;
    private String content;
    private Date createTime;

    /** 非数据库字段 - 展示用 */
    private String cname;
    private String tname;

    public Long getNoticeId() { return noticeId; }
    public void setNoticeId(Long noticeId) { this.noticeId = noticeId; }

    public String getCno() { return cno; }
    public void setCno(String cno) { this.cno = cno; }

    public String getTno() { return tno; }
    public void setTno(String tno) { this.tno = tno; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public String getCname() { return cname; }
    public void setCname(String cname) { this.cname = cname; }

    public String getTname() { return tname; }
    public void setTname(String tname) { this.tname = tname; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("noticeId", getNoticeId())
            .append("cno", getCno())
            .append("tno", getTno())
            .append("title", getTitle())
            .append("content", getContent())
            .append("createTime", getCreateTime())
            .toString();
    }
}
