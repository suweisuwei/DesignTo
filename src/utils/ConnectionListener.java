package utils;

import org.apache.commons.logging.impl.Log4JLogger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.ResultSet;

/**
 * 这里只能做到在控制台提示用户，而没办法终止 tomcat 的运行。
 * TODO 做 TOMCAT 终止运行的功能。
 */
public class ConnectionListener implements ServletContextListener {
    private static final Log4JLogger logger = new Log4JLogger();
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        try{
            ResultSet rs = db.DBConnection.querySql("select * from user;");
            if(rs.next()){
                //do nothing,for connection has established.
            }else{
                throw new Exception();
            }
        }catch (Exception e){
            System.out.println("数据库连接失败！请检查数据库状态和连接字段！");
            System.exit(0);
//            throw new IOException("数据库连接失败！请检查数据库状态和连接字段！");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
