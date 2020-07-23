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
import javax.servlet.http.HttpSession;

@WebServlet("/LoginUser")
public class LoginUser extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static Connection myCon = null;
	private static PreparedStatement myStmt = null;
	private static ResultSet resultSet = null;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
       
		PrintWriter writer = response.getWriter();
		
		try {
			int roleid = checkUserType(username);	
			if(roleid == 1) {
				response.sendRedirect("ListBook.jsp");
			}else if(roleid == 2) {
				response.sendRedirect("displayBook.jsp");
			}else {
				response.sendRedirect("index.html");
				writer.println("Wrong Username or Password");
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	protected int checkUserType(String username) throws ClassNotFoundException{
		ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
        String url = bundle.getString("url");
        String user = bundle.getString("user");
        String passwd = bundle.getString("passwd");
        int roleid = 0;
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        	
       	 myCon = DriverManager.getConnection(url,user,passwd);
       	 
       	 String sql = "select *  from `users` where `username`=?";
       	       	 
      	 myStmt = myCon.prepareStatement(sql);
      	 myStmt.setString(1,username);
      	 
         resultSet = myStmt.executeQuery();
         
         if(!resultSet.next()) {
             roleid = 0;
          }else {
    	     roleid = Integer.parseInt(resultSet.getString("role_id"));
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
        return roleid;
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
