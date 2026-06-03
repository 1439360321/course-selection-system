package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Course;

public interface ICourseService
{
    public List<Course> selectCourseList(Course course);

    public Course selectCourseById(String cno);

    public int insertCourse(Course course);

    public int updateCourse(Course course);

    public int deleteCourseById(String cno);

    public boolean checkCnoUnique(Course course);

    public boolean checkCnameUnique(Course course);

    public int selectEnrolledCount(String cno);
}
