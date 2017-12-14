package com.example;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FileCheck")
public class FileCheck extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		File TmpDir = new File("/Users/jeeveshawal/Documents/IdeaMIS/source");
		boolean directory = TmpDir.isDirectory();
	    
		if (directory)
	    {
	    	response.getWriter().println("We are inside: "+TmpDir.getAbsolutePath());
	    	File[] listOfFiles = TmpDir.listFiles();
	    	
	    		for (int i = 0; i < listOfFiles.length; i++) 
	    		{
	    			if (listOfFiles[i].isFile()) 
	    			{
	    				response.getWriter().println("File: " + listOfFiles[i].getName());
	    			}
	    			else if (listOfFiles[i].isDirectory())
	    			{
	    				response.getWriter().println("Directory: " + listOfFiles[i].getName());
	    			}
	    	    }
	    }
		
	    else{
	    	response.getWriter().println("Directory Not Found");
	    }
		
	}

}
