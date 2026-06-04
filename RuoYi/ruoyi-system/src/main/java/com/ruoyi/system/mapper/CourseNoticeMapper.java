package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Set;
import com.ruoyi.system.domain.CourseNotice;

public interface CourseNoticeMapper
{
    public List<CourseNotice> selectCourseNoticeList(CourseNotice notice);

    public List<CourseNotice> selectCourseNoticeListByCnos(Set<String> cnos);

    public CourseNotice selectCourseNoticeById(Long noticeId);

    public int insertCourseNotice(CourseNotice notice);

    public int updateCourseNotice(CourseNotice notice);

    public int deleteCourseNoticeById(Long noticeId);
}
