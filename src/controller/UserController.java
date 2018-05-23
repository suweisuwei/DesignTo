package controller;

import model.User;

public class UserController {
    public static boolean login(String name, String password){
        User user = User.getUserByName(name);
        if(user.getPassword().equals(password)){
            return true;
        }else{
            return false;
        }
    }
}
