package servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

public class MessageDispatcher {
    public static void message(HttpServletResponse resp, String type, String content, String url){
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        try {
            resp.sendRedirect("/message.jsp?type="+type+"&content=" + URLEncoder.encode(content) + "&caller="+url);
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
