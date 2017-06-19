<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Student Profile</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./styles/style_profile.css">
        <script>
                function logout(){
                    localStorage.setItem("loginstatus","0");
                    window.location = "index.html";
                }
                function checkfrm(){
                    if(document.forms["bkissfrm"]["bid"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else if(document.forms["bkissfrm"]["bdate"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }
                    else if(document.forms["bkissfrm"]["sdate"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }
                        return true;
                }
                function checkfrm2(){
                    if(document.forms["bksubfrm"]["bid2"].value === ""){
                        document.getElementById("errReg2").innerHTML = "Fields must be filled.";
                        return false;
                    }else
                        return true;
                }
                function bookissue(){
                    document.getElementById("books").style.visibility = "hidden";
                    document.getElementById("bookissue").style.visibility = "visible";
                    document.getElementById("booksubmit").style.visibility = "hidden";
                    document.getElementById("bkusername").value = localStorage.getItem("bkusername");
                }
                function booksubmit(){
                    document.getElementById("books").style.visibility = "hidden";
                    document.getElementById("booksubmit").style.visibility = "visible";
                    document.getElementById("bookissue").style.visibility = "hidden";
                    document.getElementById("bkusername2").value = localStorage.getItem("bkusername");
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
                String username = request.getParameter("stdid");
                %><script>localStorage.setItem("bkusername","<%=username%>");</script><%
                ps = con.prepareStatement("select * from master_login where username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                if(rs.next()){
                    %><script>document.getElementById("head").innerHTML = "<%=rs.getString(1)%>";</script><%
                    %><div id="profile">
                        <div id="prpic"></div><br>
                        <h2 id="dept">Department: <%=rs.getString(2)%></h2>
                        <h2 id="passyear">Passout Year: <%=rs.getString(3)%></h2>
                        <h2 id="univ">University Roll: <%=rs.getString(4)%></h2>
                        <h2 id="id">College ID: <%=rs.getString(5)%></h2>
                    </div>
                    <%
                }
        %>
        <div id="books" style="visibility: visible"><%
            ps = con.prepareStatement("select book_details.bookname,book_details.author,master_book.bdate,master_book.sdate,master_book.bookid from master_book inner join book_details on master_book.bookid = book_details.bookid where master_book.username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                while(rs.next()){
                    %><div id="bklist">
                        <div id="bname"><%=rs.getString(1)%></div>
                        <div id="auth"><%=rs.getString(2)%></div>
                        <div id="bdate">Borrow From: <span style="color:red"><%=rs.getString(3)%></span></div>
                        <div id="bdate" style="margin-left: 330px">Book ID: <span style="color:red"><%=rs.getString(5)%></span></div>
                        <div id="sdate">Renew Within: <span style="color:red"><%=rs.getString(4)%></span></div>
                      </div>
                    <%
                }
       %></div>
       <div id="bookissue" style="visibility: hidden">
           <form name="bookisssueform" id="bkissfrm" onsubmit="return checkfrm()" action="issuebook.jsp">
               <input type="text" id="bkusername" style="visibility:hidden" name="username"><br>
               <input type="text" name="bid" placeholder="Enter Book ID"><br>
               <input type="text" name="bdate" placeholder="Borrow Date"><br>
               <input type="text" name="sdate" placeholder="Renew Within"><br>
               <div id="errReg" style="font-size: 15px;color:white;text-align:center"></div>
               <input type="submit" value="Issue Book">
           </form>
       </div>
       <div id="booksubmit" style="visibility: hidden">
           <form name="booksubmitform" id="bksubfrm" onsubmit="return checkfrm2()" action="subbook.jsp">
               <input type="text" id="bkusername2" style="visibility:hidden" name="username2"><br>
               <input type="text" name="bid2" placeholder="Enter Book ID"><br>
               <div id="errReg2" style="font-size: 15px;color:white;text-align:center"></div>
               <input type="submit" value="Submit Book">
           </form>
       </div>
       <div id="issbk" onclick="bookissue()">Issue Book</div>
       <div id="subbk" onclick="booksubmit()">Submit Book</div>
       <div id="homebtn" onclick="window.location='adminportal.jsp';">Admin Home</div>
        <div id="logout" onclick="logout()">Logout</div>
        <div id="foot">Developed by Subham Sengupta</div>
    </body>
</html>
