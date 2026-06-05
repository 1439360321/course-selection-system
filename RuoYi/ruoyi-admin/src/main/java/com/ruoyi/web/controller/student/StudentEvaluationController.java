package com.ruoyi.web.controller.student;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.CourseEvaluation;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.service.IClassService;
import com.ruoyi.system.service.ICourseEvaluationService;
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.service.ICourseService;

@Controller
@RequestMapping("/student/evaluation")
public class StudentEvaluationController extends BaseController
{
    @Autowired
    private ICourseSelectionService courseSelectionService;

    @Autowired
    private ICourseEvaluationService courseEvaluationService;

    @Autowired
    private ICourseService courseService;

    @Autowired
    private IClassService classService;

    @GetMapping()
    @RequiresRoles("student")
    public String evaluation()
    {
        return "student/evaluation/list";
    }

    @PostMapping("/list")
    @RequiresRoles("student")
    @ResponseBody
    public TableDataInfo list()
    {
        String sno = ShiroUtils.getLoginName();
        // query evaluations already submitted
        CourseEvaluation query = new CourseEvaluation();
        query.setSno(sno);
        List<CourseEvaluation> evals = courseEvaluationService.selectEvaluationList(query);
        List<Map<String, Object>> result = new ArrayList<>();
        java.util.Set<String> evalCnos = new java.util.HashSet<>();
        for (CourseEvaluation e : evals)
        {
            Map<String, Object> row = new HashMap<>();
            row.put("cno", e.getCno());
            row.put("cname", e.getCname());
            row.put("semester", e.getSemester());
            row.put("rating", e.getRating());
            row.put("comment", e.getComment());
            row.put("createTime", e.getCreateTime());
            row.put("evaluated", true);
            result.add(row);
            evalCnos.add(e.getCno());
        }
        // also show selected courses not yet evaluated
        CourseSelection cs = new CourseSelection();
        cs.setSno(sno);
        List<CourseSelection> selections = courseSelectionService.selectCourseSelectionList(cs);
        for (CourseSelection item : selections)
        {
            if (!evalCnos.contains(item.getCno()))
            {
                Map<String, Object> row = new HashMap<>();
                row.put("cno", item.getCno());
                row.put("cname", item.getCname());
                row.put("semester", item.getSemester());
                row.put("evaluated", false);
                result.add(row);
            }
        }
        return getDataTable(result);
    }

    @GetMapping("/add/{cno}")
    @RequiresRoles("student")
    public String add(@PathVariable String cno, ModelMap mmap)
    {
        String sno = ShiroUtils.getLoginName();
        if (courseEvaluationService.checkExists(sno, cno))
        {
            mmap.put("alreadyEvaluated", true);
        }
        mmap.put("cno", cno);
        mmap.put("sno", sno);
        var course = courseService.selectCourseById(cno);
        if (course != null)
        {
            mmap.put("cname", course.getCname());
        }
        return "student/evaluation/add";
    }

    @PostMapping("/add")
    @RequiresRoles("student")
    @ResponseBody
    public AjaxResult addSave(CourseEvaluation eval)
    {
        String sno = ShiroUtils.getLoginName();
        eval.setSno(sno);

        // validate rating
        if (eval.getRating() == null || eval.getRating() < 1 || eval.getRating() > 5)
        {
            return error("评分必须在1-5之间");
        }

        // validate comment length
        if (eval.getComment() != null && eval.getComment().length() > 500)
        {
            return error("评价内容不能超过500字");
        }

        // check duplicate
        if (courseEvaluationService.checkExists(sno, eval.getCno()))
        {
            return error("您已经评价过该课程，不能重复评价");
        }

        // set anonymous default
        if (eval.getIsAnonymous() == null)
        {
            eval.setIsAnonymous(0);
        }

        eval.setCreateTime(new Date());

        // get semester from course selection
        CourseSelection cs = courseSelectionService.selectCourseSelectionById(sno, eval.getCno());
        if (cs != null)
        {
            eval.setSemester(cs.getSemester());
        }
        // lookup tno from class assignment; fallback: use any teacher teaching this course
        if (eval.getTno() == null) {
            com.ruoyi.system.domain.Class query = new com.ruoyi.system.domain.Class();
            query.setCno(eval.getCno());
            var classList = classService.selectClassList(query);
            if (!classList.isEmpty()) {
                eval.setTno(classList.get(0).getTno());
            } else {
                // fallback: use the course's admin_id or a system default
                var course = courseService.selectCourseById(eval.getCno());
                if (course != null && course.getAdminId() != null) {
                    eval.setTno(course.getAdminId());
                }
            }
        }
        // final fallback: insert fails without tno
        if (eval.getTno() == null) {
            return error("该课程暂无授课教师，无法评价");
        }

        return toAjax(courseEvaluationService.insertEvaluation(eval));
    }
}
