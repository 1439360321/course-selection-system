package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Class
{
    private String tno;
    private String cno;
    private String semester;
    private String classTime;
    private String examTime;
    private String adminId;
    private String tname;
    private String cname;
    private String id;

    public String getTno() { return tno; }
    public void setTno(String tno) { this.tno = tno; }
    public String getCno() { return cno; }
    public void setCno(String cno) { this.cno = cno; }
    public String getSemester() { return semester; }
    public void setSemester(String semester) { this.semester = semester; }
    public String getClassTime() { return classTime; }
    public void setClassTime(String classTime) { this.classTime = classTime; }
    public String getExamTime() { return examTime; }
    public void setExamTime(String examTime) { this.examTime = examTime; }
    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public String getTname() { return tname; }
    public void setTname(String tname) { this.tname = tname; }
    public String getCname() { return cname; }
    public void setCname(String cname) { this.cname = cname; }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("tno", getTno())
            .append("cno", getCno())
            .append("semester", getSemester())
            .append("classTime", getClassTime())
            .append("examTime", getExamTime())
            .append("adminId", getAdminId())
            .append("tname", getTname())
            .append("cname", getCname())
            .toString();
    }
}