package servlet;

import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response){
        //handle the params
        String username, password;
        try{
            username = request.getParameter("username");
            password = request.getParameter("password");
            if(username == null||password==null|"".equals(username)||"".equals(password)){
                throw new Exception("用户名或密码不能为空！");
            }
        }catch (Exception e){
            MessageDispatcher.message(response,"danger", e.getMessage(), "/login.jsp");
            return;
        }
        User u = User.getUserByName(username);
        if(u.getUid() == 0){
            MessageDispatcher.message(response,"danger", "用户不存在！", "/login.jsp");
            return;
        }
        if(!u.getPassword().equals(password)){
            MessageDispatcher.message(response,"warning", "密码错误！", "/login.jsp");
            return;
        }
        //设置 cookie
        Cookie c = new Cookie("uid",""+u.getUid());
        c.setMaxAge(1000*60*60);
        response.addCookie(c);
        MessageDispatcher.message(response,"success", "登录成功！", "/homepage.jsp");
    }
}
