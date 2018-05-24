package model;

import java.sql.ResultSet;

public class Theme {
    private int tid;
    private String name;
    private String img;

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
}
