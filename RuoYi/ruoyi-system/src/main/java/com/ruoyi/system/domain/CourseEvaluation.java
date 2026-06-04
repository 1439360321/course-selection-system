package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 课程评价表 course_evaluation
 */
public class CourseEvaluation
{
    private Long evalId;
    private String sno;
    private String cno;
    private String tno;
    private String semester;
    private Integer rating;
    private String comment;
    private Integer isAnonymous;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    // 非数据库字段，用于列表展示
    private String sname;
    private String cname;

    public Long getEvalId() { return evalId; }
    public void setEvalId(Long evalId) { this.evalId = evalId; }

    public String getSno() { return sno; }
    public void setSno(String sno) { this.sno = sno; }

    public String getCno() { return cno; }
    public void setCno(String cno) { this.cno = cno; }

    public String getTno() { return tno; }
    public void setTno(String tno) { this.tno = tno; }

    public String getSemester() { return semester; }
    public void setSemester(String semester) { this.semester = semester; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Integer getIsAnonymous() { return isAnonymous; }
    public void setIsAnonymous(Integer isAnonymous) { this.isAnonymous = isAnonymous; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public String getSname() { return sname; }
    public void setSname(String sname) { this.sname = sname; }

    public String getCname() { return cname; }
    public void setCname(String cname) { this.cname = cname; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("evalId", getEvalId())
            .append("sno", getSno())
            .append("cno", getCno())
            .append("tno", getTno())
            .append("semester", getSemester())
            .append("rating", getRating())
            .append("comment", getComment())
            .append("isAnonymous", getIsAnonymous())
            .append("createTime", getCreateTime())
            .toString();
    }
}
