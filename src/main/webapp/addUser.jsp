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

<html>
	<style>
      label {
      	display: inline-block;
      	 width: 200px;
      }
    </style>
    <body>
    	<br><br><br>
		<div align="center">
			<form action="addUser" method="post" id="addUserForm" onsubmit="return validatePassword();">
				<div>
					<label for="username">username</label> 
					<input name="username" type="text" id="username" required>
				</div><br>
				<div>
					<label for="password">password</label> 
					<input name="password" type="password" id="password" required>
				</div><br>
				<div>
					<label for="retypePassword">retype password</label> 
					<input name="retypePassword" type="password" id="retypePassword" required>
				</div><br><br>
				<button type="submit">add user</button>
			</form>
		</div>
		<script>
			function validatePassword() {
				var password = document.getElementById("password");
				var retypePassword = document.getElementById("retypePassword");
				if (password.value == retypePassword.value) {
					return true
				}
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