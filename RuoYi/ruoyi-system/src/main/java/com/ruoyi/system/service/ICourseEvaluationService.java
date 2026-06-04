package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.CourseEvaluation;

public interface ICourseEvaluationService
{
    public List<CourseEvaluation> selectEvaluationList(CourseEvaluation eval);

    public int insertEvaluation(CourseEvaluation eval);

    public boolean checkExists(String sno, String cno);

    public List<CourseEvaluation> selectEvaluationsByTeacher(String tno);

    public List<Map<String, Object>> selectTeacherEvalStats(String tno);
}
