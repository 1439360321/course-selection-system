package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Notification;

/**
 * 通知 数据层
 *
 * @author ruoyi
 */
public interface NotificationMapper
{
    /**
     * 查询通知列表
     *
     * @param notification 通知信息
     * @return 通知集合
     */
    public List<Notification> selectNotificationList(Notification notification);

    /**
     * 查询未读数量
     *
     * @param notification 通知信息（含recipientType和recipientId）
     * @return 未读数量
     */
    public int selectUnreadCount(Notification notification);

    /**
     * 新增通知
     *
     * @param notification 通知信息
     * @return 结果
     */
    public int insertNotification(Notification notification);

    /**
     * 标记单条已读
     *
     * @param notifId 通知ID
     * @return 结果
     */
    public int markAsRead(Long notifId);

    /**
     * 标记全部已读
     *
     * @param notification 通知信息（含recipientType和recipientId）
     * @return 结果
     */
    public int markAllAsRead(Notification notification);
}
