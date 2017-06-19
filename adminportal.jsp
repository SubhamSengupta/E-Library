<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <head>
        <%!     
                Connection con = null;
                ResultSet rs = null;
                PreparedStatement ps = null;
        %>
        <script>
            var switchstatus = 0;
            if(!localStorage.getItem("loginstatus").match("1")){
                    localStorage.setItem("messagestatus","1");
                    localStorage.setItem("message","you must log in first");
                    window.location = "index.html";
                }
            function addbook(){
                if(switchstatus === 0)
                    doswitch();
                document.getElementById("adbk").style.backgroundColor = "white";
                document.getElementById("adbk").style.color = "black";
                document.getElementById("shbk").style.backgroundColor = "transparent";
                document.getElementById("shbk").style.color = "white";
                document.getElementById("std").style.backgroundColor = "transparent";
                document.getElementById("std").style.color = "white";
                document.getElementById("foradbk").style.visibility = "visible";
                document.getElementById("forshbk").style.visibility = "hidden";
                document.getElementById("forstd").style.visibility = "hidden";
                document.getElementById("searchbox").style.visibility = "hidden";
                document.getElementById("searchbox2").style.visibility = "hidden";
            }
            function showbook(){
                if(switchstatus === 0)
                    doswitch();
                document.getElementById("shbk").style.backgroundColor = "white";
                document.getElementById("shbk").style.color = "black";
                document.getElementById("adbk").style.backgroundColor = "transparent";
                document.getElementById("adbk").style.color = "white";
                document.getElementById("std").style.backgroundColor = "transparent";
                document.getElementById("std").style.color = "white";
                document.getElementById("forshbk").style.visibility = "visible";
                document.getElementById("searchbox").style.visibility = "visible";
                document.getElementById("foradbk").style.visibility = "hidden";
                document.getElementById("forstd").style.visibility = "hidden";
                document.getElementById("searchbox2").style.visibility = "hidden";
            }
            function showstud(){
                if(switchstatus === 0)
                    doswitch();
                document.getElementById("std").style.backgroundColor = "white";
                document.getElementById("std").style.color = "black";
                document.getElementById("shbk").style.backgroundColor = "transparent";
                document.getElementById("shbk").style.color = "white";
                document.getElementById("adbk").style.backgroundColor = "transparent";
                document.getElementById("adbk").style.color = "white";
                document.getElementById("forstd").style.visibility = "visible";
                document.getElementById("searchbox2").style.visibility = "visible";
                document.getElementById("foradbk").style.visibility = "hidden";
                document.getElementById("searchbox").style.visibility = "hidden";
                document.getElementById("forshbk").style.visibility = "hidden";
            }
            function doswitch(){
                switchstatus = 1;
                document.getElementById("adbk").style.top = "85px";
                document.getElementById("adbk").style.left = "20px";
                document.getElementById("shbk").style.left = "20px";
                document.getElementById("shbk").style.top = "265px";
                document.getElementById("std").style.left = "20px";
                document.getElementById("std").style.top = "445px";
            }
            function checkfrm(){
                    if(document.forms["bkfrm"]["bid"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else if(document.forms["bkfrm"]["bname"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else if(document.forms["bkfrm"]["auth"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else if(document.forms["bkfrm"]["cat"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else if(document.forms["bkfrm"]["qnty"].value === ""){
                        document.getElementById("errReg").innerHTML = "Fields must be filled.";
                        return false;
                    }else
                        return true;
                }
                function logout(){
                    localStorage.setItem("loginstatus","0");
                    localStorage.setItem("bookmsgstatus","0");
                    window.location = "index.html";
                }
                function funBook(bookid){
                    var id = document.getElementById("spanid"+bookid).innerHTML;
                    document.getElementById("bkid").value = id.trim();
                    document.forms[0].submit();
                }
                function funStd(stdid){
                    var id = document.getElementById("userstd"+stdid).innerHTML;
                    document.getElementById("stdid").value = id.trim();
                    document.forms[1].submit();
                }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./styles/style_admin.css">
        <title>Welcome Admin</title>
    </head>
    <body>
        <form style="visibility:hidden" id="myform" action="showbookdetails.jsp" method="post">
                    <input type="text" id="bkid" name ="bookid" >
                </form>
        <form style="visibility:hidden" id="myform1" action="showstudents.jsp" method="post">
                    <input type="text" id="stdid" name ="stdid" >
                </form>
        <%
                try{
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    con = DriverManager.getConnection("jdbc:odbc:lib");
                }catch(Exception e){
                    out.println(e);
                }
        %>
       <div id="head">Admin Panel</div>
       <div class="adtabs" id="adbk" onclick="addbook()"><div id="adtxt1">Add Book</div></div>
       <div class="adtabs" id="shbk" onclick="showbook()"><div id="adtxt2">View Books</div></div>
       <div class="adtabs" id="std" onclick="showstud()"><div id="adtxt3">View Students</div></div>
       <div id="foradbk">
           <h1>Add Book to Library</h1>
           <form name="bookform" id="bkfrm" onsubmit="return checkfrm()" action="addbook.jsp">
               <input type="text" name="bid" placeholder="Enter Book ID"><br>
               <input type="text" name="bname" placeholder="Enter Book name"><br>
               <input type="text" name="auth" placeholder="Enter Author"><br>
               <input type="text" name="cat" placeholder="Enter Category"><br>
               <input type="text" name="qnty" placeholder="Enter Book quantity"><br>
               <div id="errReg" style="font-size: 15px;"></div>
               <input type="submit" value="Add Book">
           </form>
       </div>
       <div id="forshbk"><%
                ps = con.prepareStatement("select * from book_details");
                rs = ps.executeQuery();
                %><script>var c = 1;</script><%
                while(rs.next()){
                    %>
                    <script> 
                        document.write("<div id = 'bkid" + c +"' class='bklst2' onclick='funBook("+ c +")'>");</script>
                        <div id="bname"><%=rs.getString(2)%></div>
                        <div id="auth"><%=rs.getString(3)%></div>
                        <div id="bdate">Book ID:
                            <script>document.write("<span id ='spanid"+ c++ +"' style='color:red'>");</script>
                            <%=rs.getString(1)%></span>
                        </div>
                        <div id="sdate">Category: <span style="color:red"><%=rs.getString(4)%></span></div>
                        <div id="qty">Quantity: <span style="color:red"><%=rs.getString(5)%></span></div>
                      </div>
                    <%
                }
       %></div>
       <div id="forstd"><%
            ps = con.prepareStatement("select * from master_login");
                rs = ps.executeQuery();
                %><script>var c = 1;</script><%
                while(rs.next()){
                    %>
                    <script>document.write("<div class='bklst' onclick='funStd("+ c +")'>");</script>
                        <div id="bname"><%=rs.getString(1)%></div>
                        <div id="auth">Department: <%=rs.getString(2)%></div>
                        <div id="auth" style="font-size: 20px;">Batch: <span style="color:red"><%=rs.getString(3)%></span></div>
                        <div id="auth" style="font-size: 20px;">University Roll: <span style="color:green"><%=rs.getString(4)%></span></div>
                        <div id="auth" style="font-size: 20px;">College ID: <span style="color:green"><%=rs.getString(5)%></span></div>
                        <script>document.write("<div id='userstd"+ c++ +"' style='visibility:hidden;position:absolute' >");</script>
                        <%=rs.getString(6)%></div>
                    </div>
                    <%
                }
       %></div>
        <div id="searchbox">
            <form action="showbookdetails.jsp" style="position:relative" method="get">
                <input type="text" placeholder="Search Book By ID.." name="bookid"><br>
                <input type="submit" value="search">
            </form>
        </div>
        <div id="searchbox2">
            <form action="showstudents.jsp" style="position:relative" method="get">
                <input type="text" placeholder="Search Student By username.." name="stdid"><br>
                <input type="submit" value="search">
            </form>
        </div>
       <div id="logout" onclick="logout()">Logout</div>
       <div id="foot">Developed by Pankaj Kumar</div>
    </body>
</html>
