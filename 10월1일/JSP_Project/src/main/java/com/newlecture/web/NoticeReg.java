package com.newlecture.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/notice-reg") // 어노테이션 사용(Annotation)
// web.xml을 사용 시 분업화를 할 수 없음
public class NoticeReg extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setCharacterEncoding("UTF-8");
		// 응답값 인코딩 변경 : ?? -> 댋뀞
		res.setContentType("text/html; charset=UTF-8");
		// 전송된 문서가 html문서이면서 UTF-8인 것을 알려줌
		//req.setCharacterEncoding("UTF-8");
		// 요청값 인코딩 변경

		PrintWriter out = res.getWriter();
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		out.println(title);	 
		out.println("<br>");	 
		out.println(content);	 
		
		
		
	}
	
}
