package com.newlecture.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hi") // 어노테이션 사용(Annotation)
// web.xml을 사용 시 분업화를 할 수 없음
public class Nana extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setCharacterEncoding("UTF-8");
		// 정상적인 바이트 단위로 전송 : ?? -> 댋뀞
		res.setContentType("text/html; charset=UTF-8");
		// 전송된 문서가 html문서이면서 UTF-8인 것을 알려줌

		PrintWriter out = res.getWriter();
		
		String temp = req.getParameter("cnt");
		int cnt = 10;
		if(temp!=null && !temp.equals("")) // 값이 있는지 확인
			cnt = Integer.parseInt(temp);
		// 요청/응답은 무조건 문자열 => Integer로 형변환
		
		for(int i=0;i<cnt;i++) 
			out.println((i+1)+" : 안녕 Servlet!!<br>");
			
			 
		
		
	}
	
}
