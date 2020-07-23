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
try{
	ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
	String url = bundle.getString("url");
	String user = bundle.getString("user");
	String passwd = bundle.getString("passwd");

	Class.forName("com.mysql.cj.jdbc.Driver");
	String username = (String)request.getSession().getAttribute("username");

	myCon = DriverManager.getConnection(url,user,passwd);
	myStmt = myCon.createStatement();
	resultSet = myStmt.executeQuery("select * from book where id="+id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index Page</title>
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
                    <a href="ListBook.jsp" class="list-group-item"><i class="fa fa-book" aria-hidden="true"></i> Books</a>
                    <a href="" class="list-group-item"><i class="fa fa-user" aria-hidden="true"></i> Users</a>
                    <a href="logout.jsp" class="list-group-item"><i class="fa fa-sign-out" aria-hidden="true"></i> Log out</a>
                </ul>
            </div>
            <div class="col-md-8 details">
                <p class="text-info" style="font-size: 20px;">
                    Books
                    <small class="pull-right">
                        <a href="ListBook.jsp" class="btn btn-outline-info" type="button">BACK</a>
                    </small>
                </p>
              
                <p>
                <%
               			 while(resultSet.next()){
                %>
                  <form action="Update.jsp">
				 <div class="row">
				    <div class="col-md-6">
				          <div class="form-group">
						    <label for="bookname">Book Name:</label>
						    <input type="hidden" name="id" value="<%=resultSet.getString("id") %>">
						    <input type="text" class="form-control" name="bookname" value="<%=resultSet.getString("book_name") %>">
						  </div>
						  <div class="form-group">
						    <label for="authorname">Author Name :</label>
						    <input type="text" class="form-control" name="authorname" value="<%=resultSet.getString("author_name") %>">
						  </div>
						  <div class="form-group">
						    <label for="isbn">ISBN Number :</label>
						    <input type="text" class="form-control" name="isbn" value="<%=resultSet.getString("ISBN") %>">
						  </div>
						  <div class="form-group">
						    <label for="desc">Book Description :</label>
						    <input type="text" class="form-control" name="desc" value="<%=resultSet.getString("book_desc") %>">
						  </div>
						  <div class="form-group">
						    <label for="serial">Serial Number :</label>
						    <input type="text" class="form-control" name="serial" value="<%=resultSet.getString("serialNo") %>">
						  </div>
						
				    </div>
				    <div class="col-md-6">
				           <div class="form-group">
						    <label for="publisher">Publisher :</label>
						    <input type="text" class="form-control" name="publisher" value="<%=resultSet.getString("publisher") %>">
						  </div>
						   <div class="form-group">
						    <label for="year">Year :</label>
						    <input type="text" class="form-control" name="year" value="<%=resultSet.getString("year") %>">
						  </div>
						   <div class="form-group">
						    <label for="pages">Total Pages :</label>
						    <input type="text" class="form-control" name="pages" value="<%=resultSet.getString("no_of_pages") %>">
						  </div>
						    <div class="form-group">
						    <label for="price">Price :</label>
						    <input type="text" class="form-control" name="price" value="<%=resultSet.getString("price") %>">
						  </div>
				    </div>
				 </div>
				  <button type="submit" class="btn text-center btn-info">Update</button>
			   </form>
			   
			   <%
               			 }
				}catch(ClassNotFoundException |SQLException e){
					e.printStackTrace();
				}finally{
					 try {	
				   		 close();
				   	 }catch(SQLException e) {
				   		 e.printStackTrace();
				   	 }
				}
				%>   
				 
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
                </p>
            </div>
        </div>
    </div>
</body>
</html>