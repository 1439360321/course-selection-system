package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Teacher;

/**
 * 教师管理 数据层
 */
public interface TeacherMapper
{
    public List<Teacher> selectTeacherList(Teacher teacher);

    public Teacher selectTeacherById(String tno);

    public int insertTeacher(Teacher teacher);

    public int updateTeacher(Teacher teacher);

    public int deleteTeacherById(String tno);

    public Teacher checkTnoUnique(String tno);

    public int updateTeacherPassword(@org.apache.ibatis.annotations.Param("tno") String tno, @org.apache.ibatis.annotations.Param("passwordHash") String passwordHash);
}
