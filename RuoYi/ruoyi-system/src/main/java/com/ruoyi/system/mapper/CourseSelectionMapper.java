package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import java.util.Map;
import com.ruoyi.system.domain.CourseSelection;

public interface CourseSelectionMapper
{
    public List<CourseSelection> selectCourseSelectionList(CourseSelection cs);

    public List<CourseSelection> selectCourseSelectionListByTeacher(Map<String, Object> params);

    public CourseSelection selectCourseSelectionById(String sno, String cno);

    public int insertCourseSelection(CourseSelection cs);

    public int updateCourseSelection(CourseSelection cs);

    public int deleteCourseSelectionById(String sno, String cno);

    public int selectCountBySnoAndCno(String sno, String cno);

    public void callSpStudentGpa(Map<String, Object> params);

    public List<Map<String, Object>> selectCourseEnrollmentList();

    public List<Map<String, Object>> selectFailStudentList();

    public List<Map<String, Object>> selectStudentGradeList(Map<String, Object> params);

    public List<Map<String, Object>> selectTeacherScheduleList(String tno);
}
