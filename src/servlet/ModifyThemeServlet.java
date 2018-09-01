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

@WebServlet(name = "ModifyThemeServlet", urlPatterns = "/modifytheme")
public class ModifyThemeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //handle the params of theme
        String name;
        int tid;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //read params
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if(isMultipart){
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
                name = (String)params.get("name");
                tid = Integer.parseInt((String)params.get("tid"));
                if(name == null||"".equals(name)){
                    throw new Exception("主题名不能为空！");
                }
                Theme theme = Theme.getThemeById(tid);
                boolean modifyImg = false;
                String imgName = theme.getImg();
                for (Object i : items) {
                    FileItem item = (FileItem) i;
                    //找到文件
                    if (!item.isFormField()) {
                        String uploadName = item.getName();
                        modifyImg = true;
                        boolean hasFile = item.getSize()>0;
                        //是否选择了文件
                        if(hasFile){
                            //读 img 名
                            String fileName = uploadName.substring(name.lastIndexOf('\\') + 1, uploadName.length());
                            String appendix = fileName.substring((fileName.lastIndexOf('.')), fileName.length());
                            imgName = theme.getName() + appendix;
                            String img = request.getRealPath("/img/theme/")+imgName;
                            File file = new File(img);
                            if(file.exists()){
                                boolean result = file.delete();
                                File newFile = new File(img);
                                item.write(newFile);
                            }else{
                                item.write(file);
                            }

                        }
                    }
                }
                //写库
                boolean modifyName = Theme.modifyTheme(tid, name, "/img/theme/"+imgName);
                if(modifyImg||modifyName){
                    MessageDispatcher.message(response, "success", "修改成功！","manage_theme.jsp");
                }else{
                    MessageDispatcher.message(response, "danger", "修改失败！","manage_theme.jsp");
                }
            }catch (Exception e){
                MessageDispatcher.message(response,"danger",e.getMessage(), "manage_theme.jsp");
            }

        }

    }
}
