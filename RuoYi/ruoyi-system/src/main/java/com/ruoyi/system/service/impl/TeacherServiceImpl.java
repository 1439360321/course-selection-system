package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.Teacher;
import com.ruoyi.system.mapper.TeacherMapper;
import com.ruoyi.system.service.ITeacherService;

/**
 * 教师管理 服务实现
 */
@Service
public class TeacherServiceImpl implements ITeacherService
{
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public List<Teacher> selectTeacherList(Teacher teacher)
    {
        return teacherMapper.selectTeacherList(teacher);
    }

    @Override
    public Teacher selectTeacherById(String tno)
    {
        return teacherMapper.selectTeacherById(tno);
    }

    @Override
    public int insertTeacher(Teacher teacher)
    {
        if (StringUtils.isNotEmpty(teacher.getPasswordHash()))
        {
            teacher.setPasswordHash(new BCryptPasswordEncoder().encode(teacher.getPasswordHash()));
        }
        return teacherMapper.insertTeacher(teacher);
    }

    @Override
    public int updateTeacher(Teacher teacher)
    {
        if (StringUtils.isNotEmpty(teacher.getPasswordHash()))
        {
            teacher.setPasswordHash(new BCryptPasswordEncoder().encode(teacher.getPasswordHash()));
        }
        return teacherMapper.updateTeacher(teacher);
    }

    @Override
    public int deleteTeacherById(String tno)
    {
        return teacherMapper.deleteTeacherById(tno);
    }

    @Override
    public boolean checkTnoUnique(Teacher teacher)
    {
        String tno = teacher.getTno();
        Teacher info = teacherMapper.checkTnoUnique(tno);
        if (StringUtils.isNull(info))
        {
            return true;
        }
        return tno.equals(info.getTno());
    }
}
