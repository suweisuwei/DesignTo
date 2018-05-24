package servlet;

import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * 确认用户是否存在。返回 True 则存在，False 则不存在。
 */
@WebServlet(urlPatterns = "/userexist")
public class CheckUsernameExist extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response){
        String username = request.getParameter("username");
        try {
            PrintWriter out = response.getWriter();
            if(username != null){
                User u = User.getUserByName(username);
                if(u.getUid()!=0){
                    out.append("true");
                }else{
                    out.append("false");
                }
            }else{
                out.append("false");
            }
            out.flush();
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
