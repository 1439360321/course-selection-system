package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Notification;

/**
 * 通知 服务层
 *
 * @author ruoyi
 */
public interface INotificationService
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
     * @param recipientType 接收者类型
     * @param recipientId 接收者标识
     * @return 未读数量
     */
    public int selectUnreadCount(String recipientType, String recipientId);

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
     * @param recipientType 接收者类型
     * @param recipientId 接收者标识
     * @return 结果
     */
    public int markAllAsRead(String recipientType, String recipientId);
}
