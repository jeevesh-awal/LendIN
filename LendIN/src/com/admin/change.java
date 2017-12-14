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

@WebServlet("/change")
public class change extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	String CurrentPassword=request.getParameter("cp");
	String NewPassword=request.getParameter("np");
	String ConfirmNewPassword=request.getParameter("cnp");
	if(!NewPassword.equals(ConfirmNewPassword)){
		response.getWriter().println("<script>alert('New Password and Confirmed Password Dont match.');</script><meta http-equiv='Refresh' content='0;url=change.jsp'>");
	}
	else{
	String salt="q1w2e#r$";
	NewPassword=salt+NewPassword;
	CurrentPassword=salt+CurrentPassword;
	String eep = null;
	String eep1= null;
	try {
		MessageDigest m=MessageDigest.getInstance("MD5");
		m.update(CurrentPassword.getBytes(),0,CurrentPassword.length());
		eep=new BigInteger(1,m.digest()).toString(16);
		
		m.update(NewPassword.getBytes(),0,NewPassword.length());
		eep1=new BigInteger(1,m.digest()).toString(16);
		
	} catch (NoSuchAlgorithmException e1) {
		e1.printStackTrace();
	}

	HttpSession session=request.getSession();
	if(!session.isNew()){
		String un=session.getAttribute("userdetails").toString();
		String pw=session.getAttribute("usercode").toString();
		System.out.println("EEP: "+eep);
		System.out.println("PW: "+pw);	
			if(!pw.equals(eep)){	
				response.getWriter().println("<script>alert('Wrong Password Entered.');</script><meta http-equiv='Refresh' content='0;url=user.jsp'>");
			}
			else{
				try {
					Dao d=new Dao();
					int status=d.changePassword(un,eep1);
					if(status==1){
						response.getWriter().println("<script>alert('Password Changed');</script><meta http-equiv='Refresh' content='0;url=user.jsp'>");
					}
					else{
						response.getWriter().println("<script>alert('Password same as previous 3 passwords.');</script><meta http-equiv='Refresh' content='0;url=change.jsp'>");
					}
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
			}
		
		}
	}
	}

}
