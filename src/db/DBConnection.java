package db;

import java.sql.*;
import java.util.Properties;

public class DBConnection {
    private static final String USERNAME = "root";
    private static final String PASSWORD = "djj213xhx666";

    /**
     * 创建一个连接
     * @return Connection对象
     */
    private static Connection getConnection(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
        }
        Properties prop = new Properties();
        prop.setProperty("user", USERNAME);
        prop.setProperty("password", PASSWORD);
        Connection con = null;
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/DesignTo?useUnicode=true&characterEncoding=utf8", prop);
        } catch (Exception e) {
        }
        if (con == null) {

            System.out.println("Connection is NULL!");
        }
        return con;
    }

    /**
     * <h2>查询接口</h2>
     * 传入 SQL，获取 ResultSet 集合
     * @param sql 查询的 SQL 语句。
     * @return 结果集合
     * @throws SQLException
     */
    public static ResultSet querySql(String sql) throws SQLException {
        Connection con = getConnection();
        Statement statement = con.createStatement();
        ResultSet rs = statement.executeQuery(sql);
        return rs;

    }

    /**
     * <h2>插入、修改、删除接口</h2>
     * 传入 SQL，得到操作的结果：True/False
     * @param sql
     * @return
     * @throws SQLException
     */
    public static boolean updateSql(String sql) throws SQLException{
        Connection con = getConnection();
        Statement statement = con.createStatement();
        int result = statement.executeUpdate(sql);
        statement.close();
        con.close();
        return result>0;
    }
}
