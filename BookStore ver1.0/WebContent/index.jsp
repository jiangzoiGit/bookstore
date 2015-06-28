<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="controller.BookList, entity.Bookinfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Welcome to Book Store</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/cover.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
        <style type="text/css"></style>
    </head>

    <body>
   	<!--get base path  -->
    <%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
	
	<!-- check authority  -->
    <%
    	if(session.getAttribute("username") != null){
    			System.out.println((String)session.getAttribute("username"));
    			String site = new String(basePath+"BookList.action");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);     	
    	}
    	else{
    %>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">BOOK STORE</a>
                </div>
            </div>
        </nav>

	<div class="site-wrapper">
		<div class="site-wrapper-inner">
			<div class="cover-container">
				<div class="inner cover">
					<h1 class="cover-heading">Enjoy Your Reading</h1>
					<p class="lead">Whenever you read a good book, somewhere in the
						world a door opens to allow in more light.</p>
					<p class="lead">
						<a href="#" class="btn btn-lg btn-default">Open it now!</a>
					</p>
				</div>
				
				<div  style="text-align:left">
			<div id="loginAndRegister" class="container">
				<div id="loginBox" class="col-md-3" style="float:left; margin:30px" >
					<h3>Login</h3>
					
					<s:form role="form" action="login">
						<label class="control-label">Username:</label>
						<input type="text" name="userinfo.username" id="login_userinfo_username" placeholder="Username" class="class java.util.HashMap form-control"/>
						<label class="control-label">Password:</label>	    				
	    				<input type="password" name="userinfo.password" id="login_userinfo_password" placeholder="Password" class="class java.util.HashMap form-control"/>
	    				<input class="btn btn-primary" type="submit" style="float:right; margin:20px" value="登入"> 
					</s:form> 
					<%
						 
						if (session.getAttribute("error_login") != null){
					%>
					<p style="color:red">Username/Password is not correct.</p></br>
						
					<%
							session.setAttribute("error_login", null);
						}
					%>
				</div>
				<div id="registerBox" class="col-md-3" style="float:left; margin:30px">
					<h3>Register</h3>
					<s:form role="form" action="register">
	  					<label class="control-label">Username:</label>
	  					<input type="text" name="userinfo.username" id="register_userinfo_username" placeholder="Username" class="class java.util.HashMap form-control"/>
						<label class="control-label">Password:</label>	    				
	    				<input type="password" name="userinfo.password" id="register_userinfo_password" placeholder="Password" class="class java.util.HashMap form-control"/>
	    				<input class="btn btn-primary" type="submit" style="float:right; margin:20px" value="注册">
					</s:form> 
					<%
						if (session.getAttribute("error_register")!=null){
							if (session.getAttribute("error_register").equals("reg_exist")){
					%>
					<p style="color:red">This username is existed!</p></br>
						
					<%
								session.setAttribute("error_register", null);
							}
							else if (session.getAttribute("error_register").equals("reg_wrong")){
							
					%>
								<p style="color:red">This username/password should be longer than 5 letters!</p></br>
					<%
								session.setAttribute("error_register", null);
							}
						}
					%>
				</div>
			</div>
		</div>

				 <div class="mastfoot">
					<div class="inner">
						<p>
							by <a href="#">@jiangzoi</a>.
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
    	}
	%>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200" preserveAspectRatio="none" style="visibility: hidden; position: absolute; top: -100%; left: -100%;"><defs></defs><text x="0" y="10" style="font-weight:bold;font-size:10pt;font-family:Arial, Helvetica, Open Sans, sans-serif;dominant-baseline:middle">200x200</text></svg></body>
	
	
	<script type="text/javascript" >
	
	</script>

</html>
