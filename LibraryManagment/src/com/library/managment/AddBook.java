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

@WebServlet("/AddBook")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Connection myCon = null;
	private static PreparedStatement myStmt = null;
	private static ResultSet resultSet = null;

	
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookname = req.getParameter("bookname");
		String authorname = req.getParameter("authorname");
		String isbn = req.getParameter("isbn");
		String desc = req.getParameter("desc");
		String serial = req.getParameter("serial");
		String publisher = req.getParameter("publisher");
		String year = req.getParameter("year");
		String pages = req.getParameter("pages");
		String price = req.getParameter("price");
		
	
		resp.setContentType("text/html");
		
		PrintWriter writer = resp.getWriter();
		
		try {
			addBook(bookname,authorname,isbn,desc,serial,publisher,year,pages,price);
			resp.sendRedirect("ListBook.jsp");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	protected void addBook(String bookname,String authorname,String isbn,String desc,String serial,String publisher,String year,String pages,String price) throws ClassNotFoundException{
		ResourceBundle bundle = ResourceBundle.getBundle("com.java.utilities.mysqlinfo");
        String url = bundle.getString("url");
        String user = bundle.getString("user");
        String passwd = bundle.getString("passwd");
        boolean status = false;
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        	
       	 myCon = DriverManager.getConnection(url,user,passwd);
       	 
       	 String sql = "insert into `book` (`book_name`,`author_name`,`ISBN`,`book_desc`,`serialNo`,`publisher`,`year`,`no_of_pages`,`price`) values (?,?,?,?,?,?,?,?,?)";
       	       	 
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
	
	private static void close() throws SQLException {
		
		if(myStmt!=null) {
			myStmt.close();
		}
		
		if(myCon!=null) {
			myCon.close();
		}
		
	}

}
