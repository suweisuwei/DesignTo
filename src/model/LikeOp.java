package model;

import java.sql.ResultSet;

public class LikeOp {
    private int uid;
    private int pid;

    public LikeOp(ResultSet rs){
        try {
            setUid(rs.getInt(1));
            setPid(rs.getInt(2));
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }
}
