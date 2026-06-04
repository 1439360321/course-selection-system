package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.Student;
import com.ruoyi.system.mapper.StudentMapper;
import com.ruoyi.system.service.IStudentService;

/**
 * 学生管理 服务实现
 */
@Service
public class StudentServiceImpl implements IStudentService
{
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public List<Student> selectStudentList(Student student)
    {
        return studentMapper.selectStudentList(student);
    }

    @Override
    public Student selectStudentById(String sno)
    {
        return studentMapper.selectStudentById(sno);
    }

    @Override
    public int insertStudent(Student student)
    {
        if (StringUtils.isNotEmpty(student.getPasswordHash()))
        {
            student.setPasswordHash(new BCryptPasswordEncoder().encode(student.getPasswordHash()));
        }
        return studentMapper.insertStudent(student);
    }

    @Override
    public int updateStudent(Student student)
    {
        if (StringUtils.isNotEmpty(student.getPasswordHash()))
        {
            student.setPasswordHash(new BCryptPasswordEncoder().encode(student.getPasswordHash()));
        }
        return studentMapper.updateStudent(student);
    }

    @Override
    public int deleteStudentById(String sno)
    {
        return studentMapper.deleteStudentById(sno);
    }

    @Override
    public boolean checkSnoUnique(Student student)
    {
        String sno = student.getSno();
        Student info = studentMapper.checkSnoUnique(sno);
        if (StringUtils.isNull(info))
        {
            return true;
        }
        // 编辑时排除自身
        return sno.equals(info.getSno());
    }
}
