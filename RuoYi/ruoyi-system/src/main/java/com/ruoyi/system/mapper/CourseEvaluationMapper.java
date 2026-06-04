package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.CourseEvaluation;

public interface CourseEvaluationMapper
{
    public List<CourseEvaluation> selectEvaluationList(CourseEvaluation eval);

    public int insertEvaluation(CourseEvaluation eval);

    public int checkExists(String sno, String cno);

    public List<CourseEvaluation> selectEvaluationsByTeacher(String tno);

    public List<Map<String, Object>> selectTeacherEvalStats(String tno);
}
