package usersWeb;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String username = req.getParameterValues("users")[0];
		String password = req.getParameter("password");
		boolean result = Dao.resetPassword(username, password);
		if (result) 
			res.sendRedirect("main.jsp?username=" + req.getSession().getAttribute("username"));
		else
			res.sendRedirect("login2.html");
	}
	
}
