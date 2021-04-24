<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/xstyle_sellerSales.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.1.0/dist/chart.min.js"></script>
<!-- 오늘의 날짜를 계산해서 오늘 기준으로 년도, 월, 일이 언제인지를 기준으로 값이 입력 될 수 있도록 한다. -->
<c:set var='today' value="<%=new java.util.Date() %>"/>
<c:set var='monthPtn'><fmt:formatDate value="${today }" pattern="yyyy-MM"/></c:set>
<c:set var='datePtn'><fmt:formatDate value="${today }" pattern="yyyy-MM-dd"/></c:set>
<c:set var='yearCheck'><fmt:formatDate value="${today }" pattern="yyyy"/></c:set>

<script> // 차트와 엑셀에 데이터가 들어가는데 필요한 기능에게 변화되는 도움만 주고 관여는 하지 않는 기능들 모아놓은 스크립트

	// 날짜 변경 yearCheck하는 변수 선언
	let yearCheck="";
	
	// 날짜를 년별, 월별, 일별을 바꿀 경우 그 조건에 맞게 input 박스를 change 한다.
	function typeChange(e){
		let optionCheck = $(e).val();
		
		if(optionCheck=="년별"){
			// 년별 넣을때 스타트와 엔드를 드롭박스로 만든다.
			// start date
			let start = "<select id='categoryCalendar_start'>";
				for(let i=2018; i<=${yearCheck};i++){
					start += "<option>"+i+"</option>";
				}
				start += "</select>";
			
			// end date
			let end = "<select id='categoryCalendar_end'>";
				for(let i=2018; i<=${yearCheck};i++){
					//마지막 년도는 selected 하도록 한다.
					if(i==${yearCheck}){
						end += "<option selected>"+i+"</option>";
					} else {
						end += "<option>"+i+"</option>";
					}
				}
				end += "</select>";	
				
			// tag를 변수를 넣어서 치환한다.
			$("#categoryCalendar_start").replaceWith(start);
			$("#categoryCalendar_end").replaceWith(end).attr('selected',${yearCheck});
			yearCheck="년별";
		}else if(optionCheck=="월별"){
			// 년별을 눌렀었을 경우에는 태그가 변경 되었기 때문에 다시 치환해줘야 한다.
			if(yearCheck=="년별"){
				console.log("test");
				let start = "<input class='categorySearch_container_child' ";
					start+= " type='month' min='2018-01' max='${monthPtn }' id='categoryCalendar_start'/>";
					
				let end = "<input class='categorySearch_container_child' ";
					end+= " type='month' min='2018-01' max='${monthPtn }' id='categoryCalendar_end'/>";
				
				$("#categoryCalendar_start").replaceWith(start);
				$("#categoryCalendar_end").replaceWith(end);
						
			} else{ // 년별 선택이 아니었을 경우 원래대로 넣는다.
				$("#categoryCalendar_start").attr('type','month').attr('max','${monthPtn}');
				$("#categoryCalendar_end").attr('type','month').attr('max','${monthPtn}');
			}
			yearCheck="";
		}else if(optionCheck=="일별"){
			// 년별을 눌렀었을 경우에는 태그가 변경 되었기 때문에 다시 치환해줘야 한다.
			if(yearCheck=="년별"){
				let start = "<input class='categorySearch_container_child' ";
					start+= " type='date' min='2018-01-01' max='${datePtn }' id='categoryCalendar_start'/>";
					
				let end = "<input class='categorySearch_container_child' ";
					end+= " type='date' min='2018-01-01' max='${datePtn }' id='categoryCalendar_end'/>";
				
				$("#categoryCalendar_start").replaceWith(start);
				$("#categoryCalendar_end").replaceWith(end);
						
			} else{// 년별 선택이 아니었을 경우 원래대로 넣는다.
				$("#categoryCalendar_start").attr('type','date').attr('max',"${datePtn}");
				$("#categoryCalendar_end").attr('type','date').attr('max',"${datePtn}");
			}
			yearCheck="";
		}
		
	}
	
	
	// 대분류 카테고리 클릭시 : 데이터 베이스로 불러왔던 중분류 카테고리를 선택된 대분류 카테고리 종류에 따라 값을 불러와 li로 넣는 기능
	$(()=>{
		$(document).on('click',"#category>li",function(){
			// 선택된 카테고리 넘버를 변수에 넣어둔다.
			let cateNum = $(this).val();
			// 태그를 이용해 선택된 카테고리의 중분류 카테고리를 담는 변수를 생성한다.
			let tag ="";
			
			// 카테고리 리스트가 널이 아닐경우
			<c:if test="${cateList!=null }">
				//  카테고리 넘버가 무엇인지에 따라서 불러온다, 카테고리 넘버가 1이면 중분류 카테고리 1번의 값들을 불러온다.
				<c:forEach var="mcateList" items="${cateList}">
					if(${mcateList.catenum}==cateNum){
						tag += "<li value='${mcateList.catename}'>"
								+"<input type='hidden' name='mcatenum' value='${mcateList.mcatenum}'/>"
								+"${mcateList.mcatename}</li>";
					}
				</c:forEach>
				$('#mcategory').html(tag);
			</c:if>

		});
		
	})
</script>
<section>
	<!-- 사이드바 -->
	<nav>
		<ul>
			<li><a href="#">상품 관리</a></li>
			<li><a href="#">상품 등록</a></li>
			<li><a href="#">주문 관리</a></li>
			<li><a href="#">판매 관리</a></li>
			<li><a href="seller_sales">매출 관리</a></li>
			<li><a href="#">정산 관리</a></li>
			<li><a href="#">배송 관리</a></li>
			<li><a href="seller_review">리뷰/문의 관리</a></li>
			<li><a href="intro_farm">회원정보수정</a></li>
		</ul>
	</nav>
	<!-- 본문 시작 -->
	<article>
		<!-- 검색창 -->
		<div id="search_container">
			<span id="search_box">
				<input type="text" id="search" name="search" placeholder="검색하기"><a href="#" onclick="return false;"><img id="search_icon" src="<%=request.getContextPath()%>/resources/img/xsearch_icon.png"/></a>
			</span>
		</div>
		
		
		<div class="wrap">
			<!-- 카테고리 선택 -->
			<div class="wrapContainer">
				<div class="wrapTitle">카테고리</div>
				<div id="categoryList">
					<strong>&nbsp;&nbsp;카테고리</strong>
					
					<div id="categoryListMiddle">
						<!-- 대분류 카테고리!!!! -->
						<ul id="category"><!-- 카테고리 리스트에서 대분류 카테고리만 받아오기 -->
							<c:if test="${cateList!=null}">
								<!-- 변수 i를 선언해주고 -->
								<c:set var="i" value="1"/>
								<!-- 변수 i 즉, catenum이 i와 일치하는 데이터 하나를 가지고 오면 
											i를 더해주어 다음 조건을 만들어 다음 번호 것만 가져오게 한다 -->
									<c:forEach var="categoryList" items="${cateList}">
										<c:if test="${categoryList.catenum==i}">
											<li value="${categoryList.catenum}">${categoryList.catename}<span>&gt;</span></li>
											<c:set var="i" value="${i+1 }"/>
										</c:if>
									</c:forEach>
								<c:remove var="i"/>
							</c:if>
						</ul>
						
						<!-- 중분류 카테고리!!!!! -->
						<ul id="mcategory">
						</ul>
					</div>
					
					<!-- 중분류 카테고리 선택하면 선택된 사항이 들어가는 공간이다!!!! -->
					<ul id="categoryManagement"></ul>
					
					<div id="categorySearch_container">
						<select class="categorySearch_container_child" id="categoryDate" name="categoryDate" onchange="typeChange(this)">
							<option value="년별">년별</option>
							<option value="월별" selected>월별</option>
							<option value="일별">일별</option>
						</select>
						<input class="categorySearch_container_child" type="month" min="2018-01" max="${monthPtn }" id="categoryCalendar_start"/>
						<input class="categorySearch_container_child" type="month" min="2018-01" max="${monthPtn }" id="categoryCalendar_end"/>
						<button id="calendarApply">날짜 적용</button>
					</div>
					
				</div><!-- categoryList 끝 -->
			</div><!-- 카테고리 선택 끝 -->
			
			<!-- 수익 매출 분석 -->
			<div class="wrapContainer">
				<div class="wrapTitle">수익 매출분석</div>
				<div id="chartContainer">
					<canvas id="myChart" style="width:400px;height:200px;"></canvas>
					
					<script> // 차트 선언, 카테고리, 날짜, 차트, 엑셀 관여하는 스크립트
					
					let ctx = document.getElementById("myChart").getContext("2d");
					let myChart = new Chart(ctx, {
						type: 'line',
						data:{
							labels: [
								'January',
							    'February',
							    'March',
							    'April','April'
							],
							datasets: [{
								label: '채소',
								data: [10000, 25302, 12347, 73946],
								borderColor: 'rgb(255, 99, 132)',
							},{
								label: '가지',
								data: [29477, 83924, 39463, 80736],
								borderColor: 'rgb(54, 162, 235)',
							}]
						},
						options: {
							scales:{
								y:{
									beginAtZero: true
								}
								
							}
						}
					});
					
					//////////////////////////////// 전역변수 선언 /////////////////////////////////
					// 선택된 날짜의 데이터를 저장해 높는 변수
					let startCalendarDataValue = "";
					let endCalendarDataValue = "";
					
					// 존재하는 품목이 없는것으로 확인되었을 경우 resultData[] 배열에 넣어서 데이터 산출 하는데 사용되어야 한다.
					let resultData = new Array();
					
					
					
					/////////////////////////////// 공통 분모로 사용 가능한 함수 /////////////////////////////
					//차트 추가하기
					function addData(chart, data) {
					    chart.data.datasets.push(data);
					    chart.update();
					}

					//차트 삭제하기
					function removeData(chart,delData) {
					    chart.data.datasets.splice(delData,1);
					    chart.update();
					}
					
					// 선택한 날짜가 시작일이 종료일보다 뒤일 경우 경고창
					function dateGapCheck(){
						
					}
					
					
					
					//////////////////// 수익 매출분석에 들어갈 labels 시작 /////////////////////
					// 날짜 적용 버튼 클릭시,, labels 추가
					$('#calendarApply').click(function(){
						// 월별 일별에 사용될 스플릿 값 저장할 전역변수 생성!
						let startSplit = null;
						let endSplit = null;

						// 차이값에 대한 계산 결과를 저장하는데 사용할 전역변수 생성!
						let gapResult = 0;
						
						// startDate, endDate 선택된 값을 가져온다.
						let startDateCheck = $('#categoryCalendar_start').val();
						let endDateCheck = $('#categoryCalendar_end').val();
						
						
						
						
						//=======================제한사항 걸러내기 3가지 ===========================//
						// 날짜 시작, 종료를 입력하지 않을 경우 걸러낸다.
						if(startDateCheck == '' ||endDateCheck == ''){
							alert('검색할 시작 날짜와 종료 날짜를 반드시 선택해야 합니다.');
							return false;
						}
						
						// 날짜 시작, 종료의 기준일을 반대로 누르는 사람 있으면 걸러야 한다..
						if(startDateCheck > endDateCheck){
							alert('검색 시작 날짜를 종료 날짜보다 미래로 지정 할 수 없습니다.');
							return false;
						}
						
						// 최대 선택 가능 날짜의 차이는 6개월 이다. 일수로 치면 180일 이고,
						// 년도 기준과 6개월 이상, 180일 이상은 차트만 기입되고 엑셀이 기입되지 않도록 한다.
						// 왜냐? 데이터가 너무 많아질 경우 오히려 서비스 저하가 발생 할 수 있기 때문이다.
						
						//========================제한사항 걸러내기 끝 ===============================//
						
						
						
						
						
						// 년도, 월별, 일별 어떤 조건인지 확인하고 이동한다.!!!
						let dateCheck = $('#categoryDate>option:selected').val();
						
						
						if(dateCheck != "년별"){ // 년별이 아닐경우 스플릿 전역변수를 스플릿 해준다!
							// 날짜 - 표시 스플릿해서 없애기
							startSplit = startDateCheck.split("-");
							endSplit = endDateCheck.split("-");
						}
						
						// 차트에 새로운 값 업데이트 하기 전에 모두 지운다.
						// 지우는건 제한사항으로 걸러 낸 다음에 한다.
						let labelsLength = parseInt(Object.keys(myChart.data.labels).length);
						myChart.data.labels.splice(0,labelsLength);
						myChart.update();
						
						/* 생각하자..................
						1. 년도, 월, 일 을 기준으로 endDate와 startDate의 차이를 비교해서 
							년 차이가 있을 경우는 2가지다 ( 같은 년도가 같을 경우, 시작 년도가 작을경우)
							월은 1월 12월 기준으로 변화된 값에 대한 계산
							일은 해당 월의 일이 언제까지인지 계산해서 차이를 계산해야한다.
						2. 해당 차이 값(날짜)을 구해서 차트 labels에 넣어주어야 한다.
						3. "일". 그러니까 해당 월의 마지막 날을 구하는 것은 lastday가 언제인지 식으로 구해야한다.
						//const startCheck = new Date(startDateCheck);
						//const endCheck = new Date(endDateCheck).getFullYear();
						//const gapCheck = new Date(startSplit[0], startSplit[1], 0).getDate();
					
						*/
						
						
						// 월별, 년별, 일별 그리고 지정한 날짜에 따라 차트에 들어가지는 값이 달라진다.
						if(dateCheck=="월별"){
							// split 해 준 값을 계산하기 위해서 정수로 변환해준다.
							startSplit[0] = parseInt(startSplit[0],10);
							startSplit[1] = parseInt(startSplit[1],10);
							// 마지막 날짜 구하기
							let lastDay = new Date(endSplit[0],endSplit[1],0).getDate();
							
							// 날짜의 차이(년)을 구한다.
							if( startSplit[0] < endSplit[0] ){// 년도 차이가 있다! 
								
								gapResult = endSplit[1] - startSplit[1] +12; // "월" 계산된 값에 + 12를 해준다.
								for(let i = 0; i <= gapResult; i++){ // gapResult 만큼 반복한다.
									// 차트에 넣는다
									myChart.data.labels.push(startSplit[0]+"-"+startSplit[1]);
									
									//////////// 데이터 계산을 위해 저장해 놓아야 하는 변수 //////////////
									if(i==0){
										startCalendarDataValue = startSplit[0]+"-"+startSplit[1]+"-"+01;	
										if(gapResult==0){// 만약 같은 날짜를 선택 했을 경우에는 엔드 날짜도 구해줘야 한다.
											endCalendarDataValue =startSplit[0]+"-"+startSplit[1]+"-"+lastDay;
										}
									} else if(i==gapResult){
										endCalendarDataValue =startSplit[0]+"-"+startSplit[1]+"-"+lastDay;
									}
																	
									//////////// 12월 기준으로 날짜를 바꿔줘야 한다 /////////////
									if(startSplit[1]!=12){
										startSplit[1] += 1;
									
									} else { //startSplit[1]이 12월이 되면 년도와 월을 바꿔서 대입 해줘야 한다.
										startSplit[0] += 1;
										startSplit[1] = 1;
									
									}
								}
							} else { // 년도 차이가 없다!
								
								gapResult = endSplit[1] - startSplit[1];
								for(let i = 0; i <= gapResult; i++){ // gapResult 만큼 반복한다.
									//////////// 데이터 계산을 위해 저장해 놓아야 하는 변수 //////////////
									if(i==0){
										startCalendarDataValue = startSplit[0]+"-"+startSplit[1]+"-"+01;	
										if(gapResult==0){// 만약 같은 날짜를 선택 했을 경우에는 엔드 날짜도 구해줘야 한다.
											endCalendarDataValue =startSplit[0]+"-"+startSplit[1]+"-"+lastDay;
										}
									} else if(i==gapResult){
										endCalendarDataValue =startSplit[0]+"-"+startSplit[1]+"-"+lastDay;
									}
									
									//차트에 넣는다.
									myChart.data.labels.push(startSplit[0]+"-"+startSplit[1]);
									
									startSplit[1] += 1;
								}
							}
							
							
						} else if(dateCheck=="일별"){
							// split 해 준 값을 계산하기 위해서 정수로 변환해준다.
							startSplit[0] = parseInt(startSplit[0],10);
							startSplit[1] = parseInt(startSplit[1],10);
							startSplit[2] = parseInt(startSplit[2],10);
							
							let startInstance = new Date(startDateCheck).getTime();
							let endInstance = new Date(endDateCheck).getTime();
							
							// 시간으로 바꾼 날짜의 차이를 구한다. 밀리초는 1초를 1000으로 나눈것 + 60초 + 60분 + 24시간을 나누면 1일이 구해진다
							gapResult = (endInstance-startInstance)/1000/60/60/24;
							
							/* 
								일별에 대해 구하기 위해서는
								1. 년도 차이가 있는지 확인
									--> 년도 차이가 있으면 월과 일의 마지막 날에 변화가 되어야 하고
								2. 월 차이가 있는지 확인
									--> 월의 차이가 있을 경우 일의 마지막 날에 변화가 되어야 한다.
								
								------------ 위에것은 취소!
								아래와 같이 date + 1만으로 년, 월 일 변화를 확인 할 수 있다.
							*/
							
							// 날짜를 객체화 한다.
							let dateCheck = new Date(startSplit);
							
							// 차트에 +1을 하며 넣어준다.
							for(let i = 0; i <= gapResult; i++){
								//////////// 데이터 계산을 위해 저장해 놓아야 하는 변수 //////////////
								if(i==0){
									startCalendarDataValue = dateCheck.getFullYear()+"-"+(dateCheck.getMonth()+1)+"-"+dateCheck.getDate();	
									if(gapResult==0){// 만약 같은 날짜를 선택 했을 경우에는 엔드 날짜도 구해줘야 한다.
										endCalendarDataValue = dateCheck.getFullYear()+"-"+(dateCheck.getMonth()+1)+"-"+dateCheck.getDate();
									}
								} else if(i==gapResult){
									endCalendarDataValue = dateCheck.getFullYear()+"-"+(dateCheck.getMonth()+1)+"-"+dateCheck.getDate();
								
								}
								
								//차트에 넣는다
								myChart.data.labels.push(dateCheck.getFullYear()+"-"+(dateCheck.getMonth()+1)+"-"+dateCheck.getDate());
								
								// 날짜 데이터에 +1일을 해준다!
								dateCheck.setDate(dateCheck.getDate()+1);
							}
						} else if(dateCheck=="년별"){
							gapResult = endDateCheck-startDateCheck;
							
							for(let i = 0; i <= gapResult; i++){
								//////////// 데이터 계산을 위해 저장해 놓아야 하는 변수 //////////////
								if(i==0){
									startCalendarDataValue = startDateCheck+"-"+01+"-"+01;	
									if(gapResult==0){// 만약 같은 날짜를 선택 했을 경우에는 엔드 날짜도 구해줘야 한다.
										endCalendarDataValue = startDateCheck+"-"+12+"-"+31;	
									}
								} else if(i==gapResult){
									endCalendarDataValue = startDateCheck+"-"+12+"-"+31;
								
								}
								
								//차트에 넣는다
								myChart.data.labels.push(startDateCheck);
								startDateCheck++;
							}
							
						}
						//myChart에 담긴 것을 업데이트한다.
						myChart.update();
					})
					//////////////////// 수익 매출분석에 들어갈 labels 끝 /////////////////////
					
					
					
					
					
					
					
					///////////////////////////////////////////////////////////////////////// 카테고리, 차트, 엑셀
					$(function(){
						// 중분류 카테고리 선택시 추가하는 기능 categoryManagement
						$(document).on('click', '#mcategory>li', function(){
							/*========================  category에 포함  ==========================*/
							
							// 선택한 목록의 중분류 이름, 번호를 구한다.
							let selectName = $(this).text();
							let selectNum = $(this).children().val();
							
							// li 개수 구하여 10개 이상은 고르지 못하도록 막는다
							let liLength = $('#categoryManagement>li').length;
							if(liLength>=10){
								return alert('최대 10개의 품목만 선택 가능합니다.');
								
							}
							
							
							// li에 존재하는 품목 이름이 있으면 추가하지 못하도록 제한해야 한다.
							for(let i=0; i<liLength; i++){
								let getSelect = $('#categoryManagement>li:nth-child('+(i+1)+')').text();
								let gtPosition = getSelect.indexOf(">")+1;
								let boxPosition = getSelect.indexOf("⊠");
								let result = getSelect.substring(gtPosition,boxPosition);
								if(result===selectName){
									return alert("선택되어 있는 품목은 추가 할 수 없습니다.");	
								}
							}
							
							// 선택된 목록 추가 ( Management에서도 보여주고, 차트, 엑셀에도 추가가 되어야 한다.)
							let tag = "<li value="+selectNum+">"+$(this).attr('value')+"&gt;"+selectName+"<span>⊠</span></li>";
							$('#categoryManagement').append(tag);
							
							// append 된 selectName을 배열에 넣어준다.
							resultData.push(selectNum);
							console.log(resultData);
							
							
							//계산은 언제 발동하는가?
							// 중분류 카테고리가 눌렸을 때,
							// 중분류 카테고리 삭제할 때
							   // 이 두가지는 값이 들어왔을 때마다 리스트의 값을 받아서 확인하고 쿼리문을 돌리는 방식으로..?
							// 날짜 적용 눌렀을 때
							   // -> 날짜에 따른 데이터를 불러와야 함
							
							// 계산은 어떻게 해야하나?
							// 월 단위인지, 년 단위인지, 일 단위인지에 따라서 계산되는 값이 달라져야 한다
							
							
							// datasets에 들어갈 data 배열 선언
							let orderpriceData = [];
							// 년, 월 일때 합계를 계산하기 위해 저장할 맵
							// ex) 년별을 골랐을때, 2018년 1월 01일 부터 ~ 2018년 12월 31일까지
							// ex) 월별을 골랐을때, 2018년 03월 01일 부터 ~ 2018년 04월 41일까지
							let map = new Map();
							// 데이터의 날짜를 계산하기 위한 객체화  
							let minDate = new Date(startCalendarDataValue);
							
							
							$.ajax({
								type: "POST",
								url: "getListData",
								traditional : true,
								data: {
									"resultData":resultData,
									"startCalendarDataValue":startCalendarDataValue,
									"endCalendarDataValue":endCalendarDataValue
								}, success: function(result){
									// 엑셀 리스트를 초기화 시킨다.
									let tag = "<li>No</li>"
											+ "<li>매출일자</li>"
									  	    + "<li>상품명</li>"
										    + "<li>수량</li>"
										    + "<li>단가</li>"
									        + "<li>매출금액</li>";
									// 엑셀 리스트에 산출된 데이터 값을 넣는다.
									let $result = $(result);
									$result.each(function(idx,vo){
										tag += "<li>" + vo.ordernum + "</li>";
										tag += "<li value=" + vo.mcatenum + ">" + vo.orderconfirm + "</li>";
										tag += "<li>" + vo.productname + "</li>";
										tag += "<li>" + vo.orderquantity + "</li>";
										tag += "<li>" + vo.orderprice + "</li>";
										tag += "<li>" + (vo.orderquantity * vo.orderprice) + "</li>";
										
									});
									$('#excelList').html(tag);
									
									
									
									// 선택한 첫달의 1일보다 이상 ~ 선택한 다음달의 1일보다 작은 날짜 안에 있는 값을 다 구하고 다음달로 넘어가면 다음달 데이터를 구한다. 
									let maxDate = new Date(minDate);
									maxDate.setMonth(maxDate.getMonth()+1);// maxDate는 minDate의 1달 뒤로 설정

									// 구해진 매출금액의 데이터 개수를 구해서 반복한다.
									for(let i = 0; i < $('#excelList li:nth-child(6n+12)').length; i++){
										let orderconfirm = new Date($('#excelList li:nth-child('+(8+(i*6))+')').text());
										let mcatenum = $('#excelList li:nth-child('+(8+(i*6))+')').attr('value');
										
										// orderconfirm이 maxDate보다 커지면 minDate와 maxDate를 한달 늘린다.
										if(maxDate <= orderconfirm){
											minDate.setMonth(minDate.getMonth()+1);
											maxDate.setMonth(maxDate.getMonth()+1);
											//월 단위로 매출금액을 계산해야 하기 때문에 map도 초기화 해준다.
											map.clear();
										}
										
										//  ex) 1일보다 크고 ~ 31일보다 작은 값들
										if(minDate <= orderconfirm && orderconfirm < maxDate){
											// 각 값 마다의 매출금액을 넣어 더해서 저장해준다. ex) map(감자, 20000) ----> map(감자, 20000) + 10000 = map(감자,30000)
											if(map.has(mcatenum)){// map에 key가 있으면 있던 값에 더해서 저장한다 
												let value = map.get(mcatenum);
												map.set(mcatenum, value+$('#excelList li:nth-child(6n+'+(12+(i*6))+')').text());
												console.log("value=>"+value);
												console.log("매출금액=>"+$('#excelList li:nth-child(6n+'+(12+(i*6))+')').text());
											} else {// map에 key가 없으면
												map.set(mcatenum, $('#excelList li:nth-child(6n+'+(12+(i*6))+')').text()); 
											}
											// map에 데이터를 orderpriceData에 넣는다.
											orderpriceData.push(map.get(orderconfirm));
											//console.log(map.get("1"));
										}
										
										// 몇번째 데이터냐에 따라서 데이터를 추가한다.
										// li에 존재하는 품목의 productnum과 동일하면 추가한다.
										for(let i=0; i<$('#categoryManagement>li').length; i++){
											console.log(map.keys());
											if(result===$('#categoryManagement>li:nth-child('+(i+1)+')').attr('value')){
												console.log('존재하는지 확인');
											}
										}
										
										//myChart.data.datasets[].data(map.get(productnum));
										
										
									}
									//console.log(excelLiLength);
									/*
									/*========================  chart추가  ==========================
									// borderColor random
									let color1 = Math.floor(Math.random() * 256); 
									let color2 = Math.floor(Math.random() * 256);
									let color3 = Math.floor(Math.random() * 256);
									
									// datasets에 들어갈 data 세팅
									let data = {
										label: selectName,
										data: [10000, 25302, 12347, 73946],
										borderColor: 'rgb('+color1+','+color2+','+color3+')'
									};
									
									
									// vo.orderconfirm이 maxDate보다 커지면 minDate와 maxDate를 한달 늘린다.
									if(maxDate <= vo.orderconfirm){
										minDate.setMonth(minDate.getMonth()+1);
										maxDate.setMonth(maxDate.getMonth()+1);
										//월 단위로 매출금액을 계산해야 하기 때문에 map도 초기화 해준다.
										map.clear();
									}
									
									// 1일보다 크고 ~ 31일보다 작은
									if(minDate <= orderconfirm && orderconfirm < maxDate){
										// 각 값 마다의 매출금액을 넣어 더해서 저장해준다. ex) map(감자, 20000) ----> map(감자, 20000) + 10000 = map(감자,30000)
										if(map.has(vo.productnum)){// map에 key가 있으면 
											let value = map.get(vo.productnum);
											map.set(vo.productnum, value+(vo.orderquantity * vo.orderprice));
										} else {// map에 key가 없으면
											map.set(vo.productnum, (vo.orderquantity * vo.orderprice)); 
										}
										console.log(map.entries())
										// map에 계산된 데이터를 제거하고 ! 계산된 값을 넣는다.
										orderpriceData.push(map.get(vo.productnum));
									}
									
								
									
									//이건 일별에 사용 minDate의 "월"의 마지막 날을 구해서 orderconfirm이 그 날짜 안에 있는 값을 더한다
									//let dataLastDay = new Date(minDate.getFullYear(),(minDate.getMonth()+1),0);
									
									
									// 년별, 월별, 일별에 따라서 차트에 들어가는 데이터가 달라진다.
									if(dateCheck=="월별"){
										
										if(minDate<=vo.orderconfirm)
										
										sumData += vo.orderprice;
										//1월이면 1월 01일보다 크고 1월 31일보다 작은 모든 데이터
										for(let i = 0; i <gapResult; i++){ 
											
											minDate.setDate((minDate.getMonth()+1)+1); 
										}
									} else if(dateCheck=="년별"){
										
									} else if(dateCheck=="일별"){
										// 1일보다 크고 ~ 31일보다 작은
										if(minDate <= orderconfirm){
											// 각 값 마다의 매출금액을 넣어 더해서 저장해준다. ex) map(감자, 20000) ----> map(감자, 20000) + 10000 = map(감자,30000)
											if(map.has(vo.productnum)){// map에 key가 있으면 
												let value = map.get(vo.productnum);
												map.set(vo.productnum, value+(vo.orderquantity * vo.orderprice));
											} else {// map에 key가 없으면
												map.set(vo.productnum, (vo.orderquantity * vo.orderprice)); 
											}
											console.log(map.entries())
											// map에 계산된 데이터를 제거하고 ! 계산된 값을 넣는다.
											orderpriceData.push(map.get(vo.productnum));
										}
									}
									*/
									
								}, error: function(e){
									console.log(e);
								}
							});// ajax 끝 
							/*
							orderpriceData.push()
							// 차트 추가 함수
							addData(myChart, data);
							*/
						})// 데이터 추가함수 끝
						
						
						
						// 중분류 삭제 할 때 사용할 기능
						//append로 값을 동적으로 추가해줄 경우 새로 html이 실행 된 것이 아니기 때문에 html에서는 그 값을 읽지 못한다.
						// 그렇기 때문에 document를 사용해 다시 html을 읽기만 해서 싹 둘러보고 찾아서 삭제한다고 생각하면 된다.
						$(document).on('click','#categoryManagement>li',function(){
							
							// 삭제하기 위해서는 어떤 것이 선택되었는지?
							// 그리고 삭제하는 데이터가 추가 된 것 중에 몇번째에 있는지 알 수 있어야 한다.
							let liLength = $('#categoryManagement>li').length;
							
							// 선택된 목록의 이름과 번호를 구한다.
							let selectName = $(this).text();
							let selectNum = $(this).children().val();
							
							
							// 선택된 아이템의 텍스트를 걸러야 한다.
							let selectGtPosition = selectName.indexOf(">")+1;
							let selectBoxPosition = selectName.indexOf("⊠");
							let selectNameResult = selectName.substring(selectGtPosition,selectBoxPosition);
							
							///////////////////////////////차트 데이터 삭제
							// li에 존재하는 품목 이름을 찾아서 삭제한다.
							for(let i=0; i<liLength; i++){
								let getSelect = $('#categoryManagement>li:nth-child('+(i+1)+')').text();
								let gtPosition = getSelect.indexOf(">")+1;
								let boxPosition = getSelect.indexOf("⊠");
								let result = getSelect.substring(gtPosition,boxPosition);
								
								// result와 selectNameResult가 맞는 차트데이터를 삭제한다
								if(result===selectNameResult){
									// result 데이터에 데이터도 삭제한다.
									resultData.splice(i,1);
									console.log(resultData);
									// 차트에 들어가있는 데이터를 삭제한다
									removeData(myChart, i);
								}
								
							}
							// 이건 선택되서 아래에 내려온것들 클릭했을때 지워주는거 ex) 채소>땅콩
							$(this).remove();
						})// 삭제 함수 끝
						
						
					})
					
					
					
					</script>
				</div>
			</div><!-- 수익 매출분석 끝 -->
			
			<div class="wrapContainer">
				<div class="wrapTitle">카테고리별 매출분석</div>
				<div id="excelContainer">
					<ul id="excelList">
						<li>No</li>
						<li>매출일자</li>
						<li>상품명</li>
						<li>수량</li>
						<li>단가</li>
						<li>매출금액</li>
					</ul>
				</div>
				
				<!--------------페이징 표시-------------------->
				<div class="page_wrap">
					<div class="page_nation">
					   <a class="arrow pprev" href="#"></a>
					   <a class="arrow prev" href="#"></a>
					   <a href="#" class="active">1</a>
					   <a href="#">2</a>
					   <a href="#">3</a>
					   <a href="#">4</a>
					   <a href="#">5</a>
					   <a href="#">6</a>
					   <a href="#">7</a>
					   <a href="#">8</a>
					   <a href="#">9</a>
					   <a href="#">10</a>
					   <a class="arrow next" href="#"></a>
					   <a class="arrow nnext" href="#"></a>
					</div>
				 </div>
			</div>
			
		</div>
	</article>
</section>
