package model;

import db.DBConnection;

import java.sql.ResultSet;

public class Theme {
    private int tid;
    private String name;
    private String img;

    public Theme(){
        tid = 0;
        name = "未知";
        img = "default.jpg";
    }
    public Theme(ResultSet rs){
        try{
            setTid(rs.getInt(1));
            setName(rs.getString(2));
            setImg(rs.getString(3));
        }catch (Exception e){
            tid = 0;
            e.printStackTrace();
        }
    }
    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }


    public static Theme getThemeById(int tid){
        try{
            ResultSet rs = DBConnection.querySql("select * from theme where tid = " + tid);
            rs.next();
            if(!rs.isAfterLast()){
                return new Theme(rs);
            }else{
                return new Theme();
            }
        }catch (Exception e){
            e.printStackTrace();
            return new Theme();
        }
    }
}
