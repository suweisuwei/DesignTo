package model;

import java.sql.ResultSet;

public class CustomDesign {
    private int cid;
    private int rid;
    private int uid;
    private String img;
    private String desp;

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
}
