package servlet;

import model.CustomDesign;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CustomSubmitServlet", urlPatterns = "/customsubmit")
public class CustomSubmitServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title, desp, img = "default.jpg";
        int uid, rid;
        //handle the params
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        try {
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
                    for (Object i : items) {
                        FileItem item = (FileItem) i;
                        if (item.isFormField()) {
                            params.put(item.getFieldName(), item.getString("UTF-8"));
                        }
                    }
                    title = (String) params.get("title");
                    desp = (String) params.get("desp");
                    uid = Integer.parseInt((String) params.get("uid"));
                    rid = Integer.parseInt((String) params.get("rid"));
                    if (title == null || "".equals(title)) {
                        throw new Exception("作品标题不能为空！");
                    }
                    if (desp == null || "".equals(desp)) {
                        throw new Exception("作品描述不能为空！");
                    }
                    if (uid == 0) {
                        throw new Exception("登录超时！");
                    }
                    if (rid == 0) {
                        throw new Exception("找不到对应需求！");
                    }
                    for (Object i : items) {
                        FileItem item = (FileItem) i;
                        if (!item.isFormField()) {
                            String fullName = item.getName();
                            //取得上传文件以后的存储路径
                            String appendix = fullName.substring((fullName.lastIndexOf('.')), fullName.length());
                            //图像文件名采用对 rid + uid 的32位 MD5 编码，充分散列。
                            img = utils.Encoder.string2MD5("" + rid + uid) + appendix;
                            //上传文件以后的存储路径
                            String path = request.getRealPath("/img/custom") + File.separatorChar + img;

                            //上传文件
                            File uploaderFile = new File(path);
                            item.write(uploaderFile);
                            //上传成功信息
                            System.out.println("custom上传成功！文件位置：" + path);
                        }
                    }
                    //params正常，插入数据库
                    CustomDesign.addOne(rid, uid, img, desp, title);
                    MessageDispatcher.message(response, "success", "上传成功！", "require_detail.jsp?rid=" + rid);
                } catch (Exception e) {
                    MessageDispatcher.message(response, "danger", e.getMessage(), "custom.jsp");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
