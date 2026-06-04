package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.GradeAppeal;
import com.ruoyi.system.mapper.GradeAppealMapper;
import com.ruoyi.system.service.IGradeAppealService;

@Service
public class GradeAppealServiceImpl implements IGradeAppealService
{
    @Autowired
    private GradeAppealMapper appealMapper;

    @Override
    public List<GradeAppeal> selectAppealList(GradeAppeal appeal) {
        return appealMapper.selectAppealList(appeal);
    }

    @Override
    public List<GradeAppeal> selectAppealsByTeacher(String tno) {
        Map<String, Object> params = new HashMap<>();
        params.put("tno", tno);
        return appealMapper.selectAppealsByTeacher(params);
    }

    @Override
    public GradeAppeal selectAppealById(Long appealId) {
        return appealMapper.selectAppealById(appealId);
    }

    @Override
    public int insertAppeal(GradeAppeal appeal) {
        return appealMapper.insertAppeal(appeal);
    }

    @Override
    public int handleAppeal(GradeAppeal appeal) {
        return appealMapper.updateAppeal(appeal);
    }

    @Override
    public boolean checkDuplicateAppeal(String sno, String cno) {
        Map<String, Object> params = new HashMap<>();
        params.put("sno", sno);
        params.put("cno", cno);
        return appealMapper.selectCountBySnoAndCno(params) > 0;
    }
}
