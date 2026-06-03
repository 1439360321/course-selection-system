package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Course;

public interface CourseMapper
{
    public List<Course> selectCourseList(Course course);

    public Course selectCourseById(String cno);

    public int insertCourse(Course course);

    public int updateCourse(Course course);

    public int deleteCourseById(String cno);

    public Course checkCnoUnique(String cno);

    public Course checkCnameUnique(String cname);

    public int selectEnrolledCount(String cno);
}
