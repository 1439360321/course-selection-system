package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.Course;
import com.ruoyi.system.mapper.CourseMapper;
import com.ruoyi.system.service.ICourseService;

@Service("courseService")
public class CourseServiceImpl implements ICourseService
{
    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<Course> selectCourseList(Course course)
    {
        return courseMapper.selectCourseList(course);
    }

    @Override
    public Course selectCourseById(String cno)
    {
        return courseMapper.selectCourseById(cno);
    }

    @Override
    public int insertCourse(Course course)
    {
        return courseMapper.insertCourse(course);
    }

    @Override
    public int updateCourse(Course course)
    {
        return courseMapper.updateCourse(course);
    }

    @Override
    public int deleteCourseById(String cno)
    {
        return courseMapper.deleteCourseById(cno);
    }

    @Override
    public boolean checkCnoUnique(Course course)
    {
        String cno = course.getCno();
        Course info = courseMapper.checkCnoUnique(cno);
        if (StringUtils.isNotNull(info) && !info.getCno().equals(course.getCno()))
        {
            return false;
        }
        return true;
    }

    @Override
    public boolean checkCnameUnique(Course course)
    {
        String cno = StringUtils.isNull(course.getCno()) ? "" : course.getCno();
        Course info = courseMapper.checkCnameUnique(course.getCname());
        if (StringUtils.isNotNull(info) && !info.getCno().equals(cno))
        {
            return false;
        }
        return true;
    }

    @Override
    public int selectEnrolledCount(String cno)
    {
        return courseMapper.selectEnrolledCount(cno);
    }
}
