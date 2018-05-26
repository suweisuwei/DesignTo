package model;

import db.DBConnection;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Require {
    private int rid;
    private int tid;
    private Timestamp time;
    private Timestamp ddl;
    private String budget;
    private String desp;
    private int uid;
    private String title;

    public Require() {
        rid = 0;
    }

    public Require(ResultSet rs) {
        try {
            setRid(rs.getInt(1));
            setTid(rs.getInt(2));
            setTime(rs.getTimestamp(3));
            setDdl(rs.getTimestamp(4));
            setBudget(rs.getString(5));
            setDesp(rs.getString(6));
            setUid(rs.getInt(7));
            setTitle(rs.getString(8));
        } catch (Exception e) {
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

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public static Require getRequireByRid(int rid) {
        try {
            ResultSet rs = DBConnection.querySql("select * from requirement where rid=" + rid);
            if (rs.next()) {
                return new Require(rs);
            } else {
                return new Require();
            }
        } catch (Exception e) {
            return new Require();
        }
    }

    public static List<Require> listRequire() {
        List<Require> result = new LinkedList<>();
        try {
            ResultSet rs = DBConnection.querySql("select * from requirement");
            while (rs.next()) {
                result.add(new Require(rs));
            }
        } catch (Exception e) {

        }
        return result;
    }

    public static List<Require> listRequireByUid(int uid) {
        List<Require> result = new LinkedList<>();
        try {
            ResultSet rs = DBConnection.querySql("select * from requirement where uid =" + uid + ";");
            while (rs.next()) {
                result.add(new Require(rs));
            }
        } catch (Exception e) {

        }
        return result;
    }

    public static boolean submitRequire(int tid, Timestamp ddl, String budget, String desp, int uid, String title) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        try {
            System.out.println("insert into requirement(theme, time, deadline, budget, desp, uid, title) values(" + tid + ",'" + time + "','" + ddl + "','" + budget + "','" + desp + "',"+uid+",'"+title+"');");
            return DBConnection.updateSql("insert into requirement(theme, time, deadline, budget, desp, uid, title) values(" + tid + ",'" + time + "','" + ddl + "','" + budget + "','" + desp + "',"+uid+",'"+title+"');");
        } catch (Exception e) {
            return false;
        }
    }
}
