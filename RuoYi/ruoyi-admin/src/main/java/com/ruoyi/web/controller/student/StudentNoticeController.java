package com.ruoyi.web.controller.student;

import java.util.*;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.domain.CourseNotice;
import com.ruoyi.system.mapper.CourseNoticeMapper;
import com.ruoyi.system.service.ICourseSelectionService;

@Controller
@RequestMapping("/student/notice")
@RequiresRoles("student")
public class StudentNoticeController extends BaseController
{
    @Autowired
    private ICourseSelectionService csService;
    @Autowired
    private CourseNoticeMapper noticeMapper;

    @GetMapping()
    public String notice() { return "student/notice/list"; }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list() {
        String sno = ShiroUtils.getLoginName();
        CourseSelection cs = new CourseSelection();
        cs.setSno(sno);
        List<CourseSelection> myCourses = csService.selectCourseSelectionList(cs);
        Set<String> cnos = new HashSet<>();
        for (CourseSelection c : myCourses) cnos.add(c.getCno());
        if (cnos.isEmpty()) return getDataTable(Collections.emptyList());
        startPage();
        return getDataTable(noticeMapper.selectCourseNoticeListByCnos(cnos));
    }
}
