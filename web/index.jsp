<%
    int uid = 0;
    Cookie[] cs = request.getCookies();
    for(Cookie c : cs) {
        if(c.getName().equals("uid")){
            uid = Integer.parseInt(c.getValue());
        }
    }
    if(uid!=0){
        response.sendRedirect("homepage.jsp");
    }else{
        response.sendRedirect("login.jsp");
    }
%>