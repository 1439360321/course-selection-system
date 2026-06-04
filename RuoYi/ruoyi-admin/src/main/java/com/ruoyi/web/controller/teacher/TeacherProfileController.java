package com.ruoyi.web.controller.teacher;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.Teacher;
import com.ruoyi.system.service.ITeacherService;

@Controller
@RequestMapping("/teacher/profile")
@RequiresRoles("teacher")
public class TeacherProfileController extends BaseController
{
    private String prefix = "teacher/profile";

    @Autowired
    private ITeacherService teacherService;

    @GetMapping("/edit")
    public String edit(ModelMap mmap) {
        Teacher t = teacherService.selectTeacherById(ShiroUtils.getLoginName());
        mmap.put("teacher", t);
        return prefix + "/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Teacher teacher) {
        teacher.setTno(ShiroUtils.getLoginName());
        teacherService.updateTeacher(teacher);
        return success();
    }

    @GetMapping("/password")
    public String password() { return prefix + "/password"; }

    @PostMapping("/password")
    @ResponseBody
    public AjaxResult passwordSave(String oldPassword, String newPassword, String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) return error("密码不一致");
        if (newPassword == null || newPassword.length() < 8) return error("密码至少8位");
        Teacher t = teacherService.selectTeacherById(ShiroUtils.getLoginName());
        if (t == null || !new BCryptPasswordEncoder().matches(oldPassword, t.getPasswordHash()))
            return error("旧密码错误");
        t.setPasswordHash(new BCryptPasswordEncoder().encode(newPassword));
        teacherService.updateTeacher(t);
        return success();
    }
}
