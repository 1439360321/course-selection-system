package com.ruoyi.web.controller.student;

import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.Student;
import com.ruoyi.system.service.IStudentService;

@Controller
@RequestMapping("/student/profile")
@RequiresRoles("student")
public class StudentProfileController extends BaseController
{
    private String prefix = "student/profile";

    @Autowired
    private IStudentService studentService;

    @GetMapping("/edit")
    public String edit(ModelMap mmap) {
        Student s = studentService.selectStudentById(ShiroUtils.getLoginName());
        mmap.put("student", s);
        return prefix + "/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Student student) {
        student.setSno(ShiroUtils.getLoginName());
        studentService.updateStudent(student);
        return success();
    }

    @GetMapping("/password")
    public String password() { return prefix + "/password"; }

    @PostMapping("/password")
    @ResponseBody
    public AjaxResult passwordSave(String oldPassword, String newPassword, String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) return error("密码不一致");
        if (newPassword == null || newPassword.length() < 8) return error("密码至少8位");
        Student s = studentService.selectStudentById(ShiroUtils.getLoginName());
        if (s == null || !new BCryptPasswordEncoder().matches(oldPassword, s.getPasswordHash()))
            return error("旧密码错误");
        s.setPasswordHash(new BCryptPasswordEncoder().encode(newPassword));
        studentService.updateStudent(s);
        return success();
    }
}
