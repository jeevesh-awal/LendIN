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
      		<li class="active"><a href="user.jsp">Home Page</a></li>
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
		<h4>The current time is: <%=hours %>:<%=minutes %>:<%=seconds %></h4>
		
  	<div class="row">
	<div class="col-lg-6">
		<a href="lender.jsp" style="text-decoration: none;"><button class="btn btn-block" id="one"><h2>LENDER</h2><br></button></a><br>
	
	<h2>Recent Lenders Quotes</h2>
<%
ResultSet rl=d.getRSl();
ResultSet rb=d.getRSb();
%>
<table class="table table-striped table-bordered table-hover">
<tr>
<th>SNo</th>
<th>Username</th>
<th>Amount</th>
<th>Remaining</th>
<th>Rate</th>
<th>Tenure</th>
</tr>
<%
int i=0;
float r1=0;
int n1=0;
while(rl.next()){ 
	String u=rl.getString(1);
	String Amount=rl.getString(2);
	String Rate=rl.getString(3);
	String Tenure=rl.getString(4);
	
	String dun = new String(decoder.decode(u));
	String dAmount = new String(decoder.decode(Amount));
	String dRate = new String(decoder.decode(Rate));
	String dTenure = new String(decoder.decode(Tenure));
i++;
%>
<tr>
<td><%=i%></td>
<td><%=dun %></td>
<td><%=dAmount %></td>
<td><%=dAmount %></td>
<td><%=dRate %></td>
<td><%=dTenure %></td>
</tr>
<% n1=Integer.parseInt(dRate);
r1+=n1;
}
r1=r1/(i);
%>
<tr>

</table>
	</div>
	<div class="col-lg-6">
		<a href="borrower.jsp" style="text-decoration: none;"><button class="btn btn-block" id="one"><h2>BORROWER</h2><br></button></a><br>
<h2>Recent Borrowers Quotes</h2>

<table class="table table-striped table-bordered table-hover">
<tr>
<th>SNo</th>
<th>Username</th>
<th>Purpose</th>
<th>Amount</th>
<th>Remaining</th>
<th>Rate</th>
<th>Tenure</th>
</tr>
<%
float r=0;
int j=0,n=0;
while(rb.next()){ 
	String u=rb.getString(1);
	String Purpose=rb.getString(2);
	String Amount=rb.getString(3);
	String Rate=rb.getString(4);
	String Tenure=rb.getString(5);
	
	String dun = new String(decoder.decode(u));
	String dPurpose = new String(decoder.decode(Purpose));
	String dAmount = new String(decoder.decode(Amount));
	String dRate = new String(decoder.decode(Rate));
	String dTenure = new String(decoder.decode(Tenure));
j++;
%>
<tr>
<td><%=j%></td>
<td><%=dun %></td>
<td><%=dPurpose %></td>
<td><%=dAmount %></td>
<td><%=dAmount %></td>
<td><%=dRate %></td>
<td><%=dTenure %></td>
</tr>
<% n=Integer.parseInt(dRate);
r+=n;
}
r=r/(j);
%>
</table>
	</div>
</div>
<div class="row">
		<div class="col-lg-6">
			<a href=""  style="text-decoration: none"><button class="btn btn-block" id="one"><h4>Average Rate of Interest (Lender):<%=r1 %></h4></button></a>
		</div>
		<div class="col-lg-6">
			<a href=""  style="text-decoration: none"><button class="btn btn-block" id="one"><h4>Average Rate of Interest (Borrower):<%=r %></h4></button></a>
		</div>
	</div>

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