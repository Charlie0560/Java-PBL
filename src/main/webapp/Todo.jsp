<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%><%
String id = request.getParameter("userid");
String driver = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "todos";
String userid = "root";
String password = "Charlie@0569";
int preference = 0;
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
 <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
  <link href="./index.css" rel="stylesheet">
  </head>
<html>
<body>
<center>
<h1 style="margin-top:80px; margin-bottom: 20px">Add Todo</h1></center>
<form action="ConnectionServlet" name="abcd" method="post" >

	<div style="display: flex;justify-content: center; column-gap: 20px;">

	<p>Preference: <input type=number name="preference" placeholder="Enter preference:"></p>

	<p>Description: <input type=text name="desc" placeholder="Enter Description:"></p>

	<p>Target Date:  <input type=date name="date" ></p>

</div>

<br>
<center><button type=submit style="margin-bottom: 20px; padding: 8px; margin-top: -10px"  class="btn btn-light">Submit</button></center>

</form>
<hr>

<center>
<h2>Todo List</h2>
<table class="table table-bordered" style="width: 70%; color: white;">
<tr>
<td>Preference </td>
<td>Description</td>
<td>Target Date</td>
<td>Actions</td>

</tr>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from todo order by preference";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("preference") %></td>
<td><%=resultSet.getString("description") %></td>
<td><%=resultSet.getString("tdate") %></td>
<td><a href="EditTodo.jsp?preference=<%=resultSet.getString("preference") %>"><button >Edit</button></a>  <a href="DeleteServlet?preference=<%=resultSet.getString("preference") %>"><button>Delete</button></a> </td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table> 
</center>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

</body>
</html>