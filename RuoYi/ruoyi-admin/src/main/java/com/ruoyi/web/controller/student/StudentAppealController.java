package com.ruoyi.web.controller.student;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.GradeAppeal;
import com.ruoyi.system.service.IGradeAppealService;
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.domain.CourseSelection;

@Controller
@RequestMapping("/student/appeal")
@RequiresRoles("student")
public class StudentAppealController extends BaseController
{
    private String prefix = "student/appeal";

    @Autowired
    private IGradeAppealService appealService;
    @Autowired
    private ICourseSelectionService csService;

    @GetMapping()
    public String appeal() { return prefix + "/list"; }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list() {
        startPage();
        GradeAppeal appeal = new GradeAppeal();
        appeal.setSno(ShiroUtils.getLoginName());
        return getDataTable(appealService.selectAppealList(appeal));
    }

    @GetMapping("/add/{cno}")
    public String add(@PathVariable String cno, ModelMap mmap) {
        mmap.put("cno", cno);
        return prefix + "/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(GradeAppeal appeal) {
        appeal.setSno(ShiroUtils.getLoginName());
        appeal.setStatus(0);
        appealService.insertAppeal(appeal);
        return success();
    }
}
