package servlet;

import model.Require;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

@WebServlet(urlPatterns = "/require_submit")
public class RequireSubmitServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        try{
            request.setCharacterEncoding("utf-8");
        }catch (Exception e){}
        String title, budget, desp;
        Timestamp ddl;
        int theme, uid = 0;
        //handle the params
        try {
            try {
                Cookie[] cs = request.getCookies();
                for (Cookie c : cs) {
                    if (c.getName().equals("uid")) {
                        uid = Integer.parseInt(c.getValue());
                    }
                }
            } catch (Exception e) {
                throw new Exception("登录失败！");
            }
            title = request.getParameter("title");
            budget = request.getParameter("budget");
            desp = request.getParameter("desp");
            String ddlStr = request.getParameter("ddl");
            theme = Integer.parseInt(request.getParameter("theme"));
            if (uid == 0) {
                throw new Exception("登录超时！");
            }
            if (title == null || "".equals(title)) {
                throw new Exception("需求标题不能为空！");
            }
            if (budget == null || "".equals(budget)) {
                throw new Exception("需求预算不能为空！");
            }
            if (desp == null || "".equals(desp)) {
                throw new Exception("需求描述不能为空！");
            }
            if (ddlStr == null || "".equals(ddlStr)) {
                throw new Exception("截止时间不能为空！");
            }
            try {
                ddl = Timestamp.valueOf(ddlStr);
            } catch (Exception e) {
                throw new Exception("截止时间格式异常！");
            }
            boolean result = Require.submitRequire(theme, ddl, budget, desp, uid, title);
            if (result) {
                MessageDispatcher.message(response, "success", "添加成功！", "custom.jsp");
            } else {
                throw new Exception("添加失败！");
            }
        } catch (Exception e) {
            MessageDispatcher.message(response, "danger", e.getMessage(), "require_submit.jsp");
        }
    }
}
