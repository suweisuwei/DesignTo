package servlet;

import model.User;
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
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SignupServlet", urlPatterns = "/signup")
public class SignupServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username="default", password, tele, email,headerName="default.jpg";
        char sex;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //read params
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);


        //上传文件
        if (isMultipart) {
            //构造一个文件上传处理对象
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("UTF-8");
            List items;
            Map params = new HashMap();
            try {
                //解析表单中提交的所有参数内容
                items = upload.parseRequest(request);
                for(Object i : items){
                    FileItem item = (FileItem) i;
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString("UTF-8"));
                    }
                }
                username = (String) params.get("username");
                password = (String)params.get("password");
                tele = (String)params.get("tele");
                email = (String)params.get("email");
                sex = ((String)params.get("sex")).charAt(0);
                if (username == null) {
                    throw new Exception("用户名不为空！");
                }
                User u = User.getUserByName(username);
                if (u.getUid() != 0) {
                    throw new Exception("用户名已经存在！");
                }
                if (password == null) {
                    throw new Exception("密码不为空！");
                }
                if (tele == null) {
                    throw new Exception("电话不为空！");
                }
                if (email == null) {
                    throw new Exception("邮箱不为空！");
                }
                if (sex != 'M' && sex != 'F') {
                    throw new Exception("性别选择错误！");
                }

                for(Object i : items) {
                    FileItem item = (FileItem) i;
                    if (!item.isFormField()) {
                        //取出上传文件的文件名称
                        String name = item.getName();
                        //取得上传文件以后的存储路径
                        String fileName = name.substring(name.lastIndexOf('\\') + 1, name.length());
                        String appendix = fileName.substring((fileName.lastIndexOf('.')), fileName.length());
                        headerName = username + appendix;
                        //上传文件以后的存储路径
                        String path = request.getRealPath("/img/headers") + File.separatorChar + headerName;

                        //上传文件
                        File uploaderFile = new File(path);
                        item.write(uploaderFile);
                        //上传成功信息
                        System.out.println("头像上传成功！文件位置："+path);
                    }
                }
            } catch (Exception e) {
                MessageDispatcher.message(response, "danger", e.getMessage(), "signup.jsp");
                e.printStackTrace();
                return;
            }
            //params正常，插入数据库
            try{
                User.addOneUser(username,password,tele,email,sex,"/img/header/"+headerName);
                MessageDispatcher.message(response, "success", "注册成功！", "login.jsp");
            }catch (Exception e){
                MessageDispatcher.message(response, "danger", e.getMessage(), "signup.jsp");
            }
        }
    }
}
