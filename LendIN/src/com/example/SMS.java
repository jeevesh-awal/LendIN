package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SMS")
public class SMS extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response1) throws ServletException, IOException {
		//Your authentication key
        String authkey = "173956Aai8hSjfN59b4a166";
        //Multiple mobiles numbers separated by comma
        String mobiles = "9650276624";
        //Sender ID,While using route4 sender id should be 6 characters long.
        String senderId = "CodenC";
        //Your message to send, Add URL encoding here.
        String message = "Welcome to code&crack. 9650276624 is your number.";
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
            String response;
            while ((response = reader.readLine()) != null)
            //print response
            System.out.println(response);

            //finally close connection
            reader.close();
        }
        catch (IOException e)
        {
                e.printStackTrace();
        }
	}

}
