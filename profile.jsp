<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./styles/style_profile.css">
        <script>
                if(localStorage.getItem("loginstatus").match("1")){
                    document.write("<title>Welcome " + "<%=request.getParameter("username")%>" + "</title>");
                }else{
                    localStorage.setItem("messagestatus","1");
                    localStorage.setItem("message","you must log in first");
                    window.location = "index.html";
                }
                function logout(){
                    localStorage.setItem("loginstatus","0");
                    window.location = "index.html";
                }
                function showyourbooks(){
                    document.getElementById("own").style.backgroundColor = "white";
                    document.getElementById("own").style.color = "#00cc33";
                    document.getElementById("lib").style.backgroundColor = "#00cc33";
                    document.getElementById("lib").style.color = "white";
                    document.getElementById("prebook").style.visibility = "hidden";
                    document.getElementById("totallst").style.visibility = "hidden";
                    document.getElementById("books").style.visibility = "visible";
                }
                function showtotalbooks(){
                    document.getElementById("lib").style.backgroundColor = "white";
                    document.getElementById("lib").style.color = "#00cc33";
                    document.getElementById("own").style.backgroundColor = "#00cc33";
                    document.getElementById("own").style.color = "white";
                    document.getElementById("prebook").style.visibility = "hidden";
                    document.getElementById("books").style.visibility = "hidden";
                    document.getElementById("totallst").style.visibility = "visible";
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
                <div id="profile">
                    <div id="prpic"></div><br>
                    <h1 id="name"></h1>
                    <h3 id="dept"></h3>
                    <h3 id="passyear"></h3>
                    <h3 id="univ"></h3>
                    <h3 id="id"></h3>
                </div>
                <div id="prebook">
                    <h1 id="txt">Welcome to your profile</h1>
                    <h4>Click on the buttons above to view books</h4>
                </div>
                <div id="books">
                <%
                String username = request.getParameter("username");
                ps = con.prepareStatement("select * from master_login where username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                if(rs.next()){
                    %><script>
                        document.getElementById("name").innerHTML = "<%=rs.getString(1)%>";
                        document.getElementById("dept").innerHTML = "Department: " + "<%=rs.getString(2)%>";
                        document.getElementById("passyear").innerHTML = "Batch: " +"<%=rs.getString(3)%>";
                        document.getElementById("univ").innerHTML = "University Roll: " + "<%=rs.getString(4)%>";
                        document.getElementById("id").innerHTML = "College ID: " + "<%=rs.getString(5)%>";
                    </script><%
                }
                ps = con.prepareStatement("select book_details.bookname,book_details.author,master_book.bdate,master_book.sdate from master_book inner join book_details on master_book.bookid = book_details.bookid where master_book.username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                while(rs.next()){
                    %><div id="bklist">
                        <div id="bname"><%=rs.getString(1)%></div>
                        <div id="auth"><%=rs.getString(2)%></div>
                        <div id="bdate">Borrow From: <span style="color:red"><%=rs.getString(3)%></span></div>
                        <div id="sdate">Renew Within: <span style="color:red"><%=rs.getString(4)%></span></div>
                      </div>
                    <%
                }
                %></div>
                <div id="totallst"><%
                ps = con.prepareStatement("select * from book_details");
                rs = ps.executeQuery();
                while(rs.next()){
                    %><div id="bklst2">
                        <div id="bname"><%=rs.getString(2)%></div>
                        <div id="auth"><%=rs.getString(3)%></div>
                        <div id="bdate">Book ID: <span style="color:red"><%=rs.getString(1)%></span></div>
                        <div id="sdate">Category: <span style="color:red"><%=rs.getString(4)%></span></div>
                      </div>
                    <%
                }
        %>
        </div>
        <div id="head">Student Portal</div>
        <div id="logout" onclick="logout()">Logout</div>
        <div>
            <div class="info" id="own" onclick="showyourbooks()">Your Books</div>
            <div class="info" id="lib" onclick="showtotalbooks()">In Library</div>
        </div>
        <div id="foot">Developed by Pankaj Kumar</div>
    </body>
</html>
