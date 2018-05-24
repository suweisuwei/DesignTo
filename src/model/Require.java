package model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;

public class Require {
    private int rid;
    private int tid;
    private Timestamp time;
    private Timestamp ddl;
    private String budget;
    private String desp;

    public Require(ResultSet rs){
        try{
            setRid(rs.getInt(1));
            setTid(rs.getInt(2));
            setTime(rs.getTimestamp(3));
            setDdl(rs.getTimestamp(4));
            setBudget(rs.getString(5));
            setDesp(rs.getString(6 ));
        }catch (Exception e){
            rid = 0;
            e.printStackTrace();
        }
    }
    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public Date getDdl() {
        return ddl;
    }

    public void setDdl(Timestamp ddl) {
        this.ddl = ddl;
    }

    public String getBudget() {
        return budget;
    }

    public void setBudget(String budget) {
        this.budget = budget;
    }

    public String getDesp() {
        return desp;
    }

    public void setDesp(String desp) {
        this.desp = desp;
    }
}
