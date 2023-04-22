package usersWeb;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String result = Dao.authenticate(username, password);
		if (result.equals("ok"))
			res.sendRedirect("main.jsp?username=" + username);
		else if (result.equals(""))
			res.sendRedirect("login1.html");
		else if (result.equals("error"))
			res.sendRedirect("login2.html");
	}

}