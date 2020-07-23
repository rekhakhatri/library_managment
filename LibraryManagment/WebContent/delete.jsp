<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%!
    private static Connection myCon = null;
	private static Statement myStmt = null;
%>
<%
String id = request.getParameter("id");
try{
	ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
	String url = bundle.getString("url");
	String user = bundle.getString("user");
	String passwd = bundle.getString("passwd");

	Class.forName("com.mysql.cj.jdbc.Driver");

	myCon = DriverManager.getConnection(url,user,passwd);
	myStmt = myCon.createStatement();
	myStmt.executeUpdate("delete from book where id="+id);
	response.sendRedirect("ListBook.jsp");
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