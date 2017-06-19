<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Book</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./styles/style_profile.css">
        <script>
                function logout(){
                    localStorage.setItem("loginstatus","0");
                    window.location = "index.html";
                }
        </script>
    </head>
    <body>
        <%!
                Connection con = null;
                ResultSet rs = null;
                PreparedStatement ps = null;
        %>
        <%
                try{
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    con = DriverManager.getConnection("jdbc:odbc:lib");
                }catch(Exception e){
                    out.println(e);
                }
          %>
        <div id="head"></div>
        <%
                String bookid = request.getParameter("bookid");
                ps = con.prepareStatement("select * from book_details where bookid = ?");
                ps.setString(1,bookid);
                rs = ps.executeQuery();
                if(rs.next()){
                    %><script>document.getElementById("head").innerHTML = "<%=rs.getString(2)%>";</script><%
                    %><div id="profile">
                        <div id="prpic"></div><br>
                        <h2 id="dept">Author: <%=rs.getString(3)%></h2>
                        <h2 id="passyear">Book ID: <%=rs.getString(1)%></h2>
                        <h2 id="univ">Category: <%=rs.getString(4)%></h2>
                        <h2 id="id">Quantity: <%=rs.getString(5)%></h2>
                    </div>
                    <%
                }
        %>
        <div id="books" style="visibility: visible"><%
            ps = con.prepareStatement("select master_login.naam,master_login.dept,master_login.passyear,master_login.univ,master_login.id from master_login inner join master_book on master_login.username = master_book.username where master_book.bookid = ?");
            ps.setString(1,bookid);
            rs = ps.executeQuery();
                while(rs.next()){
                    %><div id="bklist" style="height:max-content;text-align: center">
                        <div id="bname"><%=rs.getString(1)%></div>
                        <div id="auth">Department: <%=rs.getString(2)%></div>
                        <div id="auth" style="font-size: 20px;">Batch: <span style="color:red"><%=rs.getString(3)%></span></div>
                        <div id="auth" style="font-size: 20px;">University Roll: <span style="color:green"><%=rs.getString(4)%></span></div>
                        <div id="auth" style="font-size: 20px;">College ID: <span style="color:green"><%=rs.getString(5)%></span></div>
                      </div>
                    <%
                }
       %></div>
       <div id="homebtn" onclick="window.location='adminportal.jsp';">Admin Home</div>
        <div id="logout" onclick="logout()">Logout</div>
        <div id="foot">Developed by Subham Sengupta</div>
    </body>
</html>
