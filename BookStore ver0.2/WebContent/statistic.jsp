<%@ page language="java" import="java.util.*, dao.SearchOrderDao" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        <title>Manage View!</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    	<link href="css/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />
        
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>


    <!-- navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="/BookStore/manageView.jsp">Book Store Manage</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a>Welcome, <%=session.getAttribute("username") %><span class=""></a></li>
                    <li><a href="#" class="logout">Logout</a></li>
                    <% if (session.getAttribute("admin") != null){ %>
                    <li><a href="/BookStore/bookList.jsp" style="color:yellow">Customer Page</a></li>
                    <%} %>
                </ul>
            </div>
        </div>
    </nav>
    <!-- end navbar -->
<body>

	<%
    	if(session.getAttribute("admin") == null){
    			String site = new String("/BookStore/bookList.jsp");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);     	
    	}
    %>
    
    	
	<div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li>                
                <a href="index.jsp">
                    <span>Home</span>
                </a>
            </li>            
            <li class="active">
                <a href="#">
                    <div class="pointer">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <span>Charts</span>
                </a>
            </li>
            
    </div>
	<!-- main container -->
    <div class="content">
        <div class="container-fluid">
            <div id="pad-wrapper">


                <!-- morris graph chart -->
                <div class="row-fluid section">
                    <h4 class="title">图书销售统计</h4>
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
                        图书分类消费统计
                    </h4>
                    <div class="span6 chart">
                        <h5>统计结果</h5>
                        <div id="hero-bar" style="height: 250px;"></div>
                    </div>
                    <div class="span5 chart">
                        <h4>用户消费</h4>
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
		SearchOrderDao searchOrderDao = new SearchOrderDao();
		List data = searchOrderDao.searchOrderByCategory();
	%>

    <!-- build the charts -->
    <script type="text/javascript">

        // Morris Bar Chart
        Morris.Bar({
            element: 'hero-bar',
            data: [
            <%
            java.text.DecimalFormat df = new java.text.DecimalFormat("#.00"); 
            for(Object object : data)
	         {
	            Map row = (Map)object;
	            String category = (String)row.get("category");
	            double cost = (Double)row.get("cost");
            %>
                {device: '<%=category %>', sells: <%=df.format(cost) %>},
           	<%
	         	}
            %>
            ],
            xkey: 'device',
            ykeys: ['sells'],
            labels: ['Sells'],
            barRatio: 0.4,
            xLabelMargin: 10,
            hideHover: 'auto',
            barColors: ["#3d88ba"]
        });


        // Morris Donut Chart
        <%
       		int from0to5b = searchOrderDao.searchOrderByMoney(0, 500);
        	int from5bto1k = searchOrderDao.searchOrderByMoney(500, 1000);
        	int from1kto2k = searchOrderDao.searchOrderByMoney(1000, 2000);
        	int from2kto5k = searchOrderDao.searchOrderByMoney(2000, 5000);
        	int over5k = searchOrderDao.searchOrderByMoney(5000, -1);
        	
        %>
        Morris.Donut({
            element: 'hero-donut',
            data: [
                {label: '0~500$', value: <%=from0to5b%> },
                {label: '500~1000$', value: <%=from5bto1k%> },
                {label: '1000$~2000$', value: <%=from1kto2k%> },
                {label: '2000$~5000$', value: <%=from2kto5k%> },
                {label: '>5000$', value: <%=over5k%> }
            ],
            colors: ["#30a1ec", "#76bdee", "#c4dafe"],
            formatter: function (y) { return y + "人" }
        });


        <%
       		List dataDay = searchOrderDao.searchOrderByDay();
        	List dataMonth = searchOrderDao.searchOrderByMonth();
			List dataYear = searchOrderDao.searchOrderByYear();
			Calendar calendar =Calendar.getInstance();
			int yearLabel = calendar.get(Calendar.YEAR);
			int monthLabel = calendar.get(Calendar.MONTH) + 1;
		%>
		
        // Morris Line Chart
        var tax_dataYear = [
		<%
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
		for(Object object : dataMonth)
		{
		    Map row = (Map)object;
			int month = 0;
			double cost = 0.0;
			if (row.get("month") instanceof Integer){
				month = ((Integer)row.get("month")).intValue();
			    cost = (Double)row.get("cost");
			}
		%>
			{"period": "<%=yearLabel%>-<%=month%>", "sells": <%=df.format(cost)%>},
		<%
		}
		%>
        ];
        
        var tax_dataDay = [
		<%
		for(Object object : dataDay)
		{
		    Map row = (Map)object;
			int day = 0;
			double cost = 0.0;
			if (row.get("day") instanceof Integer){
				day = ((Integer)row.get("day")).intValue();
			    cost = (Double)row.get("cost");
			}
		%>
			{"period": "<%=yearLabel%>-<%=monthLabel%>-<%=day%>", "sells": <%=df.format(cost)%>},
		<%
		}
		%>
        ];   
        Morris.Line({
            element: 'hero-graph',
            data: tax_dataMonth,
            xkey: 'period',
            xLabels: "month",
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
        $(".logout").on("click",function(e){
			var tempForm = document.createElement("form");
			tempForm.method = "POST";
			tempForm.action = "/BookStore/logout.action";
			tempForm.submit();
		});
    </script>
	</body>
</html>