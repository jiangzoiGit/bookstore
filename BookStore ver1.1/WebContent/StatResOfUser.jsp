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

        <title>Statistic Result</title>

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

        
        <script src="js/ie-emulation-modes-warning.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

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
                    <span>Result</span>
                </a>
            </li>            
            <li class="nav_choice" id="2">
                <a href="<%=basePath %>statistic.jsp">
                    <div class="pointer" id="pointer2">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <span>Back</span>
                </a>
            </li>            
    </div>
	<!-- main container -->
	<!-- By User -->
    <div class="content" id="tab1">
        <div class="container-fluid">
            <div id="pad-wrapper">
            	<!-- morris graph chart -->
                <div class="row-fluid section">
                    <h4 class="title">User Consumption By Time</h4>
                    <div class="span12 chart">                        
                        <div id="hero-graph" style="height: 230px;"></div>
                    </div>
                </div>
                
        		<div class="btn-group pull-right">
                    <button class="glow left Day" >DAY</button>
                    <button class="glow middle Month">MONTH</button>
                    <button class="glow right Year">YEAR</button>
                </div>
            	
            
            
				<!-- morris bar & donut charts -->
                <div class="row-fluid section">
                    <h4 class="title">
                        Statistic Of User
                    </h4>
                    <div class="span12 chart">
                        <h4>Bar Chart</h4>
                        <div id="hero-bar" style="height: 250px;"></div>
                    </div>
                    
                </div>
                
                <div class="row-fluid section">
                    <h4 class="title">
                        Statistic Of User
                    </h4>
                	<div class="span6 chart">
                        <h4>Donut Chart</h4>
                        <div id="hero-donut" style="height: 250px;"></div>    
                    </div>
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


	<%
		Map<String, Double> data = (Map<String, Double>) session.getAttribute("data");
		
	%>

    <!-- build the charts -->
    <script type="text/javascript">
	   

        // Morris Bar Chart
        Morris.Bar({
            element: 'hero-bar',
            data: [
            <%
            java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
            if (data != null){
            for(String name : data.keySet())
	        {
				double cost = data.get(name).doubleValue();
            %>
                {name: '<%=name %>', cost: <%=df.format(cost) %>},
           	<%
	        }
            }
            %>
            ],
            xkey: 'name',
            ykeys: ['cost'],
            labels: ['Cost'],
            barRatio: 0.4,
            xLabelMargin: 10,
            hideHover: 'auto',
            barColors: ["#3d88ba"]
        });


        // Morris Donut Chart
        Morris.Donut({
            element: 'hero-donut',
            data: [
            <%
            if (data != null){
            for(String name : data.keySet())
	        {
				double cost = data.get(name).doubleValue();
            %>
                {label: '<%=name%>', value: <%=df.format(cost)%> },
            <%
	        }
            }
            %>
            ],
            colors: ["#30a1ec", "#76bdee", "#c4dafe"],
            formatter: function (y) { return y + "$" }
        });

        $(".logout").on("click",function(e){
			var tempForm = document.createElement("form");
			tempForm.method = "POST";
			tempForm.action = "<%=basePath%>logout.action";
			tempForm.submit();
		});
        
     // Morris Line Chart
        var tax_dataYear = [
		<%
		List dataYear = (List) session.getAttribute("dataYear");
		for(Object object : dataYear)
		{
		    Map row = (Map)object;
			int year = 0;
			double cost = 0.0;
			if (row.get("year") instanceof Integer){
				year = ((Integer)row.get("year")).intValue();
			    cost = (Double)row.get("cost");
			}
		%>
        	{"period": "<%=year%>", "sells": <%=df.format(cost)%>},
        <%
		}
        %>
        ];
        
        
        var tax_dataMonth = [
		<%
		List dataMonth = (List) session.getAttribute("dataMonth");
		for(Object object : dataMonth)
		{
		    Map row = (Map)object;
			int month = 0;
			int year = 0;
			double cost = 0.0;
			if (row.get("month") instanceof Integer){
				year = ((Integer)row.get("year")).intValue();
				month = ((Integer)row.get("month")).intValue();
			    cost = (Double)row.get("cost");
			}
		%>
			{"period": "<%=year%>-<%=month%>", "sells": <%=df.format(cost)%>},
		<%
		}
		%>
        ];
        
        var tax_dataDay = [
		<%
		List dataDay = (List) session.getAttribute("dataDay");
		for(Object object : dataDay)
		{
		    Map row = (Map)object;
			int day = 0;
			int month = 0;
			int year = 0;
			double cost = 0.0;
			if (row.get("day") instanceof Integer){
				year = ((Integer)row.get("year")).intValue();
				month = ((Integer)row.get("month")).intValue();
				day = ((Integer)row.get("day")).intValue();
			    cost = (Double)row.get("cost");
			}
		%>
			{"period": "<%=year%>-<%=month%>-<%=day%>", "sells": <%=df.format(cost)%>},
		<%
		}
		%>
        ];   
        Morris.Line({
            element: 'hero-graph',
            data: tax_dataDay,
            xkey: 'period',
            xLabels: "day",
            ykeys: ['sells'],
            labels: ['Sells']
        });
        
        $(".Day").on("click",function(e){
        	$("#hero-graph").html("");
        	Morris.Line({
                element: 'hero-graph',
                data: tax_dataDay,
                xkey: 'period',
                xLabels: "day",
                ykeys: ['sells'],
                labels: ['Sells']
            });
        });
        
        $(".Month").on("click",function(e){
        	$("#hero-graph").html("");
        	Morris.Line({
                element: 'hero-graph',
                data: tax_dataMonth,
                xkey: 'period',
                xLabels: "month",
                ykeys: ['sells'],
                labels: ['Sells']
            });
        });
        
        $(".Year").on("click",function(e){
        	$("#hero-graph").html("");
        	Morris.Line({
                element: 'hero-graph',
                data: tax_dataYear,
                xkey: 'period',
                xLabels: "year",
                ykeys: ['sells'],
                labels: ['Sells']
            });
        });

        function showTooltip(x, y, contents) {
            $('<div id="tooltip">' + contents + '</div>').css( {
                position: 'absolute',
                display: 'none',
                top: y - 30,
                left: x - 50,
                color: "#fff",
                padding: '2px 5px',
                'border-radius': '6px',
                'background-color': '#000',
                opacity: 0.80
            }).appendTo("body").fadeIn(200);
        }

        var previousPoint = null;
        $("#statsChart").bind("plothover", function (event, pos, item) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;

                    $("#tooltip").remove();
                    var x = item.datapoint[0].toFixed(0),
                        y = item.datapoint[1].toFixed(0);

                    var month = item.series.xaxis.ticks[item.dataIndex].label;

                    showTooltip(item.pageX, item.pageY,
                                item.series.label + " of " + month + ": " + y);
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        });
     
        
        
    </script>
	</body>
</html>