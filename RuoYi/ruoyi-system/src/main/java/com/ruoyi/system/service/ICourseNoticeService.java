package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CourseNotice;

public interface ICourseNoticeService
{
    public List<CourseNotice> selectCourseNoticeList(CourseNotice notice);

    public CourseNotice selectCourseNoticeById(Long noticeId);

    public int insertCourseNotice(CourseNotice notice);

    public int updateCourseNotice(CourseNotice notice);

    public int deleteCourseNoticeById(Long noticeId);
}
