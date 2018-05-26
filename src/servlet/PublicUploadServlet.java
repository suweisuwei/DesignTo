package servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@WebServlet(urlPatterns = "/uploadPublic")
public class PublicUploadServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        String name, desp, img = "default.jpg";
        int tid = 0, uid = 0;
        Timestamp time;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //handle cookie
        Cookie[] cookies = request.getCookies();
        for (Cookie c : cookies) {
            if (c.getName().equals("uid")) {
                uid = Integer.parseInt(c.getValue());
            }
        }
        if (uid == 0) {
            MessageDispatcher.message(response, "warning", "登录超时，请重新登录！", "login.jsp");
            return;
        }
        //handle params
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
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
                for (Object i : items) {
                    FileItem item = (FileItem) i;
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString("UTF-8"));
                    }
                }
                name = (String) params.get("name");
                desp = (String) params.get("desp");
                tid = Integer.parseInt((String)params.get("theme"));

                time = new Timestamp(System.currentTimeMillis());

                if (name == null || "".equals(name)) {
                    throw new Exception("名称不能为空！");
                }
                if (desp == null || "".equals(desp)) {
                    throw new Exception("故事不能为空！");
                }
                if (tid == 0) {
                    throw new Exception("主题选择错误！");
                }
                //save image
                for (Object i : items) {
                    FileItem item = (FileItem) i;
                    if (!item.isFormField()) {
                        //取出上传文件的文件名称
                        String fullName = item.getName();
                        //取得上传文件以后的存储路径
                        String appendix = fullName.substring((fullName.lastIndexOf('.')), fullName.length());
                        //图像文件名采用对 username+time 的32位 MD5 编码，充分散列。
                        img = utils.Encoder.string2MD5(name + time) + appendix;
                        //上传文件以后的存储路径
                        String path = request.getRealPath("/img/public") + File.separatorChar + img;

                        //上传文件
                        File uploaderFile = new File(path);
                        item.write(uploaderFile);
                        //上传成功信息
                        System.out.println("public上传成功！文件位置：" + path);
                    }
                }
                //insert db
                boolean result = model.PublicDesign.addOne(name, tid, desp, time, "/img/public/" + img, uid);
                if (result) {
                    MessageDispatcher.message(response, "success", "发布成功！", "usercenter_public.jsp?uid="+uid);
                } else {
                    MessageDispatcher.message(response, "danger", "发布失败！请重新尝试！", "usercenter_upload.jsp?uid="+uid);
                }
            } catch (Exception e) {
                MessageDispatcher.message(response, "danger", e.getMessage(), "usercenter_upload.jsp?uid="+uid);
            }
        }

    }
}
