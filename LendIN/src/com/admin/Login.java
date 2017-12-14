package com.admin;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Dao;

import java.util.Base64;

@WebServlet("/Login")
public class Login extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=request.getParameter("user");
		String password=request.getParameter("pass");
		Boolean status=false;
		
		String salt="q1w2e#r$";
		password=salt+password;
		
		String eusername = Base64.getEncoder().encodeToString(username.getBytes());
		String epassword = null;
		try {
			MessageDigest m=MessageDigest.getInstance("MD5");
			m.update(password.getBytes(),0,password.length());
			epassword=new BigInteger(1,m.digest()).toString(16);
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
		System.out.println("username: "+eusername+"  password: "+epassword);
		try
		{
			Dao d=new Dao();
			status=d.login(eusername, epassword);
				if(status==true){

					System.out.println("Status of logged: "+d.getLogged(eusername));	
					if(d.getLogged(eusername)==0){
						d.setLogged1(eusername);
	

						HttpSession session=request.getSession();
							
							if(!session.isNew()){
								session.invalidate();
								session=request.getSession(true);
								}
					
							session.setMaxInactiveInterval(600);
							session.setAttribute("userdetails",eusername);
							session.setAttribute("usercode",epassword);
							response.getWriter().println("<html><meta http-equiv='Refresh' content='0;url=user.jsp'></html>");
					}else{
						response.getWriter().println("<script>alert('User Already Logged in!');</script><meta http-equiv='Refresh' content='0;url=Logout'>");
					}
				}
				else {
					response.getWriter().println("<html><script>alert('Wrong Credentials!');</script><meta http-equiv='Refresh' content='0;url=ls.html'></html>");
				}
		}
		catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e);
		}
	}
}
