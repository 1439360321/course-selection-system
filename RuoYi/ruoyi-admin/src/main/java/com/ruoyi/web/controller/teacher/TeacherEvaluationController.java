package com.ruoyi.web.controller.teacher;

import java.util.List;
import java.util.Map;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.service.ICourseEvaluationService;

@Controller
@RequestMapping("/teacher/evaluation")
@RequiresRoles("teacher")
public class TeacherEvaluationController extends BaseController
{
    private String prefix = "teacher/evaluation";

    @Autowired
    private ICourseEvaluationService evaluationService;

    @GetMapping()
    public String evaluation() { return prefix + "/list"; }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list() {
        startPage();
        String tno = ShiroUtils.getLoginName();
        return getDataTable(evaluationService.selectTeacherEvalStats(tno));
    }
}
