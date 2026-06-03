package com.ruoyi.web.controller.student;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.domain.Student;
import com.ruoyi.system.service.ICourseService;
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.service.IStudentService;

@Controller
@RequestMapping("/student")
@RequiresRoles("student")
public class StudentBusinessController extends BaseController
{
    @Autowired
    private ICourseService courseService;
    @Autowired
    private ICourseSelectionService courseSelectionService;
    @Autowired
    private IStudentService studentService;

    @GetMapping("/index")
    public String index() { return "student/index"; }

    @GetMapping("/course")
    public String course() { return "student/course/list"; }

    @PostMapping("/course/list")
    @ResponseBody
    public TableDataInfo courseList()
    {
        return getDataTable(courseService.selectCourseList(null));
    }

    @PostMapping("/course/select")
    @ResponseBody
    public AjaxResult selectCourse(String sno, String cno, String semester)
    {
        try
        {
            CourseSelection cs = new CourseSelection();
            cs.setSno(sno);
            cs.setCno(cno);
            cs.setSemester(semester);
            return toAjax(courseSelectionService.insertCourseSelection(cs));
        }
        catch (org.springframework.dao.DataIntegrityViolationException e)
        {
            return error("选课失败：该课程已选择，不能重复选课");
        }
        catch (IllegalArgumentException e)
        {
            return error("选课失败：" + e.getMessage());
        }
        catch (org.springframework.dao.DataAccessException e)
        {
            return error("选课失败：课程容量已满，无法选课");
        }
        catch (Exception e)
        {
            return error("选课失败：" + e.getMessage());
        }
    }

    @GetMapping("/course/my")
    public String myCourse() { return "student/course/my"; }

    @PostMapping("/course/my/list")
    @ResponseBody
    public TableDataInfo myCourseList(String sno)
    {
        CourseSelection cs = new CourseSelection();
        cs.setSno(sno);
        return getDataTable(courseSelectionService.selectCourseSelectionList(cs));
    }

    @PostMapping("/course/drop")
    @ResponseBody
    public AjaxResult dropCourse(String sno, String cno)
    {
        return toAjax(courseSelectionService.deleteCourseSelectionById(sno, cno));
    }

    @PostMapping("/info")
    @ResponseBody
    public AjaxResult info(String sno)
    {
        Student student = studentService.selectStudentById(sno);
        return success().put("data", student);
    }

    @GetMapping("/grade")
    public String grade() { return "student/grade/list"; }

    @GetMapping("/gpa")
    @ResponseBody
    public AjaxResult gpa(String sno)
    {
        try {
            java.math.BigDecimal gpa = courseSelectionService.getStudentGpa(sno);
            return success().put("gpa", gpa);
        } catch (Exception e) {
            // Fallback: calculate GPA from grades
            CourseSelection cs = new CourseSelection();
            cs.setSno(sno);
            java.util.List<CourseSelection> list = courseSelectionService.selectCourseSelectionList(cs);
            double totalPoints = 0;
            double totalCredits = 0;
            for (CourseSelection item : list) {
                if (item.getNormalScore() != null && item.getTestScore() != null) {
                    double total = item.getNormalScore().doubleValue() * 0.4 + item.getTestScore().doubleValue() * 0.6;
                    double gp = 0;
                    if (total >= 90) gp = 4.0;
                    else if (total >= 85) gp = 3.7;
                    else if (total >= 82) gp = 3.3;
                    else if (total >= 78) gp = 3.0;
                    else if (total >= 75) gp = 2.7;
                    else if (total >= 72) gp = 2.3;
                    else if (total >= 68) gp = 2.0;
                    else if (total >= 64) gp = 1.5;
                    else if (total >= 60) gp = 1.0;
                    // Get credit from course
                    com.ruoyi.system.domain.Course course = courseService.selectCourseById(item.getCno());
                    if (course != null) {
                        totalPoints += gp * course.getCredit().doubleValue();
                        totalCredits += course.getCredit().doubleValue();
                    }
                }
            }
            double gpa = totalCredits > 0 ? totalPoints / totalCredits : 0;
            return success().put("gpa", Math.round(gpa * 100.0) / 100.0);
        }
    }

    @PostMapping("/grade/list")
    @ResponseBody
    public TableDataInfo gradeList(String sno)
    {
        CourseSelection cs = new CourseSelection();
        cs.setSno(sno);
        return getDataTable(courseSelectionService.selectCourseSelectionList(cs));
    }
}
