package com.admin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Dao;

@WebServlet("/forgot")
public class forgot extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=request.getParameter("username");
		String eusername = Base64.getEncoder().encodeToString(username.getBytes());
		try
		{
			Dao d=new Dao();
			String p=d.getU(eusername);
			Base64.Decoder decoder = Base64.getDecoder();  
		    String mobiles = new String(decoder.decode(p)); 
			
		  //Your authentication key
	        String authkey = "173956Aai8hSjfN59b4a166";
	        //Sender ID,While using route4 sender id should be 6 characters long.
	        String senderId = "LENDIN";
	        //Your message to send, Add URL encoding here.
	        String message = "You've tried to recover your password.";
	        //define route
	        String route="";

	        //Prepare Url
	        URLConnection myURLConnection=null;
	        URL myURL=null;
	        BufferedReader reader=null;

	        //encoding message
	        String encoded_message=URLEncoder.encode(message);

	        //Send SMS API
	        String mainUrl="http://api.msg91.com/api/sendhttp.php?";

	        //Prepare parameter string
	        StringBuilder sbPostData= new StringBuilder(mainUrl);
	        sbPostData.append("authkey="+authkey);
	        sbPostData.append("&mobiles="+mobiles);
	        sbPostData.append("&message="+encoded_message);
	        sbPostData.append("&route="+route);
	        sbPostData.append("&sender="+senderId);

	        //final string
	        mainUrl = sbPostData.toString();
	        try
	        {
	            //prepare connection
	            myURL = new URL(mainUrl);
	            myURLConnection = myURL.openConnection();
	            myURLConnection.connect();
	            reader= new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
	            //reading response
	            String re;
	            while ((re = reader.readLine()) != null)
	            //print response
	            System.out.println(re);

	            //finally close connection
	            reader.close();
	        }
	        catch (IOException e)
	        {
	                e.printStackTrace();
	        }
		}
		catch (ClassNotFoundException | SQLException e) {
			response.getWriter().println(e);
		}
	}
}
