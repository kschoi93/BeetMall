<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/menu_c.jspf"%>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	*{margin:0px; padding:0px; list-style-type :none; font-family: 'Nanum Gothic', sans-serif;}
   #NoticeleftMenu{
   	display:block;
   }
   a:hover, a:active, a:visited, a:link {
   		color: black;
   }
   .wrapTitle{
	   margin-top: 50px;
	   width: 100%;
	   height: 60px;
	   line-height: 60px;
	   /* color: #fff; */
	   color:black;
	   font-weight:bold;
	   font-size:2em;
	   text-indent: 0.4em;
	   /* background-color: rgb(224,102,102); */
	   margin-bottom:30px;
	}
	ul, li, a{
		list-style: none; padding:0; margin:0;
	}

	/*표*/
	table{
		border-spacing: 0;
		text-indent: initial;
		margin:0 15px 0 15px ;
		margin-bottom:30px;
	}
	th{
		height:50px;
		display: table-cell;
	    vertical-align: inherit;
	    font-weight: bold;
	    text-align: -internal-center;
	    border-bottom: 2px solid #ccc;
	    border-top: 2px solid #ccc;
   		background-color: #fcfcfc;
   		font-size: 16px;
	}
	th:nth-child(1), td:nth-child(2){width:100px;}
	td{
		height:50px;
		border-bottom:1px solid lightgray;
	}
	td:nth-child(1), td:nth-child(2){
		text-align:center;
		width:100px;
	}
	td:nth-child(3){
		padding-left:30px;
	}
	td:nth-child(3) a, a{
		color:black;
		cursor: pointer;
	}
	th{
		margin-top:30px;
		text-align:center;
	}
	/*답변*/
	.answer{
			background-color:#f6f6f6;
		
	}
	.answer_td{
		padding: 20px 0 20px;
		font-size:13px;
	}
	.answer_td:nth-child(1){
		color:red;
		font-weight:bold;
	}
	.answer_td:nth-child(2){
		text-align:left;
		padding-left:30px;
	}
/* 검색하기 */
	#cs_search_container{
		width: 100%;
		margin-bottom: 60px;
		float: center;
		text-align:center;
	}
	#cs_search_box{
		border:none;
	}
	#search{
		height:40px;
		width:600px;
		text-indent: 0.2em;
		border: white;
		float: center;
		border:1px solid lightgray; 
		border-radius: 0px 8px 8px 0px;
		margin:20px 0px 60px -2px;		
	}
	#cs_search_q{
		font-weight:bold;
		color:gray;
		font-size:20px;
	}
	select{
		float:left; 
		height:40px;
		width:130px;
		margin-top:30px;
		margin-left:300px;
		border-radius: 8px 0px 0px 8px;
		border : 1px solid lightgray;
	}
	table, fieldset{
		width:100%;
	}
	/* 페이징처리부분 */
	.page_wrap {
		text-align:center;
		font-size:0;
		padding-bottom: 30px;
	}
	.page_nation {
		display:inline-block;
	}
	.page_nation .none {
		display:none;
	}
	.page_nation a {
		display:block;
		margin:0 3px;
		float:left;
		border:1px solid #e6e6e6;
		width:35px;
		height:35px;
		line-height:35px;
		text-align:center;
		background-color:#fff;
		font-size:13px;
		color:#999999;
		text-decoration:none;
	}
	.page_nation .arrow {
		border:1px solid #ccc;
	}
	.page_nation .pprev {
		background:#f8f8f8 url('<%=request.getContextPath()%>/img/kpage_pprev.png') no-repeat center center;
		margin-left:0;
	}
	.page_nation .prev {
		background:#f8f8f8 url('<%=request.getContextPath()%>/img/kpage_prev.png') no-repeat center center;
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8 url('<%=request.getContextPath()%>/img/kpage_next.png') no-repeat center center;
		margin-left:7px;
	}
	.page_nation .nnext {
		background:#f8f8f8 url('<%=request.getContextPath()%>/img/kpage_nnext.png') no-repeat center center;
		margin-right:0;
	}
	.page_nation a.active {
		background-color:#42454c;
		color:#fff;
		border:1px solid #42454c;
	}
	/* 페이징처리끝 */
	#searchWord{
		height:40px;
		width:400px;
		text-indent: 0.2em;
		border: white;
		float: center;
		border:1px solid lightgray; 
		border-radius: 0px 8px 8px 0px;
		margin:30px 0px 60px -2px;	
		margin-right:320px;
	}
	th{
	    border-bottom-width: 1px;
	    border-top-width: 1px;
	}
</style>
<script>

 $(function(){
//선택한 faq tr열고 닫히기	 
//수정할 것: this만 열리도록 고치기
  	  	$(".faq_td").click(function() {
  			$(this).parent().next().toggle(
  				function(){
  					$(this).parent().next().css("display", " "); 
  				},
  				function(){
  					$(this).parent().next().css("display", "hide"); 
  				}
  			);
  		});
//선택한 select option별로 보기
//수정할 것 나머지 option선택에 대한 script 추가하기
  		
  		$('#sel').change(function(){
  			var option = $(this).val();
  			console.log(option);
  			if(option=='total'){ //전체
  				$('tr').css('display','');
  			}	
  		});

 		$("#searchWord").keydown(function(key){
 			if(key.keyCode ==13){
 				$('#searchFrm').submit(function(){
 					if($("#searchWord").val()==null){
 						alert("검색어를 입력해주세요");
 						return false;
 					}
 					return true;
 				});
 			}
 		});
 });
</script>
<div class="section">
	<div class="main">
		<div class="wrapTitle">자주 묻는 질문</div>
		<div id="cs_search_container">	
			<span id="cs_search_q">자주묻는 질문을 검색해보세요.<br/></span>
			<form method="get" action="FAQBoard" id="searchFrm">
				<select id="sel" id="searchKey">
					<option value="전체">전체</option>
					<option value="상품">상품</option>
					<option value="회원/포인트">회원/포인트</option>
					<option value="판매">판매</option>
					<option value="주문/결제">주문/결제</option>
					<option value="배송">배송</option>
					<option value="교환/반품/환불">교환/반품/환불</option>
				</select>
				<span id="cs_search_box">
					<input type="text" id="searchWord" name="searchWord" placeholder="궁금하신 내용을 입력해주세요." style="margin-right: 250px;">
				</span>
			</form>
		</div>
		<!-- 자주묻는질문 테이블-->
		<fieldset>
		<table>
		<!-- 테이블 헤더-->
			<thead>
				<tr>
					<th>번호</th>
					<th>문의사항</th>
					<th>제목</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${list}">
				<tr class="question">
					<td class="number">${data.faqnum}</td>  <!--a href="javascript:showHideFaq()"  -->
					<td class="fa1_category">[${data.faqcate}]</td>
					<td class="faq_td"><strong>${data.faqtitle}</strong></td>
				</tr>
				<tr class="answer" style="display:none">
					<td class="answer_td">답변</td>
					<td class="answer_td" colspan="3" >  
						${data.faqcontent} 
						<br/>
						<p>
							답변이 충분하지 않으시다면 관리자에게 문의하기를 이용해 주세요.
							<a href="<%=request.getContextPath() %>/customerCenter" style="font-weight:bold"><span style="color:black">문의하기</span></a>
						</p>
					 </td>
				</tr>
				</c:forEach>				
			</tbody>
		</table>
		<!-- 페이징 by kangsan -->
		<div class="page_wrap">
			<div class="page_nation">
			   <c:if test="${pageVO.pageNum>1}"><!-- 이전페이지가 있을때 -->
			   		<a class="arrow prev" href="/sshj/FAQBoard?pageNum=${pageVO.pageNum-1}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
			   </c:if>
			   <!-- 페이지 번호                   1                                    5                     -->
	           <c:forEach var="p" begin="${pageVO.startPageNum}" step="1" end="${pageVO.startPageNum + pageVO.onePageNum-1}">
	              <c:if test="${p<=pageVO.totalPage}">
	                 <c:if test="${p==pageVO.pageNum}"> <!-- 현재페이지일때 실행 -->
	                    <a class="active">${p}</a>
	                 </c:if>   
	                 <c:if test="${p!=pageVO.pageNum}"> <!-- 현재페이지가 아닐때 실행 -->
	                    <a href="/sshj/FAQBoard?pageNum=${p}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${p}</a>
	                 </c:if>
	              </c:if>
	           </c:forEach>
	           <c:if test="${pageVO.pageNum < pageVO.totalPage}">
	              <a class="arrow next" href="/sshj/FAQBoard?pageNum=${pageVO.pageNum+1}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
	           </c:if>
			</div>
		 </div>
		</fieldset>
	</div>
</div>