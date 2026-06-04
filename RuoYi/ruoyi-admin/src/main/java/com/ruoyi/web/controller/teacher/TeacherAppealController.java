package com.ruoyi.web.controller.teacher;

import java.util.Date;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.GradeAppeal;
import com.ruoyi.system.service.IGradeAppealService;

@Controller
@RequestMapping("/teacher/appeal")
@RequiresRoles("teacher")
public class TeacherAppealController extends BaseController
{
    private String prefix = "teacher/appeal";

    @Autowired
    private IGradeAppealService appealService;

    @GetMapping()
    public String appeal() { return prefix + "/list"; }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(GradeAppeal appeal) {
        startPage();
        String tno = ShiroUtils.getLoginName();
        return getDataTable(appealService.selectAppealsByTeacher(tno));
    }

    @PostMapping("/handle")
    @ResponseBody
    public AjaxResult handle(Long appealId, Integer status, String reply) {
        GradeAppeal appeal = new GradeAppeal();
        appeal.setAppealId(appealId);
        appeal.setStatus(status);
        appeal.setReply(reply);
        appeal.setHandler(ShiroUtils.getLoginName());
        appeal.setHandleTime(new Date());
        appealService.handleAppeal(appeal);
        return success();
    }
}
