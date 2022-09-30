package com.example.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class BeerSelect extends HttpServlet {
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
			throws IOException, ServletException {

	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("Beer Selection Advice<br>");
	String c = request.getParameter("color"); 
		// ServletRequest인터페이스 메소드로 
		// 인자가 HTML<select> 항목에 있는 name값과 일치해야함
	out.println("<br>Got beer color "+c);
	}
}




