package model;

import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

public class PublicDesign {
    private int pid;
    private String name;
    private int theme;
    private String desp;
    private Timestamp time;
    private String img;
    private int count;

    public PublicDesign(ResultSet rs){
        try {
            setPid(rs.getInt(1));
            setName(rs.getString(2));
            setTheme(rs.getInt(3));
            setDesp(rs.getString(4));
            setTime(rs.getTimestamp(5));
            setImg(rs.getString(6));
            setCount(rs.getInt(7));
        }catch (Exception e){
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
}
