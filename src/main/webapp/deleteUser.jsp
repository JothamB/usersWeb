<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Expires", "0");
	if (session.getAttribute("username") == null)
		response.sendRedirect("login.html");
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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
			<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://db:3306/usersProject" user="user" password="1234" />
			<sql:query var="rs" dataSource="${db}">SELECT username FROM users</sql:query>
			<form action="deleteUser" method="post" id="deleteUserForm" onsubmit="return validateUser();">
				<div>
					<label>choose user to delete</label> 
				</div><br>
				<div>
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
				</div><br><br>
				<button type="submit">delete user</button>
			</form>
		</div>
		<script>
			function validateUser() {
				var users = document.getElementById("users");
				if (users.value == "")
					return false;
			}
		</script>
	</body>
</html>