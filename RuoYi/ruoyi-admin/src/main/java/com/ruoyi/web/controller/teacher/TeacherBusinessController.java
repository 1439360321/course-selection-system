package com.ruoyi.web.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.Class;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.domain.Teacher;
import com.ruoyi.system.service.IClassService;
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.service.ITeacherService;

@Controller
@RequestMapping("/teacher")
@RequiresRoles("teacher")
public class TeacherBusinessController extends BaseController
{
    @Autowired
    private IClassService classService;
    @Autowired
    private ICourseSelectionService courseSelectionService;
    @Autowired
    private ITeacherService teacherService;

    @GetMapping("/index")
    public String index() { return "teacher/index"; }

    @GetMapping("/course")
    public String course() { return "teacher/course/list"; }

    @PostMapping("/info")
    @ResponseBody
    public AjaxResult info(String tno)
    {
        Teacher teacher = teacherService.selectTeacherById(tno);
        return success().put("data", teacher);
    }

    @PostMapping("/course/list")
    @ResponseBody
    public TableDataInfo courseList(String tno)
    {
        Class clazz = new Class();
        clazz.setTno(tno);
        return getDataTable(classService.selectClassList(clazz));
    }

    @GetMapping("/course/students")
    public String students(String tno, String cno, ModelMap mmap)
    {
        mmap.put("tno", tno);
        mmap.put("cno", cno);
        return "teacher/course/students";
    }

    @PostMapping("/course/students/list")
    @ResponseBody
    public TableDataInfo studentsList(String cno)
    {
        // 获取当前登录教师的工号
        String currentTno = getLoginName();
        System.out.println("DEBUG: currentTno = " + currentTno + ", cno = " + cno);
        
        // 验证该课程是否由当前教师教授
        Class clazz = classService.selectClassById(currentTno, cno);
        System.out.println("DEBUG: clazz = " + (clazz != null ? clazz.getTno() + "-" + clazz.getCno() : "null"));
        
        if (clazz == null)
        {
            // 如果课程不存在或不是当前教师教授的，返回空数据
            System.out.println("DEBUG: 课程不属于当前教师，返回空数据");
            return getDataTable(new java.util.ArrayList<>());
        }
        
        CourseSelection cs = new CourseSelection();
        cs.setCno(cno);
        return getDataTable(courseSelectionService.selectCourseSelectionList(cs));
    }

    @PostMapping("/grade/save")
    @ResponseBody
    public AjaxResult gradeSave(CourseSelection cs)
    {
        try
        {
            return toAjax(courseSelectionService.updateCourseSelection(cs));
        }
        catch (IllegalArgumentException e)
        {
            return error(e.getMessage());
        }
        catch (Exception e)
        {
            return error("成绩保存失败：" + e.getMessage());
        }
    }
}
