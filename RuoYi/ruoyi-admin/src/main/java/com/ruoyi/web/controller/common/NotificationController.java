package com.ruoyi.web.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.Notification;
import com.ruoyi.system.service.INotificationService;

@Controller
@RequestMapping("/notification")
public class NotificationController extends BaseController
{
    @Autowired
    private INotificationService notifService;

    @GetMapping("/list")
    public String list() { return "notification/list"; }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo listData() {
        startPage();
        String loginName = ShiroUtils.getLoginName();
        String type = loginName.startsWith("T") ? "teacher" : (loginName.matches("\\d+") ? "student" : "admin");
        Notification n = new Notification();
        n.setRecipientType(type);
        n.setRecipientId(loginName);
        return getDataTable(notifService.selectNotificationList(n));
    }

    @GetMapping("/unread-count")
    @ResponseBody
    public AjaxResult unreadCount() {
        String loginName = ShiroUtils.getLoginName();
        String type = loginName.startsWith("T") ? "teacher" : (loginName.matches("\\d+") ? "student" : "admin");
        return success().put("count", notifService.selectUnreadCount(type, loginName));
    }

    @PostMapping("/read")
    @ResponseBody
    public AjaxResult markRead(Long notifId) { notifService.markAsRead(notifId); return success(); }

    @PostMapping("/read-all")
    @ResponseBody
    public AjaxResult markAllRead() {
        String loginName = ShiroUtils.getLoginName();
        String type = loginName.startsWith("T") ? "teacher" : (loginName.matches("\\d+") ? "student" : "admin");
        notifService.markAllAsRead(type, loginName);
        return success();
    }
}
