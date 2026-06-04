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
        CourseSelection cs = new CourseSelection();
        cs.setSno(sno);
        List<CourseSelection> selections = courseSelectionService.selectCourseSelectionList(cs);

        List<Map<String, Object>> result = new ArrayList<>();
        for (CourseSelection item : selections)
        {
            Map<String, Object> row = new HashMap<>();
            row.put("cno", item.getCno());
            row.put("cname", item.getCname());
            row.put("semester", item.getSemester());
            boolean evaluated = courseEvaluationService.checkExists(sno, item.getCno());
            row.put("evaluated", evaluated);
            row.put("status", evaluated ? "已评" : "待评");
            result.add(row);
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

        return toAjax(courseEvaluationService.insertEvaluation(eval));
    }
}
