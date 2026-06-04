package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.CourseEvaluation;
import com.ruoyi.system.mapper.CourseEvaluationMapper;
import com.ruoyi.system.service.ICourseEvaluationService;

@Service("courseEvaluationService")
public class CourseEvaluationServiceImpl implements ICourseEvaluationService
{
    @Autowired
    private CourseEvaluationMapper courseEvaluationMapper;

    @Override
    public List<CourseEvaluation> selectEvaluationList(CourseEvaluation eval)
    {
        return courseEvaluationMapper.selectEvaluationList(eval);
    }

    @Override
    public int insertEvaluation(CourseEvaluation eval)
    {
        return courseEvaluationMapper.insertEvaluation(eval);
    }

    @Override
    public boolean checkExists(String sno, String cno)
    {
        return courseEvaluationMapper.checkExists(sno, cno) > 0;
    }

    @Override
    public List<CourseEvaluation> selectEvaluationsByTeacher(String tno)
    {
        return courseEvaluationMapper.selectEvaluationsByTeacher(tno);
    }

    @Override
    public List<Map<String, Object>> selectTeacherEvalStats(String tno)
    {
        return courseEvaluationMapper.selectTeacherEvalStats(tno);
    }
}
