package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.GradeAppeal;

public interface IGradeAppealService
{
    public List<GradeAppeal> selectAppealList(GradeAppeal appeal);

    public List<GradeAppeal> selectAppealsByTeacher(String tno);

    public GradeAppeal selectAppealById(Long appealId);

    public int insertAppeal(GradeAppeal appeal);

    public int handleAppeal(GradeAppeal appeal);

    public boolean checkDuplicateAppeal(String sno, String cno);
}
