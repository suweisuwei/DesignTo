package model;

import db.DBConnection;

import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

public class User {
    private int uid;
    private String username;
    private String password;
    private String tele;
    private String email;
    private char sex;
    private String header;
    private boolean isadmin;

    public User() {
        setUid(0);
        setUsername("");
        setIsadmin(false);
    }

    /**
     * 返回用户所有信息，如果用户不存在，返回 uid=0的对象。
     *
     * @param rs resultSet
     */
    public User(ResultSet rs) {
        try {
            setUid(rs.getInt(1));
            setUsername(rs.getString(2));
            setPassword(rs.getString(3));
            setTele(rs.getString(4));
            setEmail(rs.getString(5));
            setSex(rs.getString(6).charAt(0));
            setHeader(rs.getString(7));
            setIsadmin(rs.getBoolean(8));
        } catch (Exception e) {
            setUid(0);
            setIsadmin(false);
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

    public boolean getIsadmin() {
        return isadmin;
    }

    public void setIsadmin(boolean isadmin) {
        this.isadmin = isadmin;
    }

    /**
     * 获取单个用户的操作内部接口
     *
     * @param sql
     * @return
     */
    private static User getOneUser(String sql) {
        try {
            ResultSet rs = db.DBConnection.querySql(sql);
            if (rs.next()) {
                User u = new User(rs);
                rs.close();
                return u;
            } else {
                return new User();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 获取多个用户的内部操作接口
     *
     * @param sql
     * @return
     */
    private static List<User> getMultiUser(String sql) {
        List<User> list = new LinkedList<>();
        try {
            ResultSet rs = db.DBConnection.querySql(sql);
            while (rs.next()) {
                list.add(new User(rs));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 通过用户名获取用户信息
     *
     * @param name
     * @return
     */
    //根据用户名获取用户
    public static User getUserByName(String name) {
        return getOneUser("select * from user where username = '" + name + "';");
    }

    /**
     * 通过用户 ID 获取用户信息
     *
     * @param id
     * @return
     */
    //根据用户ID 获取用户
    public static User getUserById(int id) {
        return getOneUser("select * from user where uid = " + id + ";");
    }

    /**
     * 添加一位用户。用户注册操作。
     *
     * @param username
     * @param password
     * @param tele
     * @param email
     * @param sex
     * @param img
     * @return
     */
    //添加一个用户
    public static boolean addOneUser(String username, String password, String tele, String email, char sex, String img) {
        try {
            return db.DBConnection.updateSql("insert into user(username,password,tel,email,sex,header) values('" + username + "','" + password + "','" + tele + "','" + email + "','" + sex + "','" + img + "');");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //获取用户上传作品总数
    public static int getUserDesignCount(int uid) {
        int publicCount;
        try {
            ResultSet rs = DBConnection.querySql("select count(*) from public_design where uid=" + uid + ";");
            if (rs.next()) {
                publicCount = rs.getInt(1);
            } else {
                publicCount = 0;
            }
        } catch (Exception e) {
            publicCount = 0;
        }
        return publicCount;
    }

    //获取用户被点赞总数
    public static int getUserLikeCount(int uid) {
        int likeCount;
        try {
            ResultSet rs = DBConnection.querySql("select sum(count) from public_design where uid = " + uid + ";");
            if (rs.next()) {
                likeCount = Integer.parseInt(rs.getString(1));
            } else {
                likeCount = 0;
            }
        } catch (Exception e) {
            likeCount = 0;
        }
        return likeCount;
    }

    //查询所有用户
    public static List<User> listAllUser() {
        return getMultiUser("select * from user");
    }

    public static boolean modifyUser(int uid, String username, String tele, String email, char sex, int isadmin) {
        try {
            return DBConnection.updateSql("update user set username='" + username + "', tel='" + tele + "', email='" + email + "',sex='" + sex + "',isadmin=" + isadmin + " where uid=" + uid + ";");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean deleteUser(int uid){
        try{
            return DBConnection.updateSql("delete from user where uid = "+uid + ";");
        }catch (Exception e){
            return false;
        }
    }

}
