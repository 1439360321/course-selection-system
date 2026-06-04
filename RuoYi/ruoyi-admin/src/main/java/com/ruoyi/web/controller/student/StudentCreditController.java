package com.ruoyi.web.controller.student;

import java.util.*;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.service.ICourseSelectionService;

@Controller
@RequestMapping("/student/credit")
@RequiresRoles("student")
public class StudentCreditController extends BaseController
{
    @Autowired
    private ICourseSelectionService csService;

    @GetMapping()
    public String credit(ModelMap mmap) {
        String sno = ShiroUtils.getLoginName();
        List<Map<String, Object>> detail = csService.selectStudentCreditDetail(sno);
        int totalRequired = 130, requiredReq = 80, electiveReq = 50;
        double earned = 0, requiredEarned = 0, electiveEarned = 0;
        for (Map<String, Object> row : detail) {
            Double credit = row.get("credit") != null ? Double.parseDouble(row.get("credit").toString()) : 0;
            Double total = row.get("totalScore") != null ? Double.parseDouble(row.get("totalScore").toString()) : 0;
            String type = row.get("courseType") != null ? row.get("courseType").toString() : "";
            if (total >= 60) {
                earned += credit;
                if ("0".equals(type)) requiredEarned += credit;
                else electiveEarned += credit;
            }
        }
        mmap.put("detail", detail);
        mmap.put("earned", earned);
        mmap.put("required", totalRequired);
        mmap.put("requiredEarned", requiredEarned);
        mmap.put("requiredReq", requiredReq);
        mmap.put("electiveEarned", electiveEarned);
        mmap.put("electiveReq", electiveReq);
        return "student/credit/index";
    }
}
