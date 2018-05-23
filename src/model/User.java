package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    private int uid;
    private String username;
    private String password;
    private String tele;
    private String email;
    private char sex;
    private String header;

    /**
     * 返回用户所有信息，如果用户不存在，返回 uid=0的对象。
     * @param rs
     */
    public User(ResultSet rs){
        try {
            uid = rs.getInt(1);
            username = rs.getString(2);
            password = rs.getString(3);
            tele = rs.getString(4);
            email = rs.getString(5);
            sex = rs.getString(6).charAt(0);
            header = rs.getString(7);
        }catch (Exception e){
            uid = 0;
        }

    }
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTele() {
        return tele;
    }

    public void setTele(String tele) {
        this.tele = tele;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public char getSex() {
        return sex;
    }

    public void setSex(char sex) {
        this.sex = sex;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }
    public static User getUserByName(String name){
        try {
            ResultSet rs = db.DBConnection.querySql("select * from user where username='"+name+"';");
            rs.next();
            User u = new User(rs);
            rs.close();
            return u;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }


    public static void main(String[] args){
        try {
            ResultSet rs = db.DBConnection.querySql("select * from user");
            rs.next();
            while(!rs.isAfterLast()){
                User u = new User(rs);
                System.out.println(u.getUsername()+" header is:"+u.getHeader());
                rs.next();
            }
            rs.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
