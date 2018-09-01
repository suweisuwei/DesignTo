package servlet;

import model.Theme;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddThemeServlet", urlPatterns = "/addtheme")
public class AddThemeServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //handle the upload
        String name;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //read params
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if(isMultipart) {
            //构造一个文件上传处理对象
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("UTF-8");
            List items;
            Map params = new HashMap();
            try {
                //解析表单中提交的所有参数内容
                items = upload.parseRequest(request);
                for (Object i : items) {
                    FileItem item = (FileItem) i;
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString("UTF-8"));
                    }
                }
                name = (String) params.get("name");
                if (name == null || "".equals(name)) {
                    throw new Exception("主题名不能为空！");
                }
                String imgName = "default.jpg";
                for (Object i : items) {
                    FileItem item = (FileItem) i;
                    //找到文件
                    if (!item.isFormField()) {
                        String inName = item.getName();
                        String fileName = inName.substring(inName.lastIndexOf('\\') + 1, inName.length());
                        String appendix = fileName.substring((fileName.lastIndexOf('.')), fileName.length());
                        imgName = name + appendix;
                        String path = request.getRealPath("/img/theme")+File.separatorChar+imgName;
                        File uploaderFile = new File(path);
                        item.write(uploaderFile);
                    }
                }
                //写库
                boolean result = Theme.addTheme(name, "/img/theme/" + imgName);
                if (result) {
                    MessageDispatcher.message(response, "success", "添加成功！", "manage_theme.jsp");
                } else {
                    MessageDispatcher.message(response, "danger", "添加失败！", "manage_theme.jsp");
                }
            } catch (Exception e) {
                MessageDispatcher.message(response, "danger", e.getMessage(), "manage_theme.jsp");
            }
        }
        }

}
