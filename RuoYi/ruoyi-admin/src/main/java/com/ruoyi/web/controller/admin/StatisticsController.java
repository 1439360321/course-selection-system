package com.ruoyi.web.controller.admin;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.service.ICourseService;

@Controller
@RequestMapping("/admin/statistics")
@RequiresRoles("admin")
public class StatisticsController extends BaseController
{
    @Autowired
    private ICourseSelectionService courseSelectionService;
    @Autowired
    private ICourseService courseService;

    @GetMapping()
    public String index() { return "admin/statistics/index"; }

    @RequestMapping("/enrollment")
    @ResponseBody
    public TableDataInfo enrollment()
    {
        List<Map<String, Object>> list = courseSelectionService.selectCourseEnrollmentStats();
        return getDataTable(list);
    }

    @RequestMapping("/fail")
    @ResponseBody
    public TableDataInfo fail()
    {
        List<Map<String, Object>> list = courseSelectionService.selectFailStudentStats();
        return getDataTable(list);
    }

    @RequestMapping("/gpa")
    @ResponseBody
    public AjaxResult gpa(String sno)
    {
        try {
            java.math.BigDecimal gpa = courseSelectionService.getStudentGpa(sno);
            return success().put("gpa", gpa);
        } catch (Exception e) {
            com.ruoyi.system.domain.CourseSelection cs = new com.ruoyi.system.domain.CourseSelection();
            cs.setSno(sno);
            java.util.List<com.ruoyi.system.domain.CourseSelection> list = courseSelectionService.selectCourseSelectionList(cs);
            double totalPoints = 0;
            double totalCredits = 0;
            for (com.ruoyi.system.domain.CourseSelection item : list) {
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
                    String cno = item.getCno();
                    if (cno != null) {
                        com.ruoyi.system.domain.Course course = courseService.selectCourseById(cno);
                        if (course != null && course.getCredit() != null) {
                            totalPoints += gp * course.getCredit().doubleValue();
                            totalCredits += course.getCredit().doubleValue();
                        }
                    }
                }
            }
            double gpa = totalCredits > 0 ? totalPoints / totalCredits : 0;
            return success().put("gpa", Math.round(gpa * 100.0) / 100.0);
        }
    }

    @RequestMapping("/grades")
    @ResponseBody
    public TableDataInfo grades(String sno)
    {
        List<Map<String, Object>> list = courseSelectionService.selectStudentGradeStats(sno);
        return getDataTable(list);
    }
}
