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
      label {
      	display: inline-block;
      	 width: 200px;
      }
      select {
     	width: 200px;
      }
    </style>
    <body>
    	<br><br><br>
		<div align="center">
			<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://db:3306/usersProject" user="user" password="1234" />
			<sql:query var="rs" dataSource="${db}">SELECT username FROM users</sql:query>
			<form action="resetPassword" method="post" id="resetPasswordForm" onsubmit="return validateForm();">
				<div>
					<label for="username">username</label> 
					<select name="users" id="users">
						<option value=""></option>
						<c:forEach items="${rs.rows}" var="row">
							<c:choose>
								<c:when test="${row.username eq 'admin'}">
								</c:when>
								<c:otherwise>
									<option value="${row.username}">${row.username}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div><br>
				<div>
					<label for="password">new password</label> 
					<input name="password" type="password" id="password" required>
				</div><br>
				<div>
					<label for="retypePassword">retype new password</label> 
					<input name="retypePassword" type="password" id="retypePassword" required>
				</div><br><br>
				<button type="submit">reset password</button>
			</form>
		</div>
		<script>
			function validateForm() {
				var users = document.getElementById("users");
				var password = document.getElementById("password");
				var retypePassword = document.getElementById("retypePassword");
				if (users.value == "")
					return false;
				if (password.value == retypePassword.value)
					return true
				else {
					alert("passwords dont match !");
					password.value = "";
					retypePassword.value = "";
					return false;
				}
			}
		</script>
	</body>
</html>