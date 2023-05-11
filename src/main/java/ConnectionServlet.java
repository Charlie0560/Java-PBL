

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ConnectionServlet
 */
@WebServlet("/ConnectionServlet")
public class ConnectionServlet extends HttpServlet {
	
	Connection con;
    
    
    void getconnection()
    {
	    String driver="com.mysql.cj.jdbc.Driver";
	    String url="jdbc:mysql://localhost:3306/todos";
	    String username="root"; 
	    String password="Charlie@0569"; 
	    try 
	    {
	    Class.forName(driver);
	    con=DriverManager.getConnection(url,username,password);
	    System.out.println("Connection established successfully");
	    }
	    catch(Exception E)
	    {
	    System.out.println(E);
	    }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		getconnection();
		int preference = Integer.parseInt(request.getParameter("preference"));
		String description = request.getParameter("desc");
		String tdate = request.getParameter("date");
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		try {
			
			PreparedStatement ps = con.prepareStatement("insert into todo(preference,description,tdate) values(?,?,?)");
			ps.setInt(1, preference);
			ps.setString(2, description);
			ps.setString(3, tdate);
			System.out.println(ps);
			int rs = ps.executeUpdate();
			if(rs==1) {
				RequestDispatcher rd = request.getRequestDispatcher("Todo.jsp");
				rd.forward(request, response);
			}else {
				out.println("<font color=red size=18>Wrong!</font>");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void addtodo() {
	
	}

}
