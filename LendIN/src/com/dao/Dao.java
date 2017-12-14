package com.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Dao
{
Connection connect;
PreparedStatement ps;
ResultSet rs;
Boolean flag=false,found=false;
String sql;
String z="";
String url = "jdbc:mysql://localhost:3306/dcb";
String usr="root";
String pwd="";
    
    public Dao() throws SQLException, ClassNotFoundException
    {
    	Class.forName("com.mysql.jdbc.Driver");
	    connect= DriverManager.getConnection(url, usr, pwd);
    }
    
    public boolean newuser(String username, String password, String email, String number, String aadhar, String pan) throws SQLException
    {
    	sql="SELECT * FROM users";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	while(rs.next())
    		{
    			if(rs.getString("user").equals(username))
    			{
    				found=true;
    			}
    		}
    	
    	if(found==false)
    	{
    		sql="INSERT INTO USERS(user, currentpass, previouspass1, previouspass2, email, phone, aadhar, pan, logged) VALUES ('"+username+"', '"+password+"', '', '', '"+email+"', '"+number+"', '"+aadhar+"', '"+pan+"', '0')";
    		ps=connect.prepareStatement(sql);
    		ps.executeUpdate();
    		flag=true;
    	}
    	return flag;
    }
    
    public boolean login(String username, String password) throws SQLException{
    	sql="SELECT * FROM users";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	while(rs.next())
    		{
    			if(rs.getString("user").equals(username))
    			{
    				found=true;
    			}
    		}
    	if(found==true)
    	{
    		sql="SELECT currentpass FROM users where user ='"+username+"'";
        	ps=connect.prepareStatement(sql);
        	rs=ps.executeQuery();
        	while(rs.next())
        		{
        			if(rs.getString("currentpass").equals(password))
        				{
        					flag=true;
        				}
        		}
    	}
    	return flag;
    }
    public String returnPass(String user) throws SQLException{
    	sql="SELECT currentpass FROM users where user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	while(rs.next())
    		{
    			return rs.getString("currentpass");
    		}
    	return "";
    }
    
    public String [] userDetails(String user) throws SQLException{
    	String de[]=new String[4];
    	sql="SELECT * FROM users where user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	while(rs.next())
    		{
    			de[0]=rs.getString("email");
    			de[1]=rs.getString("phone");
    			de[2]=rs.getString("aadhar");
    			de[3]=rs.getString("pan");
    			return de;
    		}
    	return de;
    }

    public void setLogged1(String user) throws SQLException
    {
    	sql="UPDATE users SET logged=1 WHERE user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	ps.executeUpdate();
    }
    	
    public void setLogged0(String user) throws SQLException
    {
    	sql="UPDATE users SET logged=0 WHERE user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	ps.executeUpdate();
    }
    
    public int getLogged(String user) throws SQLException{
    	int status=1;
    	sql="SELECT * FROM users where user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	while(rs.next())
    		{
    		status=rs.getInt("logged");
    		}
    	return status;
    }
    
    public int changePassword(String user, String NewPass) throws SQLException{
    	int status=0;
    	sql="SELECT * FROM users where user ='"+user+"'";
    	ps=connect.prepareStatement(sql);
    	rs=ps.executeQuery();
    	String p2=null;
    	String p3=null;
    	while(rs.next())
    		{
    		String p1=rs.getString("currentpass");
    		p2=rs.getString("previouspass1");
    		p3=rs.getString("previouspass2");
    			if(NewPass.equals(p1)||NewPass.equals(p2)||NewPass.equals(p3)){
    				return status;
    			}
    			else{
    				sql="UPDATE users SET currentpass='"+NewPass+"', previouspass1='"+p1+"', previouspass2='"+p2+"'WHERE user='"+user+"'";
    				ps=connect.prepareStatement(sql);
    		    	ps.executeUpdate();
    				status=1;
    			}
    		}
    	return status;
    }
    
public boolean setborrow(String un, String purpose, String amount, String rate, String tenure, String assets, String mode) throws SQLException{
	sql="INSERT INTO borrowers VALUES ('"+un+"', '"+purpose+"', '"+amount+"', '"+rate+"', '"+tenure+"', '"+assets+"', '"+mode+"')";
	ps=connect.prepareStatement(sql);
	ps.executeUpdate();
	flag=true;
	return flag;
}

public boolean setlender(String un, String amount, String rate, String tenure, String mode) throws SQLException{
	sql="INSERT INTO lenders VALUES ('"+un+"', '"+amount+"', '"+rate+"', '"+tenure+"', '"+mode+"')";
	ps=connect.prepareStatement(sql);
	ps.executeUpdate();
	flag=true;
	return flag;
}

public ResultSet getRSl() throws SQLException{
	sql="SELECT * FROM lenders";
	ps=connect.prepareStatement(sql);
	rs=ps.executeQuery();
	return rs;
}
public ResultSet getRSb() throws SQLException{
	sql="SELECT * FROM borrowers";
	ps=connect.prepareStatement(sql);
	rs=ps.executeQuery();
	return rs;
}
public String getU(String un) throws SQLException{
	sql="SELECT phone FROM users WHERE user='"+un+"'";
	ps=connect.prepareStatement(sql);
	rs=ps.executeQuery();
	while(rs.next())
	{
	z=rs.getString("phone");
	}
	return z;
}
}