<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.IOException" %>    
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="java.sql.Connection" %>    
<%@ page import="java.sql.DriverManager" %>    
<%@ page import="java.sql.Statement" %>    
<%@ page import="java.sql.ResultSet" %>    
<%@ page import="java.sql.SQLException" %>    
<%@ page import="java.util.ResourceBundle" %>    
<%@ page import="javax.servlet.ServletException" %>    
<%@ page import="javax.servlet.annotation.WebServlet" %>    
<%@ page import="javax.servlet.http.HttpServlet" %>    
<%@ page import="javax.servlet.http.HttpServletRequest" %>    
<%@ page import="javax.servlet.http.HttpServletResponse" %>    

 
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Books</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
   <%!
    private static Connection myCon = null;
	private static Statement myStmt = null;
	private static ResultSet resultSet = null;

   %>
   	<%
	String username = (String)request.getSession().getAttribute("username");
	%>
   
    <div class="container-fluid cart-header">
        <p class="text-center">- Welcome <%= username %> -</p>
    </div>
    <div class="contianer page">
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-2 menu mr-2">
                <ul class="list-group list-group-flush text-left">
                    <a href="" class="list-group-item">
                        <img src="https://www.imindq.com/Portals/0/EasyDNNnews/273/img-book-mind-mapping.jpg" alt="" style="border-radius:50%;height:120px;width:120px;">
                    </a>
                     <a href="" class="list-group-item"><i class="fa fa-book" aria-hidden="true"></i> Books</a>
                    <a href="" class="list-group-item"><i class="fa fa-user" aria-hidden="true"></i> Users</a>
                    <a href="logout.jsp" class="list-group-item"><i class="fa fa-sign-out" aria-hidden="true"></i> Log out</a>
                </ul>
            </div>
            <div class="col-md-8 details">
                <p class="text-info" style="font-size: 20px;">
                    Books
                   
                    <small class="pull-right">
                        <a href="AddBook.html" class="btn btn-outline-info" type="button">ADD</a>
                    </small>
                </p>
              
                <p>
<%
		
		try {
			ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
	        String url = bundle.getString("url");
	        String user = bundle.getString("user");
	        String passwd = bundle.getString("passwd");
	        try {
	        	
	        Class.forName("com.mysql.jdbc.Driver");
	        	
	       	 myCon = DriverManager.getConnection(url,user,passwd);
	       	 
	       	 String sql = "select * from `book`";
	       	       	 
	      	 myStmt = myCon.createStatement();
	      	 resultSet = myStmt.executeQuery("select * from book");
%>	      	 
                    <table class="table table-hover">
                        <thead>
                          <tr>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Publisher</th>
                            <th colspan="2">Actions</th>
                          </tr>
                        </thead>
                        <tbody>
                         
                   <%
                       	while(resultSet.next()) {
                       		
                			String book_name = resultSet.getString(2);
                			String author_name = resultSet.getString(3);
                			String publisher = resultSet.getString(7);
                   %>
                          <tr>
                            <td><%= book_name %></td>
                            <td><%= author_name%></td>
                            <td><%= publisher %></td>
                             <td>
                                <a href="SingleBookDetail.jsp?id=<%= resultSet.getString("id")%>" class="btn btn-success btn-sm">View</a>
                                <a href="EditBook.jsp?id=<%= resultSet.getString("id")%>" class="btn btn-info btn-sm">Edit</a>
                                <a href="delete.jsp?id=<%= resultSet.getString("id")%>" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                           </tr>  
                   <% 
                		}   
                   %>
                           
                          
<%
	       	        	 
	        }catch(SQLException e) {
	       	 e.printStackTrace();
	        }finally {
		       	 try {	
		       		 close();
		       	 }catch(SQLException e) {
		       		 e.printStackTrace();
		       	 }
	        }
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
%>                          
                        </tbody>
                      </table>
                </p>
            </div>
        </div>
    </div>
     <%! 
			    private static void close() throws SQLException {
				
				if(myStmt!=null) {
					myStmt.close();
				}
				
				if(myCon!=null) {
					myCon.close();
				}
				
		}
    %>
</body>
</html>