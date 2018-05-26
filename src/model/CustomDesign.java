package model;

import db.DBConnection;

import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

public class CustomDesign {
    private int cid;
    private int rid;
    private int uid;
    private String img;
    private String desp;
    private String title;

    public CustomDesign(){
        cid = 0;
        rid = 0;
        uid = 0;
    }
    public CustomDesign(ResultSet rs){
        try {
            setCid(rs.getInt(1));
            setRid(rs.getInt(2));
            setUid(rs.getInt(3));
            setImg(rs.getString(4));
            setDesp(rs.getString(5));
        }catch (Exception e){
            cid = 0;
            e.printStackTrace();
        }
    }
    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDesp() {
        return desp;
    }

    public void setDesp(String desp) {
        this.desp = desp;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public static List<CustomDesign> listCustomByRid(int rid){
        List<CustomDesign> result = new LinkedList<>();
        try{
            ResultSet rs = DBConnection.querySql("select * from custom_design where rid=" + rid);
            while(rs.next()){
                result.add(new CustomDesign(rs));
            }
        }catch (Exception e){
        }
        return result;
    }

    public static List<CustomDesign> listCustomByUid(int uid){
        List<CustomDesign> result = new LinkedList<>();
        try{
            ResultSet rs = DBConnection.querySql("select * from custom_design where uid=" + uid);
            while(rs.next()){
                result.add(new CustomDesign(rs));
            }
        }catch (Exception e){
        }
        return result;
    }

    public static List<CustomDesign> listDesignByRid(int rid) {
        List<CustomDesign> result = new LinkedList<>();
        try {
            ResultSet rs = DBConnection.querySql("select * from custom_design where rid = " + rid);
            while (rs.next()) {
                result.add(new CustomDesign(rs));
            }
        } catch (Exception e) {

        }
        return result;
    }

    public static boolean addOne(int rid, int uid, String img, String desp, String title){
        try{
             return DBConnection.updateSql("insert into custom_design(rid, uid, img, desp, title) values("+rid+","+uid+",'"+img+"','"+desp+"','"+title+"');");
        }catch (Exception e){
            return false;
        }
    }
}
