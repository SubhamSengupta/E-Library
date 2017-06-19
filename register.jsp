<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    
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
                String name = request.getParameter("name");
                String dept= request.getParameter("dept");
                String passyear = request.getParameter("passyear");
                String univ = request.getParameter("univ");
                String id = request.getParameter("id");
                String username = request.getParameter("usr");
                String password = request.getParameter("pass");
                ps = con.prepareStatement("select naam from master_login where username = ?");
                ps.setString(1,username);
                rs = ps.executeQuery();
                if(rs.next()){
                    %><script>
                        localStorage.setItem("regstatus","1");
                        localStorage.setItem("regmessage","username is already taken");
                        window.location = "index.html";
                     </script><%
                }else{
                    ps = con.prepareStatement("insert into master_login values (?,?,?,?,?,?,?)");
                    ps.setString(1,name);
                    ps.setString(2,dept);
                    ps.setString(3,passyear);
                    ps.setString(4,univ);
                    ps.setString(5,id);
                    ps.setString(6,username);
                    ps.setString(7,password);
                    ps.execute();
                    %><script>
                        localStorage.setItem("regstatus","1");
                        localStorage.setItem("regmessage","User is successfully registered.");
                        window.location = "index.html"; 
                    </script><%
                }
                con.close();
        %>
    </body>
</html>
