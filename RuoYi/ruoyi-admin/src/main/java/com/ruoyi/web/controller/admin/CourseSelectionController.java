package com.ruoyi.web.controller.admin;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.service.ICourseSelectionService;

@Controller
@RequestMapping("/admin/courseselection")
public class CourseSelectionController extends BaseController
{
    private String prefix = "admin/courseselection";

    @Autowired
    private ICourseSelectionService courseSelectionService;

    @RequiresPermissions("admin:courseselection:view")
    @GetMapping()
    public String list() { return prefix + "/list"; }

    @RequiresPermissions("admin:courseselection:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(CourseSelection cs)
    {
        String loginName = getLoginName();
        
        if (loginName != null && loginName.startsWith("T"))
        {
            startPage();
            List<CourseSelection> list = courseSelectionService.selectCourseSelectionListByTeacher(loginName, cs);
            return getDataTable(list);
        }
        else
        {
            startPage();
            List<CourseSelection> list = courseSelectionService.selectCourseSelectionList(cs);
            return getDataTable(list);
        }
    }

    @RequiresPermissions("admin:courseselection:edit")
    @GetMapping("/edit/{sno}/{cno}")
    public String edit(@PathVariable("sno") String sno, @PathVariable("cno") String cno, ModelMap mmap)
    {
        mmap.put("cs", courseSelectionService.selectCourseSelectionById(sno, cno));
        return prefix + "/edit";
    }

    @Log(title = "选课记录", businessType = BusinessType.UPDATE)
    @RequiresPermissions("admin:courseselection:edit")
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(CourseSelection cs)
    {
        try
        {
            return toAjax(courseSelectionService.updateCourseSelection(cs));
        }
        catch (IllegalArgumentException e)
        {
            return error(e.getMessage());
        }
        catch (Exception e)
        {
            return error("成绩更新失败：" + e.getMessage());
        }
    }

    @Log(title = "选课记录", businessType = BusinessType.DELETE)
    @RequiresPermissions("admin:courseselection:remove")
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        try
        {
            String[] arr = ids.split(",");
            return toAjax(courseSelectionService.deleteCourseSelectionById(arr[0], arr[1]));
        }
        catch (Exception e)
        {
            return error("删除失败：" + e.getMessage());
        }
    }
}
