package com.ruoyi.web.controller.admin;

import java.util.List;
import java.util.Map;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.DateUtils;

@Controller
@RequestMapping("/admin/security")
@RequiresRoles("admin")
public class SecurityController extends BaseController
{
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping()
    public String index() { return "admin/security/index"; }

    @PostMapping("/events")
    @ResponseBody
    public TableDataInfo events() {
        startPage();
        String sql = "SELECT info_id, login_name AS userName, ipaddr, login_time AS loginTime, status, msg FROM sys_logininfor ORDER BY info_id DESC";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
        return getDataTable(list);
    }

    @GetMapping("/stats")
    @ResponseBody
    public AjaxResult stats() {
        String today = DateUtils.dateTimeNow("yyyy-MM-dd");
        String sql = "SELECT COUNT(*) AS cnt FROM sys_logininfor WHERE status = 1 AND login_time LIKE ?";
        Map<String, Object> result = jdbcTemplate.queryForMap(sql, today + "%");
        return success().put("failCount", result.get("cnt"));
    }
}
