package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** Servlet implementation class LoginServlet */
@WebServlet("/Login")
public class Login extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /** @see HttpServlet#HttpServlet() */
    public Login() { super(); }

	/** @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		session.setAttribute("id", id);
		session.setAttribute("pw", pw);
		
		// 관리자 계정으로 로그인
		if(id.equals("12345") && pw.equals("12345"))
		{
			String admin = "admin.jsp";
			request.getRequestDispatcher(admin).forward(request, response);
		}
		// 일반 계정으로 로그인
		else
		{
			String login = "profile.jsp?user_id=" + id;
			request.getRequestDispatcher(login).forward(request, response);
		}
	}

	/** @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response) */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}