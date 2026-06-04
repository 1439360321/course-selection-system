package com.ruoyi.web.controller.admin;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;

@Controller
@RequestMapping("/admin/course/selection-window")
@RequiresRoles("admin")
public class SelectionWindowController extends BaseController
{
    @GetMapping()
    public String index(ModelMap mmap) {
        return "admin/course/selectionWindow";
    }
}
