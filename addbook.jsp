<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
    <head>
    </head>
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
                String bookid = request.getParameter("bid");
                String bookname = request.getParameter("bname");
                String author = request.getParameter("auth");
                String category = request.getParameter("cat");
                int quantity = Integer.parseInt(request.getParameter("qnty"));
                try{
                    ps = con.prepareStatement("select qnty,bookname from book_details where bookid = ?");
                    ps.setString(1,bookid);
                    rs = ps.executeQuery();
                }catch(Exception e){
                    out.println(e);
                }
                if(rs.next()){
                    String name = rs.getString(2);
                    int qty = rs.getInt(1);
                    if(bookname.equalsIgnoreCase(name)){
                        quantity += qty;
                        ps = con.prepareStatement("update book_details set qnty = ? where bookid = ?");
                        ps.setInt(1,quantity);
                        ps.setString(2,bookid);
                        ps.execute();
                        %><script>
                            alert("Book updated");
                            window.location = "adminportal.jsp";
                        </script><%
                    }
                }else{
                    ps = con.prepareStatement("insert into book_details values (?,?,?,?,? )");
                    ps.setString(1,bookid);
                    ps.setString(2,bookname);
                    ps.setString(3,author);
                    ps.setString(4,category);
                    ps.setInt(5,quantity);
                    ps.execute();
                    %><script>
                            alert("New book Added");
                            window.location = "adminportal.jsp";
                    </script><%
                }
                
                con.close();
        %>
    </body>
</html>
