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
            throw new org.springframework.dao.DataIntegrityViolationException("该学生已选修此课程，不能重复选课");
        }
        if (cs.getSemester() == null || cs.getSemester().trim().isEmpty())
        {
            throw new IllegalArgumentException("学期不能为空");
        }
        Course course = courseService.selectCourseById(cs.getCno());
        if (course != null && course.getMaxStudents() != null && course.getMaxStudents() > 0)
        {
            int enrolledCount = courseService.selectEnrolledCount(cs.getCno());
            if (enrolledCount >= course.getMaxStudents())
            {
                throw new IllegalArgumentException("该课程选课人数已满（" + enrolledCount + "/" + course.getMaxStudents() + "），请选择其他课程");
            }
        }
        return courseSelectionMapper.insertCourseSelection(cs);
    }

    @Override
    @Transactional
    public int updateCourseSelection(CourseSelection cs)
    {
        String validationError = validateScore(cs.getNormalScore(), cs.getTestScore());
        if (validationError != null)
        {
            throw new IllegalArgumentException(validationError);
        }
        cs.calculateTotalScore();
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
    public BigDecimal getStudentGpa(String sno)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("sno", sno);
        params.put("gpa", BigDecimal.ZERO);
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
    public String validateScore(BigDecimal normalScore, BigDecimal testScore)
    {
        if (normalScore == null || testScore == null)
        {
            return null;
        }
        if (normalScore.compareTo(MIN_SCORE) < 0 || normalScore.compareTo(MAX_SCORE) > 0)
        {
            return "平时成绩必须在0-100之间";
        }
        if (testScore.compareTo(MIN_SCORE) < 0 || testScore.compareTo(MAX_SCORE) > 0)
        {
            return "考试成绩必须在0-100之间";
        }
        return null;
    }
}
