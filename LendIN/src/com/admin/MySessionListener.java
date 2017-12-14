package com.admin;

import java.sql.SQLException;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.dao.Dao;


@WebListener
public class MySessionListener implements HttpSessionListener {

	public void sessionDestroyed(HttpSessionEvent e)  { 
		HttpSession s=e.getSession();
		String username=s.getAttribute("userdetails").toString();
	    System.out.println("Session Destroyed! For "+username);
	    Dao d;
		try {
			d = new Dao();
			d.setLogged0(username);
		} catch (ClassNotFoundException | SQLException e1) {
			e1.printStackTrace();
		}
	  
		
    }

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {

	}
	
}
