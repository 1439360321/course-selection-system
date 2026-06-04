package com.ruoyi.system.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.CourseSelection;

public interface ICourseSelectionService
{
    public List<CourseSelection> selectCourseSelectionList(CourseSelection cs);
    public List<CourseSelection> selectCourseSelectionListByTeacher(String tno, CourseSelection cs);
    public CourseSelection selectCourseSelectionById(String sno, String cno);
    public int insertCourseSelection(CourseSelection cs);
    public int updateCourseSelection(CourseSelection cs);
    public int deleteCourseSelectionById(String sno, String cno);
    public boolean checkDuplicateSelection(String sno, String cno);
    public String validateScore(BigDecimal normalScore, BigDecimal testScore);
    public BigDecimal getStudentGpa(String sno);
    public List<Map<String, Object>> selectCourseEnrollmentStats();
    public List<Map<String, Object>> selectFailStudentStats();
    public List<Map<String, Object>> selectStudentGradeStats(String sno);
    public List<Map<String, Object>> selectTeacherScheduleStats(String tno);

    public List<Map<String, Object>> selectTeacherGradeStats(String tno);

    public List<Map<String, Object>> selectStudentSchedule(String sno);

    public List<Map<String, Object>> selectStudentCreditDetail(String sno);
}
