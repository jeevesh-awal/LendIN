package com.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Dao;

@WebServlet("/Lender")
public class Lender extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String amount=request.getParameter("amount");
		String rate=request.getParameter("rate");
		String tenure=request.getParameter("tenure");
		String mode=request.getParameter("mode");
		Boolean status=false;
		
		String eamount = Base64.getEncoder().encodeToString(amount.getBytes());
		String erate = Base64.getEncoder().encodeToString(rate.getBytes());
		String etenure = Base64.getEncoder().encodeToString(tenure.getBytes());
		String emode = Base64.getEncoder().encodeToString(mode.getBytes());
		
		HttpSession session=request.getSession();
		String un=session.getAttribute("userdetails").toString();
		try
		{
			Dao d=new Dao();
			status=d.setlender(un, eamount, erate, etenure, emode);
				if(status==true){
					response.getWriter().println("<html><script>alert('Data Registered!');</script><meta http-equiv='Refresh' content='0;url=user.jsp'></html>");
				}
				else {
					response.getWriter().println("<html><script>alert('Data Not Registered!');</script><meta http-equiv='Refresh' content='0;url=borrower.jsp'></html>");
				}
		}
		catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e);
		}
	}

}
