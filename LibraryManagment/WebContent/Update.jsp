<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
    
<%!
    private static Connection myCon = null;
	private static PreparedStatement myStmt = null;
	private static ResultSet resultSet = null;

%>
<%
String id = request.getParameter("id");
String bookname = request.getParameter("bookname");
String authorname = request.getParameter("authorname");
String isbn = request.getParameter("isbn");
String desc = request.getParameter("desc");
String serial = request.getParameter("serial");
String publisher = request.getParameter("publisher");
String year = request.getParameter("year");
String pages = request.getParameter("pages");
String price = request.getParameter("price");
try{
	ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
	String url = bundle.getString("url");
	String user = bundle.getString("user");
	String passwd = bundle.getString("passwd");

	Class.forName("com.mysql.cj.jdbc.Driver");

	myCon = DriverManager.getConnection(url,user,passwd);
	String sql = "Update book set book_name=?,author_name=?,ISBN=?,book_desc=?,serialNo=?,publisher=?,year=?,no_of_pages=?,price=? where id="+id;
	 myStmt = myCon.prepareStatement(sql);
	 myStmt.setString(1,bookname);
  	 myStmt.setString(2,authorname);
  	 myStmt.setString(3,isbn);
  	 myStmt.setString(4,desc);
  	 myStmt.setString(5,serial);
  	 myStmt.setString(6,publisher);
  	 myStmt.setString(7,year);
  	 myStmt.setString(8,pages);
  	 myStmt.setString(9,price);
     
   	 myStmt.executeUpdate();  
   	response.sendRedirect("ListBook.jsp");
}	
   	catch(ClassNotFoundException |SQLException e){
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
