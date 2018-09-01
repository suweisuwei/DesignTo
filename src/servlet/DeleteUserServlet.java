package servlet;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", urlPatterns = "/deleteuser")
public class DeleteUserServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //handle the params
        int uid = 0;
        try{
            uid = Integer.parseInt(request.getParameter("uid"));
        }catch (Exception e){
            uid = 0;
        }
        if(uid == 0){
            MessageDispatcher.message(response,"danger","该用户不存在！","manage_user.jsp");
        }
        boolean result = User.deleteUser(uid);
        if(result){
            MessageDispatcher.message(response,"success", "删除成功！","manage_user.jsp");
        }else{
            MessageDispatcher.message(response, "danger","删除失败！","manage_user.jsp");
        }
    }

}
