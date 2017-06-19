<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <body>
        <form style="visibility:hidden" id="myform1" action="showstudents.jsp" method="post">
                    <input type="text" id="stdid" name ="stdid" >
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
                String username = request.getParameter("username2");
                String bookid = request.getParameter("bid2");
                ps = con.prepareStatement("select * from master_book where username = ? and bookid = ?");
                ps.setString(1,username);
                ps.setString(2,bookid);
                rs = ps.executeQuery();
                if(rs.next()){
                    ps = con.prepareStatement("select qnty from book_details where bookid =?");
                    ps.setString(1,bookid);
                    rs = ps.executeQuery();
                    if(rs.next()){
                        int quantity = Integer.parseInt(rs.getString(1));
                        ps = con.prepareStatement("update book_details set qnty = ? where bookid =?");
                        String qty = "" + (quantity + 1);
                        ps.setString(1,qty);
                        ps.setString(2,bookid);
                        ps.execute();
                        ps = con.prepareStatement("delete from master_book where username = ? and bookid = ?");
                        ps.setString(1,username);
                        ps.setString(2,bookid);
                        ps.execute();
                        %><script>alert("Book Submitted");
                        document.getElementById("stdid").value = "<%=username%>";
                        document.forms[0].submit();
                        </script>
                    <%           
                    }
                }else{
                    %><script>alert("Book is not Issued");
                     document.getElementById("stdid").value = "<%=username%>";
                    document.forms[0].submit();
                    </script><%
                }
                con.close();
        %>
    </body>
</html>
