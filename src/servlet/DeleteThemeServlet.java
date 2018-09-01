package servlet;

import model.Theme;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteThemeServlet", urlPatterns = "/deletetheme")
public class DeleteThemeServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int tid;
        //handle the param
        try{
            tid = Integer.parseInt(request.getParameter("tid"));
        }catch (Exception e){
            tid = 0;
        }
        if(tid == 0){
            MessageDispatcher.message(response,"danger","主题不存在！","manage_theme.jsp");
        }
        boolean result = Theme.deleteTheme(tid);
        if(result){
            MessageDispatcher.message(response, "success", "删除成功！","manage_theme.jsp");
        }else{
            MessageDispatcher.message(response,"danger","删除失败！","manage_theme.jsp");
        }

    }
}
