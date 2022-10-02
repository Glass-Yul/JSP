package com.newlecture.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/calc2") // 어노테이션 사용(Annotation)
// web.xml을 사용 시 분업화를 할 수 없음
public class Calc2 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		ServletContext application = req.getServletContext();
		// 데이터 저장을 위함
		HttpSession session = req.getSession();
		// 세션 객체 얻음
		Cookie[] cookies = req.getCookies();
		// 쿠키 데이터 받기
		
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");

		PrintWriter out = res.getWriter();
		
		String v_ = req.getParameter("v");
		// (String형식)name이 v인 입력된 값을 가져옴 => HTML
		String op = req.getParameter("operator");
		// name이 v인 입력된 값을 가져옴 => HTML
		int v = 0;

		if(!v_.equals("")) // 빈값이 아니면 대입
			v = Integer.parseInt(v_);
		
		
		// 계산
		if(op.equals("=")) { 
			//int x = (Integer)application.getAttribute("value");
			// (Object형식)이전에 다른 JSP 또는 서블릿 페이지에 설정된 매개 변수를 가져옴
			// Controller Servlet 등에서 View로 전달할 때 사용
			
			//int x = (Integer)session.getAttribute("value");
			// 세션 값 읽기
			
			int x=0;
			for(Cookie c : cookies) {
				if(c.getName().equals("value")) {
					x = Integer.parseInt(c.getValue());
					break;
				} // 여러 쿠키가 존재하므로 for문을 이용해 찾음
			}
				
			int y = v;
			//String operator = (String)application.getAttribute("op");
			//String operator = (String)session.getAttribute("op");
			
			String operator="";
			for(Cookie c : cookies) {
				if(c.getName().equals("op")) {
					operator = c.getValue();
					break;
				}
			}
			
			int result = 0;
			if(operator.equals("+"))
				result = x+y;
			else
				result = x-y;
			
			res.getWriter().printf("result is %d\n ", result);
		}
		// 값 저장
		else { 
			// Application객체 사용
			//application.setAttribute("value", v);
			//application.setAttribute("op", op);
			
			// Sesstion객체 사용
			//session.setAttribute("value", v);
			//session.setAttribute("op", op);
			
			Cookie valueCookie = new Cookie("value", String.valueOf(v));
			Cookie opCooike = new Cookie("op", op);
			// 쿠키 생성
			
			valueCookie.setPath("/Calc2");
			opCooike.setPath("/Calc2");
			// 가져올 쿠키를 결정
			
			res.addCookie(valueCookie);
			res.addCookie(opCooike); 
			// 쿠키 전달
			
		}
		 
		
	}
	
}
