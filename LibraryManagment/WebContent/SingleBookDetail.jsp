<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%!
    private static Connection myCon = null;
	private static Statement myStmt = null;
	private static ResultSet resultSet = null;
%>
<%
String id = request.getParameter("id");
String username = (String)request.getSession().getAttribute("username");
ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
String url = bundle.getString("url");
String user = bundle.getString("user");
String passwd = bundle.getString("passwd");

Class.forName("com.mysql.cj.jdbc.Driver");

myCon = DriverManager.getConnection(url,user,passwd);
myStmt = myCon.createStatement();
resultSet = myStmt.executeQuery("select * from book where id="+id);
%>
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
    <div class="container-fluid cart-header">
        <p class="text-center">- Welcome <%= username %>-</p>
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
                    <a href="" class="list-group-item"><i class="fa fa-user" aria-hidden="true"></i> Account</a>
                    <a href="" class="list-group-item"><i class="fa fa-sign-out" aria-hidden="true"></i> Log out</a>
                </ul>
            </div>
            <div class="col-md-8 details">
                       <%
                        	while(resultSet.next()) {
                        %>
                  <p class="text-info" style="font-size: 20px;">
                    <%= resultSet.getString(2) %>
                   
                    <small class="pull-right">
                        <a href="ListBook.jsp" class="btn btn-outline-info" type="button">BACK</a>
                    </small>
                </p>
              
                <p>
                    <table class="table table-hover">
                        <thead>
                        </thead>
                        <tbody>
                           <tr>
                            <td><b>Author Name : </b><%= resultSet.getString(3) %></td>
                            <td><b>Publisher : </b><%= resultSet.getString(7) %></td>
                           </tr> 
                      
                           <tr>
                            <td><b>Year : </b><%= resultSet.getString(8) %></td>
                            <td><b>ISBN Number : </b><%= resultSet.getString(4) %></td>
                           </tr>
                           
                            <tr>
                                <td><b>Price : </b><%= resultSet.getString(10) %></td>
                                <td><b>Serial Number : </b><%= resultSet.getString(6) %></td>
                            </tr>
                            
                           <tr>
                            <td><b>Total Pages : </b><%= resultSet.getString(9) %></td>
                            <td></td>
                           </tr>
                           <tr>
                            <td colspan=2><b>Description : </b><%= resultSet.getString(5) %></td>
                           </tr>
                        <% 	
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