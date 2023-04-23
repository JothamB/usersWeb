<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Expires", "0");
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.html");
	else {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://db:3306/usersProject", "user", "1234");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM users");
		boolean userExists = false;
		while (rs.next()) {
			if (session.getAttribute("username").equals(rs.getString("username")))
				userExists = true;
		}
		if (!userExists) {
			session.removeAttribute("username");
			session.invalidate();
			response.sendRedirect("login.html");
		}
	}
		
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
	<style>
		a {
			margin-right: 50px;
		}
	</style>
	<body>
		<br><br><br>
		<div align="center">
			<a href="addUser.jsp">add user</a>
			<a href="deleteUser.jsp">delete user</a>
			<a href="resetPassword.jsp">reset password</a>
			<a href="logout">logout</a>
		</div><br><br><br>
		<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://db:3306/usersProject" user="user" password="1234" />
		<sql:query var="rs" dataSource="${db}">SELECT username FROM users</sql:query>
		<div align="center">
			<c:forEach items="${rs.rows}" var="row">
				<c:out value="${row.username}"></c:out><br><br>
			</c:forEach><br>
			logged in as <c:out value="${param.username}" />
		</div>
	</body>
</html>