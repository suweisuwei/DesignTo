package servlet;

import model.LikeOp;
import model.PublicDesign;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/like")
public class LikeServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        //handle the params
        int uid = 0, pid = 0;
        PrintWriter out = null;
        try{
            out = response.getWriter();
        }catch (Exception e){}
        try {
            uid = Integer.parseInt(request.getParameter("uid"));
            pid = Integer.parseInt(request.getParameter("pid"));
            if (pid == 0 || uid == 0) {
                throw new Exception();
            }
            boolean result = PublicDesign.likeOne(pid, uid);
            if(result){
                out.append("true");
            }else{
                out.append("false");
            }
        }catch (Exception e){
            out.append("false");
        }finally {
            out.flush();
            out.close();
        }
    }
}
