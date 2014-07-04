<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Twitter Visualizer</title>
<!-- Bootstrap -->
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/sticky-footer-navbar.css" rel="stylesheet">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- canvasjs -->
	<script type="text/javascript" src="resources/js/canvasjs.min.js"></script>
</head>
<body>
<script type="text/javascript">
var entries = 0;
var smiley = ["<img src='resources/img/smiley-face-sad.gif' alt='Pivotal'>",
              "<img src='resources/img/smiley-face-sad.gif' alt='Pivotal'>",
              "<img src='resources/img/smiley-face-mellow.gif' alt='Pivotal'>",
              "<img src='resources/img/smiley-face-smile.gif' alt='Pivotal'>",
              "<img src='resources/img/smiley-face-smile.gif' alt='Pivotal'>"];
//// Chart
		var dpsLine = []; // dataPoints
		var dpsColumn = [
			    	        { x: 10, y: 0, label: "Very Negative"},
			    	        { x: 20, y: 0,  label: "Negative" },
			    	        { x: 30, y: 0,  label: "Neutral"},
			    	        { x: 40, y: 0,  label: "Positive"},
			    	        { x: 50, y: 0,  label: "Very Positive"}
			    	        ];
		var lineChart;
		var columnChart;
		
		var dataLength = 100; // number of dataPoints visible at any point

		var updateLineChart = function (xVal,yVal,tweet) 
		{
			dpsLine.push({x: xVal, y: yVal, toolTipContent:tweet});
			if (dpsLine.length > dataLength)
			{
				dpsLine.shift();				
			}
			
			lineChart.render();		

		}

		var initLineChart = function () {


		lineChart = new CanvasJS.Chart("lineChartContainer",{
			title :{
				text: "Live Tweet Sentiment"
			},			
			data: [{
				type: "line",
				dataPoints: dpsLine 
			}]
		});
		
		updateLineChart();
	}
 
		var updateColumnChart = function(sentiment) 
		{			
			if(sentiment === 0)
			{
				dpsColumn.splice(0,1, { x: 10, y: dpsColumn[sentiment].y+1, label: "Very Negative"});				
			}
			else if(sentiment === 1)
			{
				dpsColumn.splice(1,1, { x: 20, y: dpsColumn[sentiment].y+1,  label: "Negative" });
			}
			else if(sentiment === 2)
			{
				dpsColumn.splice(2,1, { x: 30, y: dpsColumn[sentiment].y+1,  label: "Neutral"});
			}
			else if(sentiment === 3)
			{
				dpsColumn.splice(3,1, { x: 40, y: dpsColumn[sentiment].y+1,  label: "Positive"});
			}
			else if(sentiment === 4)
			{
				dpsColumn.splice(4,1, { x: 50, y: dpsColumn[sentiment].y+1,  label: "Very Positive"});
			}
			
			columnChart.render();		
		}

	var initColumnChart = function ()
	{
		    columnChart = new CanvasJS.Chart("columnChartContainer",
		    	    {
		    	      title:{
		    	        text: "Tweet Sentiment Summary"
		    	      },
		    	      data: [{
		    	        dataPoints: dpsColumn
		    	      }]
		    	    });
		    	    columnChart.render();
	}
//// Chart

function killApp(){
	$.get("killApp", function(data){
		$( "#content-wrapper" ).text( data ).show().fadeOut( 3000 );
    });       
}                       
	
function getTweet(){
	$.get("getTweet",{key: entries}, function(data) {
		if(data!="")
			{
				console.log(data);
				$('#data'+entries).html("<td>"+smiley[data.sentiment]+"</td><td>"+data.createdAt+"</td><td>"+data.tweet+"</td>");
				$('#tweet_tab').prepend('<tr id="data'+(entries+1)+'"></tr>');
				entries++;
				  	console.log(entries);
				  	console.log(data.sentiment);
					updateLineChart(entries, data.sentiment, data.tweet);
					updateColumnChart(data.sentiment);
			}
		});
		setTimeout(getTweet, 1000);
	}
	$(document).ready(
			function() {
				console.log("document ready");
				initLineChart();
				initColumnChart();
				getTweet();
			});
</script>

    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="">Tweet Visualizer</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a onclick="killApp();" href="">Kill Application</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <!-- Begin page content -->
<div id="maincontent" class="container">
		<div align="center"> 
        <small>Instance hosted at &nbsp;<%=request.getLocalAddr() %>:<%=request.getLocalPort() %></small><br>
		<br>
		</div>

<!-- chart -->
	<div id="lineChartContainer" style="height: 300px; width:50%;float:left;">
	</div>
	<div id="columnChartContainer" style="height: 300px; width: 50%;float:right;">
	</div>
	
<!-- chart -->
  <div>
    <table id="tweet_tab" class="table">
      <thead>
        <tr>
          <th>Sentiment</th>
          <th>Timestamp</th>
          <th>Tweet</th>
        </tr>
      </thead>
      <tbody>
        <tr id='data0'></td>
      </tbody>
    </table>
  </div>    
</div>

    <div id="footer">
      <div class="container">
        <img src='resources/img/PoweredByPivotal.png' alt='Pivotal'>
      </div>
    </div>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
 <!--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script> -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="resources/js/bootstrap.min.js"></script>
</body>
</html>

