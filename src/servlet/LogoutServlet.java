package servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LogoutServlet", urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response){
        Cookie[] cs = request.getCookies();
        for(Cookie c : cs) {
            if(c.getName().equals("uid"));
            c.setMaxAge(0);
        }
        MessageDispatcher.message(response, "success", "已退出！", "login.jsp");
    }
}
