<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>ENJOY BOOKS!</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/myStyle.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<script src="js/jquery.min.js"></script>
    	<script src="js/bootstrap.min.js"></script>
    	
    	<style>
            .table th, .table td { 
				text-align: center;
				vertical-align: middle; 
				height:38px;
			}
        </style>
    <body>
    
    <!--get base path  -->
    <%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
	
    <%
    		//set the decimal format
    		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
    		if (session.getAttribute("username") == null){
    			String site = new String(basePath + "index.jsp");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);
    		}
    %>
    	
	<!--Navigation bar on the top of page  -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="<%=basePath%>bookList.jsp">BOOK STORE</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
						<li>
							<a href="<%=basePath %>Profile.jsp" id="showmoney"> Welcome, <%=session.getAttribute("username") %></a>
						</li>
						<li>
							<a href="<%=basePath%>ShoppingCart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true">My Cart</span></a>
						</li>
                        <li><a href="#" class="logout">Logout</a></li>
                        	
                        <% if (session.getAttribute("admin") != null){ %>
                        <li><a href="<%=basePath %>manageView.jsp" style="color:yellow">Manage Page</a></li>
                        <%} %>
                    </ul>
                </div>
            </div>
        </nav>			
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                    	<li id="1" class="nav_category active"><a>Status<span class="sr-only">(current)</span></a>
                    </ul>
                </div>
                <div class="col-sm-9">
               		<div class="container">
			        	<div class="col-md-3">
			        	</div>
			        	<div class="col-md-6">
			        		<h5><a href="<%=basePath%>bookList.jsp">Go Back to Store</a></h5>
			      			<p>Thank you for your payment.</p>
			      			<br/>
			      			<img alt="success" src="<%=basePath %>img/paySuccess.jpg"/>
			        	</div>
			        	<div class="col-md-3">
			        	</div>
			        </div>
				</div>
        	</div>
        </div>
        
    	
        
		<script>
			$(".logout").on("click",function(e){
				var tempForm = document.createElement("form");
				tempForm.method = "POST";
				tempForm.action = "<%=basePath%>logout.action";
				tempForm.submit();
			});
		</script>
</html>
