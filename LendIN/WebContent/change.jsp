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
		<link rel="stylesheet" href="css/main.css">
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
      		<li class="active"><a href="change.jsp">Change Password</a></li>
    	</ul>

    	<ul class="nav navbar-nav navbar-right">
      		<li><a href="Logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
    	</ul>
  		
  		</div>
  		</div>
	</nav>
  <div class="jumbotron" style="margin-top:10%">

  <h1>Change Password</h1>
  <div class="col-md-4">
			
				<div id="pswd_info1" style="border-radius:15px">
					<h4 style="padding: 2%;border-radius:15px 15px 0px 0px">Password must follow these requirements</h4>
					<ul>
						<li id="letter" class="invalid">At least <strong>one lower case letter</strong></li>
						<li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
						<li id="number" class="invalid">At least <strong>one number</strong></li>
						<li id="length" class="invalid">Be at least <strong>8 characters</strong></li>
						<li id="space" class="invalid">be<strong> use [~,!,@,#,$,%,^,&,*,-,=,.,;,']</strong></li>
					</ul>
				</div>
		</div>
  	<form action="change" class="form-inline" method="post">
  	<br>
  	<div class="form-group">
      <label class="sr-only" for="Current Password">Current Password:</label>
      <input type="password" class="form-control" placeholder="Current Password"  name="cp" required>
    </div>
    <br><br>
  	<div class="form-group">
      <label class="sr-only" for="New Password">New Password:</label>
      <input type="password" class="form-control" placeholder="New Password"  name="np" required>
    </div>
    <br><br>
    <div class="form-group">
      <label class="sr-only" for="Confirm New Password">Confirm New Password:</label>
      <input type="password" class="form-control" id="paw"  placeholder="Confirm New Password"  name="cnp" required>
    </div>

    <br>
    <br>
    <p>
    <input type="submit" class="btn btn-default">
    </p>
  	</form>

  </div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
	
	$('input[type=password]').keyup(function() {
		var pswd = $(this).val();
		
		//validate the length
		if ( pswd.length < 8 ) {
			$('#length').removeClass('valid').addClass('invalid');
		} else {
			$('#length').removeClass('invalid').addClass('valid');
		}
		
		//validate letter
		if ( pswd.match(/[a-z]/) ) {
			$('#letter').removeClass('invalid').addClass('valid');
		} else {
			$('#letter').removeClass('valid').addClass('invalid');
		}

		//validate capital letter
		if ( pswd.match(/[A-Z]/) ) {
			$('#capital').removeClass('invalid').addClass('valid');
		} else {
			$('#capital').removeClass('valid').addClass('invalid');
		}

		//validate number
		if ( pswd.match(/\d/) ) {
			$('#number').removeClass('invalid').addClass('valid');
		} else {
			$('#number').removeClass('valid').addClass('invalid');
		}
		
		//validate space
		if ( pswd.match(/[^a-zA-Z0-9\-\/]/) ) {
			$('#space').removeClass('invalid').addClass('valid');
		} else {
			$('#space').removeClass('valid').addClass('invalid');
		}
		
	}).focus(function() {
		$('#pswd_info').show();
	}).blur(function() {
		$('#pswd_info').hide();
	});
	
});
	function ValidationEvent()
	{
		if(document.getElementById('length').className=='valid'&&document.getElementById('letter').className=='valid'&&document.getElementById('capital').className=='valid'&&document.getElementById('number').className=='valid'&&document.getElementById('space').className=='valid')
			{
			return true;
			}
		else
			{
			alert('Input Password Doesnt fulfiled required passowrd conditions! Check password.');
			return false;
			}
	}
	</script>
	</body>
		<%
			
		}else{session.invalidate(); %>
		<h1>Login to continue. Session Expired.</h1><meta http-equiv='Refresh' content='2;url=index.html'>
		<%}
	} 
	else{
		session.invalidate();
		%>
		<h1>Login to continue. Session Expired.</h1><meta http-equiv='Refresh' content='2;url=index.html'>
		<%
	}%>
</html>