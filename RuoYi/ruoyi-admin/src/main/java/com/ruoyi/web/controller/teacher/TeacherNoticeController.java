package com.ruoyi.web.controller.teacher;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.ShiroUtils;
import com.ruoyi.system.domain.Class;
import com.ruoyi.system.domain.CourseNotice;
import com.ruoyi.system.service.IClassService;
import com.ruoyi.system.service.ICourseNoticeService;

@Controller
@RequestMapping("/teacher/notice")
@RequiresRoles("teacher")
public class TeacherNoticeController extends BaseController
{
    @Autowired
    private ICourseNoticeService courseNoticeService;

    @Autowired
    private IClassService classService;

    @GetMapping()
    public String notice()
    {
        return "teacher/notice/list";
    }

    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(CourseNotice notice)
    {
        String tno = getLoginName();
        // 获取该教师所授课程的cno列表
        Class search = new Class();
        search.setTno(tno);
        List<Class> classes = classService.selectClassList(search);
        // 提取cno集合
        java.util.Set<String> cnos = new java.util.HashSet<>();
        for (Class c : classes)
        {
            if (c.getCno() != null)
            {
                cnos.add(c.getCno());
            }
        }
        // 如果教师没有任何课程，直接返回空
        if (cnos.isEmpty())
        {
            return getDataTable(java.util.Collections.emptyList());
        }
        // 通过cno查询通知
        startPage();
        List<CourseNotice> list = courseNoticeMapper.selectCourseNoticeListByCnos(cnos);
        return getDataTable(list);
    }

    @Autowired
    private com.ruoyi.system.mapper.CourseNoticeMapper courseNoticeMapper;

    @GetMapping("/add")
    public String add(ModelMap mmap)
    {
        String tno = getLoginName();
        Class search = new Class();
        search.setTno(tno);
        List<Class> classes = classService.selectClassList(search);
        mmap.put("classes", classes);
        return "teacher/notice/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(CourseNotice notice)
    {
        notice.setTno(getLoginName());
        return toAjax(courseNoticeService.insertCourseNotice(notice));
    }

    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        Long noticeId = Long.valueOf(ids);
        return toAjax(courseNoticeService.deleteCourseNoticeById(noticeId));
    }
}
