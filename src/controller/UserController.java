package controller;

import model.User;

public class UserController {
    /**
     * 用户登录操作
     */
    public static boolean login(String name, String password){
        User user = User.getUserByName(name);
        if(user.getPassword().equals(password)){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 用户注册操作
     */
    public static boolean signup(String name, String password, String tele, String email, char sex, String img){
        return User.addOneUser(name, password, tele, email, sex, img);
    }



}
