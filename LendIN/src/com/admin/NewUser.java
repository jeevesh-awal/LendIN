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
import com.dao.Dao;
import java.util.Base64;
import java.util.regex.Pattern;

@WebServlet("/NewUser")
public class NewUser extends HttpServlet 
{
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String email=request.getParameter("email");
		String number=request.getParameter("number");
		String aadhar=request.getParameter("aadhar");
		String pan=request.getParameter("pan");
		Boolean status=false;
		if(Pattern.matches("[a-zA-Z][a-zA-Z_0-9]*", username))
		{
			
		String salt="q1w2e#r$";
		password=salt+password;
		String eusername = Base64.getEncoder().encodeToString(username.getBytes());
		String epassword = null;
		String eemail = Base64.getEncoder().encodeToString(email.getBytes());
		String enumber = Base64.getEncoder().encodeToString(number.getBytes());
		String eaadhar = Base64.getEncoder().encodeToString(aadhar.getBytes());
		String epan = Base64.getEncoder().encodeToString(pan.getBytes());
		
		try {
			MessageDigest m=MessageDigest.getInstance("MD5");
			m.update(password.getBytes(),0,password.length());
			epassword=new BigInteger(1,m.digest()).toString(16);
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
		Base64.getDecoder().decode(eusername);
		
			try
			{
				Dao d=new Dao();
				status=d.newuser(eusername, epassword, eemail, enumber, eaadhar,epan);
					if(status==true){
						response.getWriter().println("<html><script>alert('User Registered!');</script><meta http-equiv='Refresh' content='0;url=ls.html'></html>");
					}
					else {
						response.getWriter().println("<html><script>alert('Username Exists!');</script><meta http-equiv='Refresh' content='0;url=ls.html'></html>");
					}
			}
			catch (ClassNotFoundException | SQLException e) {
				response.getWriter().println(e);
			}
		
		}
		else{
			response.getWriter().println("<html><script>alert('Username should start with an Alphabet and should be alphanumeric.');</script><meta http-equiv='Refresh' content='0;url=ls.html'></html>");
		}
		}
}