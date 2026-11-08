package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Lớp cha của mọi lớp DAO: giữ kết nối CSDL dùng chung cho toàn hệ thống.
 * Kết nối được khởi tạo một lần trong constructor DAO1().
 */
public class DAO1 {
    protected static Connection con;

    public DAO1() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/qlst1?useUnicode=true&characterEncoding=UTF-8"
                    + "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
