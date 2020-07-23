package com.library.managment;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewBook")
public class ViewBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Connection myCon = null;
	private static Statement myStmt = null;
	private static ResultSet resultSet = null;
	private static PrintWriter writer = null;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 
		writer = resp.getWriter();
		
		try {
			viewBook();
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	
	protected void viewBook() throws ClassNotFoundException{
		ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
        String url = bundle.getString("url");
        String user = bundle.getString("user");
        String passwd = bundle.getString("passwd");
        boolean status = false;
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        	
       	 myCon = DriverManager.getConnection(url,user,passwd);
       	 System.out.println("Connection Established");
       	 
       	 String sql = "select * from `book`";
       	       	 
      	 myStmt = myCon.createStatement();
      	resultSet = myStmt.executeQuery("select * from book");
		 display(resultSet);
      
       	        	 
        }catch(SQLException e) {
       	 e.printStackTrace();
        }finally {
	       	 try {	
	       		 close();
	       	 }catch(SQLException e) {
	       		 e.printStackTrace();
	       	 }
        }
	}
	
	static void display(ResultSet result) throws SQLException {
		
		while(result.next()) {
	
			String book_name = result.getString(2);
			String author_name = result.getString(3);
			String ISBN = result.getString(4);
			String book_desc = result.getString(5);
			String serialNo = result.getString(6);
			String publisher = result.getString(7);
			String year = result.getString(8);
			String no_of_pages = result.getString(9);
			String price = result.getString(10);
			
			writer.println(String.format("%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s ","Book Name","Author Name","ISBN","Book Description","Serial No.","Publisher","Year","No_of_pages","Price" ));	
			
			writer.println();
			writer.println();
			writer.println();
			writer.println(String.format("%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s ",book_name,author_name,ISBN,book_desc,serialNo,publisher,year,no_of_pages,price ));
		}
		
		
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
