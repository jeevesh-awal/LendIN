<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="com.dao.Dao"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<%

	if(!session.isNew()){
	String un=session.getAttribute("userdetails").toString();
	String pw=session.getAttribute("usercode").toString();
	Base64.Decoder decoder = Base64.getDecoder();  
    String dusername = new String(decoder.decode(un)); 
    
    Dao d=new Dao();
    
	if(pw.equals(d.returnPass(un)))
	{
		String [] det=new String[2];
		det=d.userDetails(un);
		String demail = new String(decoder.decode(det[0]));
		String dphone = new String(decoder.decode(det[1]));
		%>
	<head>
		<title>Welcome <%=dusername%></title>
		<meta charset="utf-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  		
	</head>

	<body>
	<div class="container">
		
	<nav class="navbar navbar-inverse navbar-fixed-top">
  		<div class="container">
    		<div class="navbar-header">

    		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>                        
      		</button>
      		<style type="text/css">
  		.navbar-brand {
  padding: 0px;
}
.navbar-brand>img {
  height: 100%;
  padding: 5px;
  width: auto;
}
  		</style>
      		<a class="navbar-brand" href="#"><img src="img/logo.jpg" alt="LendIN"></a>
      		</div>
    	<div class="collapse navbar-collapse" id="myNavbar">
    	<ul class="nav navbar-nav">
      		<li><a href="user.jsp">Home Page</a></li>
      		<li><a href="lend.jsp">Want to Lend?</a></li>
      		<li class="active"><a href="borrow.jsp">Want to Borrow?</a></li>
      		<li><a href="myrequests.jsp">My Requests</a></li>
      		<li><a href="change.jsp">Change Password</a></li>
    	</ul>

    	<ul class="nav navbar-nav navbar-right">
      		<li><a href="Logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
    	</ul>
  		
  		</div>
  		</div>
	</nav>
  <br><br>
	<div class="jumbotron" align="justify">
	<%
	Date date=new Date();
	int hours=date.getHours();
	int minutes=date.getMinutes();
	int seconds=date.getSeconds();
	%>
		<h5>The current time is: <%=hours %>:<%=minutes %>:<%=seconds %></h5>
		<br>
		<div class="row">
		<div class="col-lg-6">
		<div class="jumbotron">
		<h2>Why borrow on LendIn?</h2>	
	<ul>
	<li>Freedom to choose from verified lenders.</li>
	<li>Flexible loan repay tenure.</li>
	<li>Transparent and user-friendly interface.</li>
	<li>View live market scenario and accordingly request your desired percentage.</li>
	</ul>
		</div>
		</div>
		<div class="col-lg-6">
		<img src="img/borrow.png" width="70%">
		</div>
		
		
  	<br>
  	<div></div>
	</div>

	</div>
	</body>
		<%
			
		}else{session.invalidate(); %>
		<h1>Login to continue. Session Expired.</h1><meta http-equiv='Refresh' content='0;url=index.html'>
		<%}
	} 
	else{
		session.invalidate();
		%>
		<h1>Login to continue. Session Expired.</h1><meta http-equiv='Refresh' content='0;url=index.html'>
		<%
	}
	
	%>
</html>