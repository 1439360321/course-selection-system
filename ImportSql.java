import java.io.*;
import java.sql.*;

public class ImportSql {
    public static void main(String[] args) {
        String sqlFile = "d:\\course-selection-system\\temp_project\\course_selection.sql";
        String url = "jdbc:mysql://localhost:3306/course_selection?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8";
        String user = "root";
        String password = "123456";
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(sqlFile), "GBK"))) {
            
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            
            StringBuilder sb = new StringBuilder();
            String line;
            int count = 0;
            
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("--") || line.startsWith("/*")) {
                    continue;
                }
                sb.append(line);
                if (line.endsWith(";")) {
                    try {
                        stmt.execute(sb.toString());
                        count++;
                    } catch (SQLException e) {
                        if (!e.getMessage().contains("Duplicate entry")) {
                            System.out.println("Error executing: " + sb.toString().substring(0, Math.min(50, sb.length())) + "...");
                            System.out.println("Error: " + e.getMessage());
                        }
                    }
                    sb = new StringBuilder();
                }
            }
            
            conn.commit();
            System.out.println("Import completed! Executed " + count + " statements.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}