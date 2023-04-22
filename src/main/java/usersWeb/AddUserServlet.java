package usersWeb;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String result = Dao.addUser(username, password);
		if (result.equals("ok")) 
			res.sendRedirect("main.jsp?username=" + req.getSession().getAttribute("username"));
		else if (result.equals("userExists")) {
			res.getWriter().println("<script>");
			res.getWriter().println("alert('user already exists !')");
			res.getWriter().println("window.location.href = '" + "main.jsp?username=" + req.getSession().getAttribute("username") + "';");
			res.getWriter().println("</script>");
		}
		else if (result.equals("error"))
			res.sendRedirect("login2.html");
	}
	
}
