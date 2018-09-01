<%
    int uid = 0;
    Cookie[] cs = request.getCookies();
    if(cs == null){
        response.sendRedirect("login.jsp");
    }
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