<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js" integrity="sha512-vBmx0N/uQOXznm/Nbkp7h0P1RfLSj0HQrFSzV8m7rOGyj30fYAOKHYvCNez+yM8IrfnW0TCodDEjRqf6fodf/Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
#body1 {
	font-size: 15px !important;
	font-family: 'Noto Sans KR', sans-serif;
}

div[id^=box], img, .last, #imgs, #claim, #secondBox, #imgs>li:nth-of-type(2),
	#sta, #noti, #deli, #claim {
	position: relative;
}
#topBar h5{
	width:100% !important;
}
#imgBox img {
	height: 68px;
}

#imgs {
	list-style-type: none;
	display: flex;
	top: 130px;
	left: -460px;
}

#imgs>li {
	margin-right: 150px;
}

#imgs>li:nth-of-type(2) {
	margin-right: 200px;
	left: -15px;
}

#imgs>li:nth-of-type(3) {
	margin-right: 150px;
	left: -15px;
}

#total {
	position: absolute;
	top: -10px;
	left: 175px;
	width: 1080px;
	margin-left: 20px;
	height: 1100px;
}

img {
	width: 100px;
	height: 100px;
}

#deli, #claim, #sta, #noti, #ques, #accept, #rep {
	border: lightgray 1px solid;
	width: 48.5% !important;
	height: 350px;
	float: left;
	margin: 7px;
}

#ques, #accept, #rep {
	width: 32% !important;
}

#total>div p {
	border-bottom: gray 2px solid;
	padding: 10px 0 10px 20px;
}

#box0 {
	padding: 160px 0 0 70px;
}

#box1, #box2 {
	top: -120px;
}

#box1 {
	left: 305px;
	padding-top: 75px;
}

#box2 {
	left: 85px;
	padding-top: 260px;
}

#box3 {
	top: -170px;
	left: 325px;
}

#box4, #box5, #box6 {
	top: 65px;
	left: 110px;
}

.last {
	left: 120px;
	top: 10px;
}

div[id^=box]>div {
	display: contents;
}

div[id^=box] {
	width: 300px;
}

#deli {
	top: 33px !important;
	margin-left: 10px !important;
}

#claim {
	top: -334px !important;
	margin-left: 550px !important;
	z-index: -1;
}

#notiContent {
	padding: 5px 20px;
}

#sta {
	top: -210px !important;
	margin-left: 10px !important;
}

#noti {
	top: -575px !important;
	margin-left: 550px !important;
}

#ques, #accept {
	position: relative;
	top: -575px !important;
	margin-left: 10px !important;
}

#rep {
	position: relative;
	top: -939px !important;
	margin-left: 730px !important;
}

#secondBox {
	top: -120px;
}
</style>
<%@ include file="/inc/top.jspf"%>
<div id="topBarContainer">
	<div id="topBar">			
		<h5><strong><a href="adminHome">?????? ???</a></strong></h5>			
	</div>  
</div> 
<div id="body1">
	<%@ include file="/inc/leftBar.jspf"%>
	<div id="total">
		<div id="deli">
			<div id="deliTitle">??????/??????</div>
			<br />
			<div id="box0">
				?????? ??????
				<div style="font-weight: bold; color: red">13</div>
				???
			</div>
			<div id="box1">
				<br>
				<ul>
					<c:if test="${ready != null && ready != '' }">
						<li>??????????????? &nbsp;<b style="font-weight: bold; color: blue">${ready }</b> ???</li>
					</c:if>
					<c:if test="${ready == null}">
						<li>??????????????? &nbsp;<b style="font-weight: bold; color: blue">0</b> ???</li>
					</c:if>

					<c:if test="${ing != null && ing != '' }">
						<li>????????? &nbsp;<b style="font-weight: bold; color: blue">${ing}</b> ???</li>
					</c:if>
					<c:if test="${ing == null}">
						<li>????????? &nbsp;<b style="font-weight: bold; color: blue">0</b> ???</li>
					</c:if>

					<c:if test="${deliveryClear != null && deliveryClear != '' }">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: blue">${deliveryClear }</b> ???</li>
					</c:if>
					<c:if test="${deliveryClear == null}">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: blue">0</b> ???</li>
					</c:if>
				</ul>
			</div>


		</div>
		<ul id="imgs">
			<li><img id="odd1" src="<%=request.getContextPath()%>/img/y_new.png" /></li>
			<li><img id="even" src="<%=request.getContextPath()%>/img/y_truck.png" /></li>
			<li><img id="odd2" src="<%=request.getContextPath()%>/img/y_undo.png" /></li>
			<li><img id="evenwon" src="<%=request.getContextPath()%>/img/y_won.png" /><br /></li>
		</ul>
		<div id="claim">
			<div id="claimTitle">?????????/??????</div>
			<br />

			<div id="box2">
				<ul>
					<c:if test="${cancel != null && ing != '' }">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: green">${cancel}</b> ???</li>
					</c:if>
					<c:if test="${cancel == null}">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: green">0</b> ???</li>
					</c:if>

					<c:if test="${refund != null && refund != '' }">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: green">${refund}</b> ???</li>
					</c:if>
					<c:if test="${refund == null}">
						<li>???????????? &nbsp;<b style="font-weight: bold; color: green">0</b> ???</li>
					</c:if>
				</ul>
			</div>

			<div id="box3">
				??????
				<div style="font-weight: bold; color: fuchsia">${realpayment }</div>
				???

			</div>
		</div>
		<div id="secondBox">
			<div id="sta">
				<div id="staTitle">?????? ??????</div>
				<canvas id="myChart" style="width: 90%; height: 80%; margin: 10px auto 0 auto;"></canvas>

				<script> // ?????? ??????, ????????????, ??????, ??????, ?????? ???????????? ????????????
				
					let ctx = document.getElementById("myChart").getContext("2d");
					myChart = new Chart(ctx, {
						type:'bar',
						data:{
							
							labels: ['${resultDate0}','${resultDate1}','${resultDate2}'],
							datasets: [
								{
									label: '????????????',
									yAxisID: 'A',
									data: ['${resultTrend0}','${resultTrend1}','${resultTrend2}'],
									backgroundColor : 'rgba(255, 178, 46,0.6)',
									borderColor : 'rgba(255, 178, 46,1)',
									fill: false,
									order:2,
								},
								{
									type: "line",
									label: '????????? ??????',
									yAxisID: 'B',
									data: [${resultSeller0},${resultSeller1},${resultSeller2}],
									borderColor : 'rgba(255, 70, 46,1)',
									fill: false,
									order:1,
								},
								{
									type: "line",
									label: '?????? ??????',
									yAxisID: 'B',
									data: [${resultAdminSales0},${resultAdminSales1},${resultAdminSales2}],
									borderColor : '#29b6f6',
									fill: false,
									order:1,
								}
							] // ????????? ???????????? ???????????? ???????????? ?????????
						},
						options: {
							
							responsive: false,
							tooltips: { 
						           mode: 'label', 
						           label: 'mylabel', 
						           callbacks: { 
						               label: function(tooltipItem, data) { 
						                   return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); }, }, 
						        }, 
						   /*      scaleLabel:
						            function(label){return  '$' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}, */
							scales:{
							      yAxes: [{
							          id: 'A',
							          type: 'linear',
							          position: 'right',
							          ticks: {
							              fontColor: '#ffbaa2',
							              userCallback(value, index, values) {
							                  // return nf.format(value)
							                  return value.toLocaleString()
							          		}
								      	
							          },
							          gridLines: {
					                        color: "rgba(0, 0, 0, 0)",
					                  }, 
					                  beginAtZero:true
						           
							      		
							        }, {
							        
							          id: 'B',
							          type: 'linear',
							          position: 'left',
							          ticks: {
						          	    fontColor: 'black',
						          	  	userCallback(value, index, values) {
						                    // return nf.format(value)
						                    return value.toLocaleString()
					                  	
						          	    }
					                  	
							          },
							          beginAtZero:true
							        
							        }]
							}
							
						}
					});
					
				</script>
			</div>
			<div id="noti">
				<div id="notiTitle">????????????</div>
				<br />
				<div id="notiContent">
					<ul>
						<c:if test="${notice !=null }">
							<c:forEach var="data" items="${notice }">
								<li style="display: flex; justify-content: space-between; padding:5px 10px 12px 10px;border-bottom: 1px solid #eee;">
								<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width:400px;">${data.infotitle}</div>
									<div>${data.infowritedate }</div></li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
			<div id="ques">
				<div id="quesTitle">????????? ??????/??????</div>
				<br /> <img class="last" src="<%=request.getContextPath()%>/img/y_question.png" />
				<div id="box4">
					????????? ??????
					<div style="font-weight: bold; color: red">${question }</div>
					???
				</div>
			</div>
			<div id="accept">
				<div id="acceptTitle">????????? ?????? ??????</div>
				<br /> <img class="last" src="<%=request.getContextPath()%>/img/y_accepta.png" />
				<div id="box5">
					?????? ?????? ??????
					<div style="font-weight: bold; color: blue">${approve }</div>
					???<br /> ????????? ??????
					<div style="font-weight: bold; color: blue">${clear }</div>
					???
				</div>
			</div>
			<div id="rep">
				<div id="repTitle">????????????</div>
				<br /> <img class="last" src="<%=request.getContextPath()%>/img/y_reporta.png" />
				<div id="box6">
					?????? ??????
					<div style="font-weight: bold; color: green">${report }</div>
					???<br /> ????????? ??????
					<div style="font-weight: bold; color: green">${waiting }</div>
					???
				</div>
			</div>
		</div>
	</div>
</div>
</html>
