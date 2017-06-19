<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <body>
        <form style="visibility:hidden" id="myform" action="profile.jsp" method="post">
                    <input type="text" id="user" name ="username" >
                </form>
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
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                if(username.equals("admin") && password.equals("admin")){
                            %><script>
                                localStorage.setItem("loginstatus","1");
                                localStorage.setItem("user","<%=username%>");
                                localStorage.setItem("messagestatus","0");
                                window.location = "adminportal.jsp";
                            </script><%
                        }
                ps = con.prepareStatement("select password from master_login where username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                if(rs.next()){
                    String pass = rs.getString(1);
                    if(password.equals(pass)){
                        %><script>                     
                                localStorage.setItem("loginstatus","1");
                                localStorage.setItem("user","<%=username%>");
                                localStorage.setItem("messagestatus","0");
                                document.getElementById('user').value = "<%=username%>";
                                document.forms[0].submit();
                        </script><%
                        
                    }else{
                        %><script>                       
                            localStorage.setItem("messagestatus","1");
                            localStorage.setItem("message","Password does not match"); 
                            window.location = "index.html";
                        </script><%
                    }
                }else{
                    %><script>            
                            localStorage.setItem("messagestatus","1");
                            localStorage.setItem("message","Username does not exist");
                            window.location = "index.html";
                    </script><%
                }
                %>
                
    </body>
</html>
