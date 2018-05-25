package model;

import db.DBConnection;

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

    public static boolean liked(int uid, int pid){
        try {
            ResultSet rs = DBConnection.querySql("select count(*) from like_op where uid =  " + uid + " and pid = " + pid + ";");
            if(rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    //已经存在该条记录。
                    return true;
                } else {
                    return false;
                }
            }else{
                return false;
            }
        }catch (Exception e){
            return false;
        }
    }
}
