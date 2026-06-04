package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.CourseNotice;
import com.ruoyi.system.mapper.CourseNoticeMapper;
import com.ruoyi.system.service.ICourseNoticeService;

@Service
public class CourseNoticeServiceImpl implements ICourseNoticeService
{
    @Autowired
    private CourseNoticeMapper courseNoticeMapper;

    @Override
    public List<CourseNotice> selectCourseNoticeList(CourseNotice notice)
    {
        return courseNoticeMapper.selectCourseNoticeList(notice);
    }

    @Override
    public CourseNotice selectCourseNoticeById(Long noticeId)
    {
        return courseNoticeMapper.selectCourseNoticeById(noticeId);
    }

    @Override
    public int insertCourseNotice(CourseNotice notice)
    {
        return courseNoticeMapper.insertCourseNotice(notice);
    }

    @Override
    public int updateCourseNotice(CourseNotice notice)
    {
        return courseNoticeMapper.updateCourseNotice(notice);
    }

    @Override
    public int deleteCourseNoticeById(Long noticeId)
    {
        return courseNoticeMapper.deleteCourseNoticeById(noticeId);
    }
}
