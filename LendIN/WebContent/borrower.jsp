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
      		<li><a href="borrow.jsp">Want to Borrow?</a></li>
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
		<h2>Borrower</h2>
  	  	<h5>In order to borrow money please provide us with a few necessary details: </h5>
  	<br>
<form action="Borrow">
  	
  	<div class="form-group">
    <label for="fund">Purpose of taking Fund:</label>
    <input type="text" class="form-control" id="purpose" name="purpose" placeholder="Briefly decribe the reason for which you need funds">
  	</div>
  	<div class="form-group">
    <label for="amount">Amount of Fund Required:</label>
    <input type="number" class="form-control" id="amount" name="amount" placeholder="(In Rs) which you seek.">
  	</div>
  	<div class="form-group">
    <label for="interest">Annual Rate of Interest:</label>
    <input type="number" class="form-control" id="rate" name="rate" placeholder="(In %) under which you would like to transact">
  	</div>
  	<div class="form-group">
    <label for="tenure">Tenure of Fund:</label>
    <input type="number" class="form-control" id="tenure" name="tenure" placeholder="(In months) for which fund is required.">
  	</div>
  	<div class="form-group">
    <label for="assets">Assets:</label>
    <input type="text" class="form-control" id="tenure" name="assets" placeholder="Briefly describe your assets which you would mortgage">
  	</div>
  	<div class="form-group">
    <label for="assets">Mode of income:</label>
    <input type="text" class="form-control" id="tenure" name="mode" placeholder="Briefly describe your mode of income including your nature of business">
  	</div>
  	<br>
  	<input type="submit" name="s" />
</form>
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