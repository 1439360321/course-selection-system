package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.GradeAppeal;

public interface GradeAppealMapper
{
    public List<GradeAppeal> selectAppealList(GradeAppeal appeal);

    public List<GradeAppeal> selectAppealsByTeacher(Map<String, Object> params);

    public GradeAppeal selectAppealById(Long appealId);

    public int insertAppeal(GradeAppeal appeal);

    public int updateAppeal(GradeAppeal appeal);

    public int selectCountBySnoAndCno(Map<String, Object> params);
}
