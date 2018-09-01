package model;

import db.DBConnection;

import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

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
            if(rs.next()){
                return new Theme(rs);
            }else{
                return new Theme();
            }
        }catch (Exception e){
            e.printStackTrace();
            return new Theme();
        }
    }

    public static List<Theme> listTheme(){
        List<Theme> result = new LinkedList<>();
        try{
            ResultSet rs = DBConnection.querySql("select * from theme");
            while(rs.next()){
                result.add(new Theme(rs));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public static boolean modifyTheme(int tid, String name,String img){
        try{
            return DBConnection.updateSql("update theme set name = '"+name+"', img = '"+img+"' where tid = " + tid + ";");
        }catch (Exception e){
            return false;
        }
    }

    public static boolean deleteTheme(int tid){
        try{
            return DBConnection.updateSql("delete from theme where tid = " + tid + ";");
        }catch (Exception e){
            return false;
        }
    }
    public static boolean addTheme(String name, String img){
        try{
            return DBConnection.updateSql("insert into theme(name, img) values('"+name+"','"+img+"');");
        }catch (Exception e){
            return false;
        }
    }
}
