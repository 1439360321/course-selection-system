package com.ruoyi.web.controller.admin;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.SysConfig;
import com.ruoyi.system.service.ISysConfigService;

@Controller
@RequestMapping("/admin/course/selection-window")
@RequiresRoles("admin")
public class SelectionWindowController extends BaseController
{
    @Autowired
    private ISysConfigService configService;

    @GetMapping()
    public String index(ModelMap mmap) {
        return "admin/course/selectionWindow";
    }

    @PostMapping("/save")
    @ResponseBody
    public AjaxResult save(String startTime, String endTime) {
        try {
            SysConfig query = new SysConfig();
            query.setConfigKey("course.selection.start");
            java.util.List<SysConfig> list = configService.selectConfigList(query);
            if (!list.isEmpty()) {
                SysConfig cfg = list.get(0);
                cfg.setConfigValue(startTime != null ? startTime : "");
                configService.updateConfig(cfg);
            }
            query.setConfigKey("course.selection.end");
            list = configService.selectConfigList(query);
            if (!list.isEmpty()) {
                SysConfig cfg = list.get(0);
                cfg.setConfigValue(endTime != null ? endTime : "");
                configService.updateConfig(cfg);
            }
            return success("选课时间设置保存成功");
        } catch (Exception e) {
            return error("保存失败: " + e.getMessage());
        }
    }
}
