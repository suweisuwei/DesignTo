package servlet;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ModifyUserServlet",urlPatterns = "/modifyuser")
public class ModifyUserServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //handle the params
        String username,tele,email;
        int uid = 0;
        char sex;
        int isadmin;
        try{
            username = request.getParameter("username");
            tele = request.getParameter("tele");
            email = request.getParameter("email");
            isadmin = Integer.parseInt(request.getParameter("isadmin"));
            try {
                uid = Integer.parseInt(request.getParameter("uid"));
            }catch (Exception e){
                throw new Exception("用户ID不存在！");
            }
            try {
                sex = request.getParameter("sex").charAt(0);
            }catch (Exception e){
                throw new Exception("性别参数错误！");
            }
            if(username == null|| "".equals(username)){
                throw new Exception("用户名不能为空！");
            }
            if(tele == null||"".equals(tele)){
                throw new Exception("电话不能为空！");
            }
            if(email == null || "".equals(email)){
                throw new Exception("邮箱不能为空！");
            }
            //modify the user
            boolean result = User.modifyUser(uid,username,tele,email,sex,isadmin);
            if(result){
                MessageDispatcher.message(response, "success","修改成功！","manage_user.jsp");
            }else{
                MessageDispatcher.message(response, "danger", "修改失败！","manage_user.jsp");
            }
        }catch (Exception e){
            MessageDispatcher.message(response, "danger",e.getMessage(),"modify_user.jsp");
        }

    }
}
