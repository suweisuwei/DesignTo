package servlet;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "CheckConnectionServlet",loadOnStartup = 1)
public class CheckConnectionServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException{
        try{
            ResultSet rs = db.DBConnection.querySql("select * from user;");
            if(rs.next()){
                //do nothing,for connection has established.
            }else{
                throw new Exception();
            }
        }catch (Exception e){
            System.out.println("数据库连接失败！");
//            throw new IOException("数据库连接失败！请检查数据库状态和连接字段！");
            super.destroy();
        }
    }
}
