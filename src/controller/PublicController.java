package controller;

import model.PublicDesign;

import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

public class PublicController {

    public static List<PublicDesign> getTopPublic(int count){
        List<PublicDesign> list = new LinkedList<>();
        try {
            ResultSet rs = db.DBConnection.querySql("select * from public_design order by count desc limit " + count + ";");
            rs.next();
            while(!rs.isAfterLast()){
                list.add(new PublicDesign(rs));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
}
