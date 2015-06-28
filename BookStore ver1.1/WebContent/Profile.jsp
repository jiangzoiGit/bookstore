<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="controller.BookList, entity.Bookinfo, dao.UserinfoDao, org.springframework.context.support.AbstractApplicationContext, 
org.springframework.context.support.ClassPathXmlApplicationContext, entity.Userinfo, service.UserinfoService" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Profile</title>

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
                    <a class="navbar-brand" href="<%=basePath%>BookList.action">BOOK STORE</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
						<li>
							<a href="<%=basePath %>Profile.jsp" id="showmoney"> Welcome, <%=session.getAttribute("username") %></a>
						</li>
						<li>
							<a href="<%=basePath%>ShoppingCart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>My Cart</a>
						</li>
                        <li><a href="#" class="logout">Logout</a></li>
                        	
                        <% if (session.getAttribute("admin") != null){ %>
                        <li><a href="<%=basePath %>manageView.jsp" style="color:yellow">Manage Page</a></li>
                        <%} %>
                    </ul>                  
                </div>
            </div>
        </nav>		
        	

		
		<%
			AbstractApplicationContext apc = new ClassPathXmlApplicationContext("applicationContext.xml");
			//UserinfoDao userinfoDao = (UserinfoDao) apc.getBean("userinfoDao");
			//Userinfo user = userinfoDao.findUserinfoByName((String)session.getAttribute("username"));
			UserinfoService userServ = (UserinfoService) apc.getBean("userinfoService");
			String username = (String)session.getAttribute("username");
			Userinfo user = userServ.getAllDao().getUserinfoDao().findUserinfoByName(username);
			String userid = user.getId();
			String detail = userServ.findDetail(userid);
			if (detail == null) detail = "";
			String photoAddress = userServ.findPhoto(userid);
			if (photoAddress == null) photoAddress = "photo-default.jpg";
		%>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                    	<li id="1" class="nav_category active" style="text-align:center;"><a herf="#" >My Account<span class="sr-only">(current)</span></a>
                    </ul>
                </div>
                
                
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <h2 class="sub-header">Profile</h2>
                    <div class="container">
                  		
      					<div class="col-md-10" id="tab1" style="display:none;">           
      						<div class="panel panel-default">
      							<div class="panel-heading">
      								<h3>My Photo</h3>
      							</div>
      							<div class="panel-body">
      								<div class="container">
      									<div class="col-md-3"></div>
      									<div class="col-md-4">
      										<img class="img-thumbnail" alt="200x200" src="img/photo/<%=photoAddress %>" data-holder-rendered="true">
      										<br/>
      									</div>
      									<div class="col-md-3">
      										&nbsp;<br/>
      										&nbsp;<br/>
      										&nbsp;<br/>
      										&nbsp;<br/>
      										&nbsp;<br/>
      										<button class="btn btn-primary" onclick="choosePhoto()">Modify</button>
      									</div>
      								</div>      								      						
      							</div>       						
      						</div>	
      						
						   	<div class="panel panel-default">
						   		<div class="panel-heading">
						   			<h3>My Balance</h3>
						   		</div>
						   		<div class="panel-body">
						    		<p>In my account I have <strong><%=df.format(user.getBalance()) %>$ :)</strong></p>
						   		</div>
						  	</div>
						  
						  <div class="panel panel-default">
						   		<div class="panel-heading">
						   			<h3>My Detail</h3>
						   		</div>
						   		<div class="panel-body row">
							   		<div class="input-group col-sm-12" style="height: 200px">
										<textarea class="input-group form-control" id="detail" name="content" rows="8" cols="120" placeholder="Describe yourself here." aria-describedby="basic-addon2"><%=detail %></textarea>
									</div>
									<div>
										<button class="btn btn-primary" style="float:right; margin:20px" onclick="sendDetail()">submit</button>
									</div>
						   		</div>
						  </div>
      					</div>
                    </div>
                </div>
            </div>
        </div>
        
    <div class="modal fade" id="successModify" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<strong>Complete  Modification</strong>
      			</div>
      			<div class="modal-body">
      				<span></span><br/>
      				<span></span><br/>
      				<span></span><p> &nbsp;&nbsp;&nbsp;&nbsp;Enjoy your trip~</p>
      				<span></span><br/>
      				<span></span><br/>
      			</div>
      			
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
        

  	<div class="modal fade" id="choosePhoto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<strong>Choose your photo</strong>
      			</div>
      			<div class="modal-body">
      				<img onclick="selectPhoto(1)" class="img-thumbnail" alt="200x200" src="img/photo/photo1.jpg" data-holder-rendered="true">
      				<img onclick="selectPhoto(2)" class="img-thumbnail" alt="200x200" src="img/photo/photo2.jpg" data-holder-rendered="true">
      				<img onclick="selectPhoto(3)" class="img-thumbnail" alt="200x200" src="img/photo/photo3.jpg" data-holder-rendered="true">
      				<img onclick="selectPhoto(4)" class="img-thumbnail" alt="200x200" src="img/photo/photo4.jpg" data-holder-rendered="true">
      			</div>
      			
      			
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
			
			var lastTab = "#tab1";
			$("#tab1").show();
			
			$(".nav_category").on("click", function(e){
				$(lastTab).hide();
				$("#" + "tab" + this.id).show();
				lastTab = "#" + "tab" + this.id;
				$(".active").removeClass("active");
				$(this).addClass("active");
			});
			
			
			function sendDetail(){
				var detail = document.getElementById("detail").value;
				var url = "<%=basePath%>ModifyProfile.action";
				var params = $.param({'detail':detail},true);
				
				$.get("<%=basePath%>ModifyProfile.action", "detail=" + detail, function(data){
					window.location.href = '<%=basePath%>Profile.jsp';
				});
			}
			
			function choosePhoto(){
				$("#choosePhoto").modal("show");
			}
			
			function selectPhoto(id){
				photosrc = "photo"+ id + ".jpg";
				$.get("<%=basePath%>ModifyProfile.action", "photo=" + photosrc, function(data){
					window.location.href = '<%=basePath%>Profile.jsp';
				});
			}

		</script>
</html>
