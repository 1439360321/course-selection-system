package com.ruoyi.web.controller.teacher;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import com.ruoyi.system.domain.Class;
import com.ruoyi.system.domain.CourseSelection;
import com.ruoyi.system.domain.Teacher;
import com.ruoyi.system.service.IClassService;
import com.ruoyi.system.service.ICourseSelectionService;
import com.ruoyi.system.service.ITeacherService;

@Controller
@RequestMapping("/teacher")
@RequiresRoles("teacher")
public class TeacherBusinessController extends BaseController
{
    @Autowired
    private IClassService classService;

    @Autowired
    private ICourseSelectionService courseSelectionService;

    @Autowired
    private ITeacherService teacherService;

    @GetMapping("/index")
    public String index(ModelMap mmap)
    {
        mmap.put("tno", getLoginName());
        return "teacher/index";
    }

    @GetMapping("/course")
    public String course(ModelMap mmap)
    {
        mmap.put("tno", getLoginName());
        return "teacher/course/list";
    }

    @PostMapping("/info")
    @ResponseBody
    public AjaxResult info(String tno)
    {
        Teacher teacher = teacherService.selectTeacherById(tno);
        return success().put("data", teacher);
    }

    @PostMapping("/course/list")
    @ResponseBody
    public TableDataInfo courseList(String tno)
    {
        Class clazz = new Class();
        clazz.setTno(tno);
        return getDataTable(classService.selectClassList(clazz));
    }

    @GetMapping("/course/students")
    public String students(String tno, String cno, ModelMap mmap)
    {
        mmap.put("tno", tno);
        mmap.put("cno", cno);
        return "teacher/course/students";
    }

    @PostMapping("/course/students/list")
    @ResponseBody
    public TableDataInfo studentsList(String cno)
    {
        String currentTno = getLoginName();
        Class clazz = classService.selectClassById(currentTno, cno);
        if (clazz == null)
        {
            return getDataTable(new ArrayList<>());
        }
        CourseSelection cs = new CourseSelection();
        cs.setCno(cno);
        return getDataTable(courseSelectionService.selectCourseSelectionList(cs));
    }

    @PostMapping("/grade/save")
    @ResponseBody
    public AjaxResult gradeSave(CourseSelection cs)
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
            return error("Grade save failed: " + e.getMessage());
        }
    }

    @GetMapping("/schedule")
    public String schedule(ModelMap mmap)
    {
        mmap.put("tno", getLoginName());
        return "teacher/schedule";
    }

    @GetMapping("/statistics")
    public String statistics(ModelMap mmap)
    {
        mmap.put("tno", getLoginName());
        return "teacher/statistics";
    }

    @PostMapping("/statistics/list")
    @ResponseBody
    public TableDataInfo statisticsList(String tno)
    {
        List<Map<String, Object>> list = courseSelectionService.selectTeacherGradeStats(tno);
        return getDataTable(list);
    }

    @GetMapping("/course/students/export")
    public void exportStudents(String cno, HttpServletResponse response)
    {
        try
        {
            CourseSelection cs = new CourseSelection();
            cs.setCno(cno);
            List<CourseSelection> list = courseSelectionService.selectCourseSelectionList(cs);

            Workbook wb = new XSSFWorkbook();
            Sheet sheet = wb.createSheet("学生名单");
            Row header = sheet.createRow(0);
            header.createCell(0).setCellValue("学号");
            header.createCell(1).setCellValue("姓名");
            header.createCell(2).setCellValue("平时成绩");
            header.createCell(3).setCellValue("考试成绩");
            header.createCell(4).setCellValue("总评");

            int rowIdx = 1;
            for (CourseSelection item : list)
            {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(item.getSno());
                row.createCell(1).setCellValue(item.getSname());
                if (item.getNormalScore() != null) row.createCell(2).setCellValue(item.getNormalScore().doubleValue());
                if (item.getTestScore() != null) row.createCell(3).setCellValue(item.getTestScore().doubleValue());
                if (item.getNormalScore() != null && item.getTestScore() != null)
                {
                    double total = item.getNormalScore().doubleValue() * 0.4 + item.getTestScore().doubleValue() * 0.6;
                    row.createCell(4).setCellValue(Math.round(total * 10.0) / 10.0);
                }
            }

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode("学生名单_" + cno + ".xlsx", StandardCharsets.UTF_8));
            OutputStream os = response.getOutputStream();
            wb.write(os);
            wb.close();
            os.flush();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @PostMapping("/exam/save")
    @ResponseBody
    public AjaxResult examSave(String tno, String cno, String examTime)
    {
        Class clazz = classService.selectClassById(tno, cno);
        if (clazz == null)
        {
            return error("授课记录不存在");
        }
        clazz.setExamTime(examTime);
        classService.updateClass(clazz);
        return success("考试时间已更新");
    }
}
