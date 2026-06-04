package com.ruoyi.web.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.Course;
import com.ruoyi.system.service.ICourseService;

@Controller
@RequestMapping("/teacher/proposal")
@RequiresRoles("teacher")
public class TeacherProposalController extends BaseController
{
    private String prefix = "teacher/proposal";

    @Autowired
    private ICourseService courseService;

    @GetMapping()
    public String proposal() { return prefix + "/list"; }

    @GetMapping("/add")
    public String add(ModelMap mmap) { return prefix + "/add"; }

    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Course course) {
        course.setStatus(0);
        String tno = ShiroUtils.getLoginName();
        course.setAdminId(tno);
        course.setCno("C" + (System.currentTimeMillis() % 90000 + 10000));
        try {
            courseService.insertCourse(course);
            return success();
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Course course) {
        startPage();
        course.setAdminId(ShiroUtils.getLoginName());
        return getDataTable(courseService.selectCourseList(course));
    }
}
