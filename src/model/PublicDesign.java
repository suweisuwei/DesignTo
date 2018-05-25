package model;

import db.DBConnection;

import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class PublicDesign {
    private int pid;
    private String name;
    private int theme;
    private String desp;
    private Timestamp time;
    private String img;
    private int count;
    private int uid;

    public PublicDesign(){
        pid = 0;
    }
    public PublicDesign(ResultSet rs) {
        try {
            setPid(rs.getInt(1));
            setName(rs.getString(2));
            setTheme(rs.getInt(3));
            setDesp(rs.getString(4));
            setTime(rs.getTimestamp(5));
            setImg(rs.getString(6));
            setCount(rs.getInt(7));
            setUid(rs.getInt(8));
        } catch (Exception e) {
            pid = 0;
            e.printStackTrace();
        }

    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTheme() {
        return theme;
    }

    public void setTheme(int theme) {
        this.theme = theme;
    }

    public String getDesp() {
        return desp;
    }

    public void setDesp(String desp) {
        this.desp = desp;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    /**
     * 插入一条新的公开作品
     *
     * @param name
     * @param tid
     * @param desp
     * @param time
     * @param img
     * @param uid
     * @return
     */
    public static boolean addOne(String name, int tid, String desp, Timestamp time, String img, int uid) {
        try {
            System.out.println("insert into public_design(name, theme, desp, time, img, count, uid) values('" + name + "', " + tid + ",'" + desp + "', '" + time.toString() + "', '" + img + "', 0, " + uid + ")");
            return DBConnection.updateSql("insert into public_design(name, theme, desp, time, img, count, uid) values('" + name + "', " + tid + ",'" + desp + "', '" + time.toString() + "', '" + img + "', 0, " + uid + ")");
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 点赞操作，涉及2个库的修改。
     *
     * @param pid
     * @param uid
     * @return
     */
    public static boolean likeOne(int pid, int uid) {
        try {
            if(LikeOp.liked(uid, pid)){
                return false;
            }
            boolean result1 = DBConnection.updateSql("update public_design set count = count + 1 where pid = " + pid + ";");
            boolean result2 = DBConnection.updateSql("insert into like_op values(" + uid + "," + pid + ");");
            return result1&&result2;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }


    }

    /**
     * 获取一个用户的所有公开作品
     *
     * @param uid
     * @return
     */
    public static List<PublicDesign> listPublicByUser(int uid) {
        List<PublicDesign> result = new LinkedList<>();
        try {
            ResultSet rs = DBConnection.querySql("select * from public_design where uid = " + uid + ";");
            while (rs.next()) {
                result.add(new PublicDesign(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static List<PublicDesign> listTop(int count) {
        List<PublicDesign> result = new LinkedList<>();
        try {
            ResultSet rs = DBConnection.querySql("select * from public_design order by count desc limit " + count + ";");
            while (rs.next()) {
                result.add(new PublicDesign(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static PublicDesign getDesignById(int pid){
        try{
            ResultSet rs = DBConnection.querySql("select * from public_design where pid = " + pid);
            if(rs.next()){
                return new PublicDesign(rs);
            }else{
                return new PublicDesign();
            }
        }catch (Exception e){
            e.printStackTrace();
            return new PublicDesign();
        }
    }
}
