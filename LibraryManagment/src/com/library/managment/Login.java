package com.library.managment;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/callLogin")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Connection myCon = null;
	private static PreparedStatement myStmt = null;
	private static ResultSet resultSet = null;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String usertype = req.getParameter("user_type");
		int role = 0;
		
		if(usertype.equalsIgnoreCase("admin")) {
			role = 1;
		}else {
			role = 2;
		}
				
		resp.setContentType("text/html");
		
		PrintWriter writer = resp.getWriter();
		
		try {
			boolean status = checkUserType(username,password,role);	
			if(status && role == 1) {
				resp.sendRedirect("AddBook.html");
			}else if(status && role == 2) {
				resp.sendRedirect("ViewBook.html");
			}else {
				resp.sendRedirect("index.html");
				writer.println("Wrong Username or Password");
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
	}
	
	protected boolean checkUserType(String username,String password,int role) throws ClassNotFoundException{
		ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
        String url = bundle.getString("url");
        String user = bundle.getString("user");
        String passwd = bundle.getString("passwd");
        boolean status = false;
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        	
       	 myCon = DriverManager.getConnection(url,user,passwd);
       	 System.out.println("Connection Established");
       	 
       	 String sql = "select *  from `users` where `username`=? && `role_id`=?";
       	       	 
      	 myStmt = myCon.prepareStatement(sql);
      	 myStmt.setString(1,username);
      	 myStmt.setInt(2,role);
      	 
         resultSet = myStmt.executeQuery();
         
         if(!resultSet.next()) {
             status = false; 
          }else {
    	     status = true;
          }
       	        	 
        }catch(SQLException e) {
       	 e.printStackTrace();
        }finally {
	       	 try {	
	       		 close();
	       	 }catch(SQLException e) {
	       		 e.printStackTrace();
	       	 }
        }
        return status;
	}
	
	private static void close() throws SQLException {
		
		if(myStmt!=null) {
			myStmt.close();
		}
		
		if(myCon!=null) {
			myCon.close();
		}
		
	}
	
	

}
