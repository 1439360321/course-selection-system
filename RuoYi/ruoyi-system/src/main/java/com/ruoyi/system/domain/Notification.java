package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 通知表 notification
 *
 * @author ruoyi
 */
public class Notification extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 通知ID */
    private Long notifId;

    /** 接收者类型: admin/teacher/student */
    private String recipientType;

    /** 接收者标识 */
    private String recipientId;

    /** 通知标题 */
    private String title;

    /** 通知内容 */
    private String content;

    /** 是否已读: 0未读 1已读 */
    private Integer isRead;

    /** 来源类型 */
    private String sourceType;

    /** 来源ID */
    private String sourceId;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    public Long getNotifId()
    {
        return notifId;
    }

    public void setNotifId(Long notifId)
    {
        this.notifId = notifId;
    }

    public String getRecipientType()
    {
        return recipientType;
    }

    public void setRecipientType(String recipientType)
    {
        this.recipientType = recipientType;
    }

    public String getRecipientId()
    {
        return recipientId;
    }

    public void setRecipientId(String recipientId)
    {
        this.recipientId = recipientId;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public Integer getIsRead()
    {
        return isRead;
    }

    public void setIsRead(Integer isRead)
    {
        this.isRead = isRead;
    }

    public String getSourceType()
    {
        return sourceType;
    }

    public void setSourceType(String sourceType)
    {
        this.sourceType = sourceType;
    }

    public String getSourceId()
    {
        return sourceId;
    }

    public void setSourceId(String sourceId)
    {
        this.sourceId = sourceId;
    }

    @Override
    public Date getCreateTime()
    {
        return createTime;
    }

    @Override
    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    @Override
    public String toString()
    {
        return "Notification{" +
                "notifId=" + notifId +
                ", recipientType='" + recipientType + '\'' +
                ", recipientId='" + recipientId + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", isRead=" + isRead +
                ", sourceType='" + sourceType + '\'' +
                ", sourceId='" + sourceId + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
