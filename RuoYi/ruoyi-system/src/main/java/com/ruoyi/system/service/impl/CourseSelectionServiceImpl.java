package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.Course;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.mapper.CourseSelectionMapper;
import com.ruoyi.system.service.ICourseService;
import com.ruoyi.system.service.ICourseSelectionService;

@Service("courseSelectionService")
public class CourseSelectionServiceImpl implements ICourseSelectionService
{
    @Autowired
    private CourseSelectionMapper courseSelectionMapper;
    @Autowired
    private ICourseService courseService;

    private static final BigDecimal MIN_SCORE = new BigDecimal("0");
    private static final BigDecimal MAX_SCORE = new BigDecimal("100");

    @Override
    public List<CourseSelection> selectCourseSelectionList(CourseSelection cs)
    {
        List<CourseSelection> list = courseSelectionMapper.selectCourseSelectionList(cs);
        for (CourseSelection item : list)
        {
            item.calculateTotalScore();
        }
        return list;
    }

    @Override
    public List<CourseSelection> selectCourseSelectionListByTeacher(String tno, CourseSelection cs)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("tno", tno);
        params.put("sno", cs.getSno());
        params.put("cno", cs.getCno());
        params.put("semester", cs.getSemester());
        List<CourseSelection> list = courseSelectionMapper.selectCourseSelectionListByTeacher(params);
        for (CourseSelection item : list)
        {
            item.calculateTotalScore();
        }
        return list;
    }

    @Override
    public CourseSelection selectCourseSelectionById(String sno, String cno)
    {
        CourseSelection cs = courseSelectionMapper.selectCourseSelectionById(sno, cno);
        if (cs != null)
        {
            cs.calculateTotalScore();
        }
        return cs;
    }

    @Override
    @Transactional
    public int insertCourseSelection(CourseSelection cs)
    {
        if (checkDuplicateSelection(cs.getSno(), cs.getCno()))
        {
            throw new IllegalArgumentException("Course already selected");
        }
        if (validateScore(cs.getNormalScore(), cs.getTestScore()) != null)
        {
            throw new IllegalArgumentException(validateScore(cs.getNormalScore(), cs.getTestScore()));
        }
        Course course = courseService.selectCourseById(cs.getCno());
        if (course != null && course.getMaxStudents() != null)
        {
            int enrolled = courseService.selectEnrolledCount(cs.getCno());
            if (enrolled >= course.getMaxStudents())
            {
                throw new IllegalArgumentException("Course is full");
            }
        }
        return courseSelectionMapper.insertCourseSelection(cs);
    }

    @Override
    public int updateCourseSelection(CourseSelection cs)
    {
        String error = validateScore(cs.getNormalScore(), cs.getTestScore());
        if (error != null)
        {
            throw new IllegalArgumentException(error);
        }
        return courseSelectionMapper.updateCourseSelection(cs);
    }

    @Override
    public int deleteCourseSelectionById(String sno, String cno)
    {
        return courseSelectionMapper.deleteCourseSelectionById(sno, cno);
    }

    @Override
    public boolean checkDuplicateSelection(String sno, String cno)
    {
        return courseSelectionMapper.selectCountBySnoAndCno(sno, cno) > 0;
    }

    @Override
    public String validateScore(BigDecimal normalScore, BigDecimal testScore)
    {
        if (normalScore != null && (normalScore.compareTo(MIN_SCORE) < 0 || normalScore.compareTo(MAX_SCORE) > 0))
        {
            return "Normal score must be 0-100";
        }
        if (testScore != null && (testScore.compareTo(MIN_SCORE) < 0 || testScore.compareTo(MAX_SCORE) > 0))
        {
            return "Test score must be 0-100";
        }
        return null;
    }

    @Override
    public BigDecimal getStudentGpa(String sno)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("sno", sno);
        params.put("gpa", null);
        courseSelectionMapper.callSpStudentGpa(params);
        return (BigDecimal) params.get("gpa");
    }

    @Override
    public List<Map<String, Object>> selectCourseEnrollmentStats()
    {
        return courseSelectionMapper.selectCourseEnrollmentList();
    }

    @Override
    public List<Map<String, Object>> selectFailStudentStats()
    {
        return courseSelectionMapper.selectFailStudentList();
    }

    @Override
    public List<Map<String, Object>> selectStudentGradeStats(String sno)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("sno", sno);
        return courseSelectionMapper.selectStudentGradeList(params);
    }

    @Override
    public List<Map<String, Object>> selectTeacherScheduleStats(String tno)
    {
        return courseSelectionMapper.selectTeacherScheduleList(tno);
    }

    @Override
    public List<Map<String, Object>> selectTeacherGradeStats(String tno)
    {
        return courseSelectionMapper.selectTeacherGradeStats(tno);
    }

    @Override
    public List<Map<String, Object>> selectStudentSchedule(String sno)
    {
        return courseSelectionMapper.selectStudentSchedule(sno);
    }
}
