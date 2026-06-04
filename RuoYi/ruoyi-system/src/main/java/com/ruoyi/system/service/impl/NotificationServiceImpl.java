package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.Notification;
import com.ruoyi.system.mapper.NotificationMapper;
import com.ruoyi.system.service.INotificationService;

/**
 * 通知 服务层实现
 *
 * @author ruoyi
 */
@Service
public class NotificationServiceImpl implements INotificationService
{
    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public List<Notification> selectNotificationList(Notification notification)
    {
        return notificationMapper.selectNotificationList(notification);
    }

    @Override
    public int selectUnreadCount(String recipientType, String recipientId)
    {
        Notification notification = new Notification();
        notification.setRecipientType(recipientType);
        notification.setRecipientId(recipientId);
        return notificationMapper.selectUnreadCount(notification);
    }

    @Override
    public int insertNotification(Notification notification)
    {
        return notificationMapper.insertNotification(notification);
    }

    @Override
    public int markAsRead(Long notifId)
    {
        return notificationMapper.markAsRead(notifId);
    }

    @Override
    public int markAllAsRead(String recipientType, String recipientId)
    {
        Notification notification = new Notification();
        notification.setRecipientType(recipientType);
        notification.setRecipientId(recipientId);
        return notificationMapper.markAllAsRead(notification);
    }
}
