<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="dao.BookinfoDao, dao.UserinfoDao, org.springframework.context.support.AbstractApplicationContext, 
org.springframework.context.support.ClassPathXmlApplicationContext, entity.Bookinfo, entity.Userinfo" %>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Statistic</title>
	<meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Manage View</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    	<link href="css/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />
    	<link href="css/bootstrap/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
        
        <!-- global -->
        <link rel="stylesheet" type="text/css" href="css/layout.css" />
   	 	<link rel="stylesheet" type="text/css" href="css/elements.css" />
   	 	<link rel="stylesheet" type="text/css" href="css/icons.css" />

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    	<link href="css/lib/font-awesome.css" type="text/css" rel="stylesheet" />
    	<link href="css/lib/morris.css" type="text/css" rel="stylesheet" />

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style>
            .table th, .table td { 
				text-align: center; 
			}
    </style>
</head>

	<!--get base path  -->
    <%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>

    <!-- top navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="<%=basePath%>manageView.jsp">Book Store Manage</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="<%=basePath %>Profile.jsp">Welcome, <%=session.getAttribute("username") %><span class=""></a></li>
                    <li><a href="#" class="logout">Logout</a></li>
                    <% if (session.getAttribute("admin") != null){ %>
                    <li><a href="<%=basePath %>BookList.action" style="color:yellow">Customer Page</a></li>
                    <%} %>
                </ul>
            </div>
        </div>
    </nav>
<body>

	<%
    	if(session.getAttribute("admin") == null){
    			String site = new String(basePath + "BookList.action");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);     	
    	}
    %>
    
    <!--sidebar navigation -->	
	<div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li class="nav_choice active" id="1">                
                <a href="#">
                    <div class="pointer" id="pointer1">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <span>User</span>
                </a>
            </li>            
            <li class="nav_choice" id="2">
                <a href="#">
                    <div class="pointer" id="pointer2">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <span>Book</span>
                </a>
            </li>
            <li class="nav_choice" id="3">
                <a href="#">
                    <div class="pointer" id="pointer3">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <span>Category</span>
                </a>
            </li>
            <li>
            	
            </li>
            
            
    </div>
	<!-- main container -->
	<!-- By User -->
	
    <div class="content" id="tab1">
        <div class="container-fluid">
            <div id="pad-wrapper">
   				<table class="table table-hover">
					<thead>
				        <tr>
				          <th>ID</th>
				          <th>Username</th>
				          <th>Balance</th>
				          <th>
				          	  <div class="checkbox">
      						  <label>
      						  		<input type="checkbox">
      						  </label>
   							  </div>
				          </th>
				        </tr>
				      </thead>
				      <tbody>
				<%	
						java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
						AbstractApplicationContext apc = new ClassPathXmlApplicationContext("applicationContext.xml");
						UserinfoDao userinfoDao = (UserinfoDao)apc.getBean("userinfoDao");
						ArrayList<Userinfo> userList = userinfoDao.getAllUser();
						int userCount = 0;
						for (Iterator<Userinfo> it = userList.iterator(); it.hasNext();) {
							Userinfo userBean = (Userinfo) it.next();
							if (userBean.getPrivilege().equals("0"))
								continue;
							userCount++;
				%>
				        <tr>
				          <th id="<%="id" + userBean.getId()%>"><%=userBean.getId()%></th>
				          <td id="<%="username" + userBean.getId()%>"><%=userBean.getUsername()%></td>
				          <td id="<%="balance" + userBean.getId() %>"><%=df.format(userBean.getBalance()) %></td> 
				          <td>
				              <div class="checkbox">
      						  <label>
      						  		<input type="checkbox" value="<%=userBean.getId() %>" id="usercheckbox<%=userCount %>">
      						  </label>
   							  </div>
				          </td>
				        </tr>
				<%
						}
				%>
					</tbody>
				</table>
				<div class="pull-right">
					<a class="btn btn-default" href="#" role="button" onclick="userStatistic()">Result</a><br/>
				</div>

            </div>
        </div>
    </div>
    
    <!--By Book  -->
    <div class="content" id="tab2">
        <div class="container-fluid">
            <div id="pad-wrapper">
    			<table class="table table-hover">
					<thead>
				        <tr>
				          <th>ID</th>
				          <th>Bookname</th>
				          <th>Price</th>
				          <th>
				          	  <div class="checkbox">
      						  <label>
      						  		<input type="checkbox">
      						  </label>
   							  </div>
				          </th>
				        </tr>
				      </thead>
				      <tbody>
				<%	
						BookinfoDao bookinfoDao = (BookinfoDao)apc.getBean("bookinfoDao");
						ArrayList<Bookinfo> bookList = bookinfoDao.getAllBook();
						int bookCount = 0;
						for (Iterator<Bookinfo> it = bookList.iterator(); it.hasNext();) {
							Bookinfo bookBean = (Bookinfo) it.next();
							bookCount++;
				%>
				        <tr>
				          <th id="<%="bookid" + bookBean.getId()%>"><%=bookBean.getId()%></th>
				          <td id="<%="bookname" + bookBean.getId()%>"><%=bookBean.getBookname()%></td>
				          <td id="<%="price" + bookBean.getId() %>"><%=df.format(bookBean.getPrice()) %></td> 
				          <td>
				              <div class="checkbox">
      						  <label>
      						  		<input type="checkbox" value="<%=bookBean.getId() %>" id="bookcheckbox<%=bookCount %>">
      						  </label>
   							  </div>
				          </td>
				        </tr>
				<%
						}
				%>
					</tbody>
				</table>
				<div class="pull-right">
					<a class="btn btn-default" href="#" role="button" onclick="bookStatistic()">Result</a><br/>
				</div>
            </div>
        </div>
    </div>
    
    <div class="content" id="tab3">
        <div class="container-fluid">
            <div id="pad-wrapper">
            	<table class="table table-hover text-center">
					<thead>
				        <tr>
				          <th>category</th>
				          <th>
				          	  <div class="checkbox">
      						  <label>
      						  		<input type="checkbox">
      						  </label>
   							  </div>
				          </th>
				        </tr>
				      </thead>
				      <tbody>
				<%	
						ArrayList<String> categoryList = bookinfoDao.getAllCategory();
						int categoryCount = 0;
						for (Iterator<String> it = categoryList.iterator(); it.hasNext();) {
							String category = (String)it.next();
							categoryCount++;
				%>
				        <tr>
				          <th><%=category%></th>
				          <td>
				              <div class="checkbox">
      						  <label>
      						  		<input type="checkbox" value="<%=category %>" id="categorycheckbox<%=categoryCount %>">
      						  </label>
   							  </div>
				          </td>
				        </tr>
				<%
						}
				%>
					</tbody>
				</table>
				<div class="pull-right">
					<a class="btn btn-default" href="#" role="button" onclick="categoryStatistic()">Result</a><br/>
				</div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="selectTime" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Please Select Date</h4>
      			</div>
      			<div class="modal-body">
      				<!--date picker   -->
					<div class="container">
					    <form action="" class="form-horizontal"  role="form">
					        <fieldset>
								<div class="form-group">
					                <label for="dtp_input1" class="col-md-1 control-label">Start</label>
					                <div class="input-group date form_date col-md-4" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input1" data-link-format="yyyy-mm-dd">
					                    <input class="form-control" size="16" type="text" value="" readonly>
					                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
					                </div>
									<input type="hidden" id="dtp_input1" value="" /><br/>
					            </div>
					        </fieldset>
					    </form>
					    <form action="" class="form-horizontal"  role="form">
					        <fieldset>
								<div class="form-group">
					                <label for="dtp_input2" class="col-md-1 control-label">Finish</label>
					                <div class="input-group date form_date col-md-4" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
					                    <input class="form-control" size="16" type="text" value="" readonly>
					                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
					                </div>
									<input type="hidden" id="dtp_input2" value="" /><br/>
					            </div>
					        </fieldset>
					    </form>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal" onclick="" >Close</button>
        			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirm()" >Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>
    <!-- end main container -->


	<!-- scripts for this page -->
    <script src="js/jquery-latest.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
    <!-- knob -->
    <script src="js/jquery.knob.js"></script>
    <!-- flot charts -->
    <script src="js/jquery.flot.js"></script>
    <script src="js/jquery.flot.stack.js"></script>
    <script src="js/jquery.flot.resize.js"></script>
    <!-- morrisjs -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="js/morris.min.js"></script>
    <!-- call all plugins -->
    <script src="js/theme.js"></script>

    <script type="text/javascript" src="js/timer/jquery-1.8.3.min.js" charset="UTF-8"></script>
	<script type="text/javascript" src="js/timer/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/timer/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script type="text/javascript" src="js/timer/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
    <script type="text/javascript">

        
        $(".logout").on("click",function(e){
			var tempForm = document.createElement("form");
			tempForm.method = "POST";
			tempForm.action = "<%=basePath%>logout.action";
			tempForm.submit();
		});
        
        
        var lastTab = "#tab1";
		$("#tab1").show();
		$("#tab2").hide();
		$("#pointer2").hide();
		$("#pointer3").hide();
		$(".nav_choice").on("click", function(e){
        	$(lastTab).hide();
			$("#" + "tab" + this.id).show();
			lastTab = "#" + "tab" + this.id;
			$(".active > a > div").hide();
			$(".active").removeClass("active");
			
			$(this).addClass("active"); 
			$(this).find("a").find("div").show();
        });
		
		var ids = [];
		
		function userStatistic(){
			var num = 0
			ids = [];
			$("#selectTime").modal("show");

			for (var i=1; i<= <%=userCount%>; i++){
				if (document.getElementById("usercheckbox"+i.toString()).checked){
					id = $("#usercheckbox"+i.toString()).attr("value");
					ids.push(id);
					num = num + 1;
				}
			}		
		}
			
		function bookStatistic(){
			var num = 0
			ids = [];
			$("#selectTime").modal("show");

			for (var i=1; i<= <%=userCount%>; i++){
				if (document.getElementById("bookcheckbox"+i.toString()).checked){
					id = $("#bookcheckbox"+i.toString()).attr("value");
					ids.push(id);
					num = num + 1;
				}
			}		
		}
		
		function categoryStatistic(){
			var num = 0
			ids = [];
			$("#selectTime").modal("show");

			for (var i=1; i<= <%=categoryCount%>; i++){
				if (document.getElementById("categorycheckbox"+i.toString()).checked){
					id = $("#categorycheckbox"+i.toString()).attr("value");
					ids.push(id);
					num = num + 1;
				}
			}		
		}
	
		$('.form_date').datetimepicker({
	        language:  'en',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
		var start = null;
		var finish = null;
		
		function confirm(){
			start = document.getElementById("dtp_input1").value;
        	finish = document.getElementById("dtp_input2").value;
        	if (start == "" || finish == ""){
        		alert("请输入日期");
        		return;
        	}
        	if (start > finish){
        		alert("开始日期大于结束日期");
        		return;
        	}
			
			var id = $(".active").attr("id");
			if (id == "1"){
				var params = $.param({'ids':ids, 'start':start, 'finish':finish},true);
				var url = "<%=basePath%>StatisticUser.action";
				$.ajax({
			        url : url,
			        data: params,
			        cache : false, 
			        async : false,
			        type : "POST",
			        dataType : 'json',
			        success : function (result){
			        	
			        }
	    		});
 				window.location.href = '<%=basePath%>StatResOfUser.jsp';
			}
			if (id == "2"){
				var params = $.param({'ids':ids, 'start':start, 'finish':finish},true);
				var url = "<%=basePath%>StatisticBook.action";
				$.ajax({
			        url : url,
			        data: params,
			        cache : false, 
			        async : false,
			        type : "POST",
			        dataType : 'json',
			        success : function (result){
			        	
			        }
	    		});
 				window.location.href = '<%=basePath%>StatResOfBook.jsp';
			}
			if (id == "3"){
				var params = $.param({'ids':ids, 'start':start, 'finish':finish},true);
				var url = "<%=basePath%>StatisticCategory.action";
				$.ajax({
			        url : url,
			        data: params,
			        cache : false, 
			        async : false,
			        type : "POST",
			        dataType : 'json',
			        success : function (result){
			        	
			        }
	    		});
 				window.location.href = '<%=basePath%>StatResOfCategory.jsp';
				
			}
		}
    </script>
	</body>
</html>