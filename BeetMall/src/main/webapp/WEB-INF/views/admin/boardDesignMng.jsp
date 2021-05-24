<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/top.jspf" %>
  
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

 <!-- css파일 --> 
<link rel ="stylesheet" href="<%=request.getContextPath() %>/resources/css/sshj_admin_2.css" type="text/css">
<style> 
	#topBar h5{  
		padding-left:190px;
		width:600px !important;
	}
	#contentBox {
		height:4400px;
		margin-top:70px !important;
	}
	/*컨테이너 공통*/
	#randomBox, #bannerContainer, #todayContainer{ 
		position:relative;
	 	width:1000px !important;
	 	height:300px;     
	 }  
	 .addBtn{
	 	border-color:gray;
	 	color:dimgray;
	 }
	.delBtn{
		border-color:lightgray;
		color:gray;
	}
	/*배너 이미지*/
	#bannerContainer{ 	
	 	height:360px;
	}
	/*페이징 이미지 링크*/
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
	   .bottommm>input{
	  	background-color:#eee;
	  	height:30px;
	  	border:1px solid lightgray;
	  	width:100px !important; 
	  }
	/*=================css 파일이 안먹어서 임시로 쓰는 곳. css 중복으로 먹으면 지우기====*/
 	   
	#randomBox button{
		margin:0 10px !important;  
	 	width:70px; 
	}
	/*컨테이너 내 헤더*/
	 #randomTitle, #bannerTitle, #todayHeader, #cateHeader, #popHeader{
	 	padding-top:20px;
	 }
	 /*데이터 내용*/ 
	.cartImg{
		margin-left:10px;
		height:20%;
		width:25%;
	}
	#content input, textarea, select, #noticeSearchFrm input{
		border:1px solid lightgray; 
		border-radius: 3px;
	}#content li, label{
		list-style-type:none; 
		padding-bottom:10px;
	}
	#content select{
		height:28px;
	} 
	.contentList>li:nth-of-type(7){
		padding-top:3px;
	}
	/*버튼*/
	#btns{ 
		top:-115px; 
		left:460px; 
	} 
	#btns a>button, button:nth-of-type(4){ 
		margin-left:900px; 
	} 
	#topBar Button:nth-of-type(1),
	#topBar Button:nth-of-type(2),
	#topBar Button:nth-of-type(3),
	#topBar Button:nth-of-type(4){
		padding:2px 7px;
	}
	#topBar h5{  
		padding-left:120px;
	}
	#container li{  
		 float:left; 
		 width:10%; 
	}   
	#contentBox{
		top:-40px;
	} 
	#contentBox li:nth-of-type(){ 
		width:0%; 
	}
	#contentBox li:nth-of-type(4){ 
		width:20%; 
	}   
	#topBar li:nth-of-type(6n){
		width:12%;
	} 
	#topBar li:nth-of-type(4){
		width:6%;
	}   
	
	#sortBox {
		margin: 80px 0 0 20px;
	} 
	#sortBox>ul{
		width:1110px !important;
	}
	#sortBox li:nth-of-type(1), #sortBox li:nth-of-type(5) {
		width: 10%;
	}
	#sortBox li:nth-of-type(2) {
		display:flex;
		width: 16%;
	}
	#sortBox li:nth-of-type(3) {
		margin-right:44px;
	}
	#sortBox li:nth-of-type(4) {
		margin-right:233px;
	} 
	#sortBox li:nth-of-type(7),#sortBox li:nth-of-type(8){
		width: 3.5%;
	}
	#fromTo{
		margin-left:14px;
	}
	/* 상품목록 */
	.pul>li{
		width:180px !important;
		height:35px;
		line-height: 35px;
		padding:0px !important;
	}
	.pul{
		margin-left:0px !important;
		
	}
	#bannerContainer{
		display:none;
	}
	#title{
		border: none;
	}
	#popupselect{
		margin-left: 0px;
		top:-70px;
		left:-100px;
		height:700px;
		position:absolute;
		background-color:white;
		display:none;
		z-index:2;
	}
	/* 모달 처리 */
	#modal{
		background-color: gray;
		opacity: 0.6;
		position: fixed;
		left:0px;
		top:0px;
		width:100%;
		height:100%;
		display:none;
		margin:0 !important;
		z-index:1;
	}
</style>
<script>
$(document).ready(function(){ 
	/*이미지 파일명 추출*/
	  var fileTarget = $('#file'); 
	  fileTarget.on('change', function(){ 
		  if(window.FileReader){ //modern browser
			  var filename = $(this)[0].files[0].name; 
		  } else { // old IE 
	        	var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
	        } 
	        // 추출한 파일명 삽입 
	        $(this).siblings('.uploadFile').val(filename); 
	    });  
});

	/*섬머노트*/
	$(document).ready(function() {
	  $('.summernote').summernote({
		  height: 300,                  
		  focus: false,  
	  });
	});
	$(function(){
		$(document).on('scroll', function(){
			var scroll = window.scrollY;
			$("#popupselect").css("top",scroll);
		});
		$(document).on('click', "input[value=수정]",function(){
			$("#popupselect").css("display","block");
			$("#modal").css("display","block");
			$(document.body).css("overflow","hidden");
		})
		$(document).on('click', "input[value=선택]",function(){
			$("#popupselect").css("display","none");
			$("#modal").css("display","none");
			$(document.body).css("overflow","visible");
		})
	})
	function pagemove(num){
		var url = "/sshj/designPageing";
		var param = "pageNum="+num;
		$.ajax({
			url :url,
			data : param,
			contentType:'application/json',
	        dataType:'json',
			success : function(result){
				var $result = $(result);
				var tag = '';
				console.log($result[0].pageVO.pageNum);
				
				
				$result.each(function(idx, obj){
					tag += "<div id='title'>"+
					"<ul class='pul'>"+
						"<li>상품번호</li>"+
						"<li>카테고리</li>"+
						"<li id='kktitle'>제목</li>"+
						"<li>상호명</li>"+
						"<li>등록일</li>"+
						"<li>추가</li>"
					for(i = 0; i < obj.list.length;i++){
						var data = obj.list[i];
						tag += "</ul>"+
						"</div>"+
						"<ul class='pul'>"+
						"<li>"+data.productnum+"</li>"+
						"<li>"
						if(data.mcatenum>=1 && data.mcatenum<=7){
							tag +="건과류";
						}else if(data.mcatenum>=8 &&data.mcatenum<=21){
							tag +="견과류";
						}else if(data.mcatenum>=22 &&data.mcatenum<=50){
							tag +="과일";
						}else if(data.mcatenum>=51 &&data.mcatenum<=68){
							tag +="쌀/잡곡";
						}else if(data.mcatenum>=69 &&data.mcatenum<=104){
							tag +="야채";
						}
						tag += "</li>"+
						'<li id="kktitle"><a href="/sshj/productEditA?productnum='+data.productnum+'">'+data.productname+'</a></li>'+
						'<li>'+data.storename+'</li>'+
						'<li>'+data.sellstart+'</li>'+
						'<li><input type="button" class="addproduct" value="선택" style="width:60px; height:35px;"></li>'+
						'</ul>';
					}
					var pageVO = $result[0].pageVO;
					tag +='<div class="page_wrap">'+
							'<div class="page_nation">'
							  if(pageVO.pageNum>1){
								  tag += '<a class="arrow prev" href="javascript:pagemove('+(pageVO.pageNum-1)+')"></a>';
							  }
							for(var p = pageVO.startPageNum; p<=(pageVO.startPageNum + pageVO.onePageNum-1);p++){
					            if(p<=pageVO.totalPage){
					            	if(p==pageVO.pageNum){
					            		tag += '<a class="active">'+p+'</a>';
					            	}
					            }
								if(p != pageVO.pageNum){
									tag += '<a href="javascript:pagemove('+p+')">'+p+'</a>';
								}
							}
							if(pageVO.pageNum < pageVO.totalPage){
								tag += '<a class="arrow next" href="javascript:pagemove('+(pageVO.pageNum+1)+')"></a>';
							}
							tag +='</div></div>';
					$("#popupselect").html(tag);
				})
			}, error : function(error){
				console.log(error); //
			}
		})	
	}

</script>  
	<div id="modal"></div>
	<div id="topBarContainer">
		<div id="topBar">			
			<h5><strong><a href="boardDesignMng">디자인 관리</a></strong></h5>			
		</div>  
	</div>
<div id="body1">
<%@ include file="/inc/leftBar.jspf" %>  
<div id="container">
		<div id="contentBox">  
		 	
		 	<!----------------- 배너 이미지 파트 ------------------>
	   		<div id="bannerContainer">
			 	<div id="bannerTitle"><p>배너 이미지</p></div> 	
			 	<section id="bannerBox">	
			 		<ul>
			 			<li>
			 				<div class="bannerImg">
			 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
			 				</div>
			 			</li>
			 			<li><button class="success addBtn" value="" name="" >추가</button>
						<button class="success delBtn delBtn" value="" name="" >삭제</button></li> 
		 				<li><input type="text" placeholder="링크 입력"></li>
			 		</ul>	
			 		<ul>
			 			<li>
			 				<div class="bannerImg">
			 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
			 				</div>
			 			</li>
			 			<li><button class="success addBtn" value="" name="" >추가</button>
						<button class="success delBtn delBtn" value="" name="" >삭제</button></li> 
		 				<li><input type="text" placeholder="링크 입력"></li>
			 		</ul>	
			 		<ul>
			 			<li>
			 				<div class="bannerImg">
			 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
			 				</div>
			 			</li>
			 			<li><button class="success addBtn" value="" name="" >추가</button>
						<button class="success delBtn delBtn" value="" name="" >삭제</button></li> 
		 				<li><input type="text" placeholder="링크 입력"></li>
			 		</ul>	
			 		<ul>
			 			<li>
			 				<div class="bannerImg">
			 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
			 				</div>
			 			</li>
			 			<li><button class="success addBtn" value="" name="" >추가</button>
						<button class="success delBtn delBtn" value="" name="" >삭제</button></li> 
		 				<li><input type="text" placeholder="링크 입력"></li>
			 		</ul>	
			 		<ul>
			 			<li>
			 				<div class="bannerImg">
			 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
			 				</div>
			 			</li>
			 			<li><button class="success addBtn" value="" name="" >추가</button>
						<button class="success delBtn delBtn" value="" name="" >삭제</button></li> 
		 				<li><input type="text" placeholder="링크 입력"></li>
			 		</ul>		
				</section> 	 
		 	</div> 
		 
		<div class="productchange" style="width:1040px;position:absolute;top:0px;margin-bottom:10px;background-color:white;box-shadow: 4px 6px 15px -7px #c4c4c4;">
			<div class="protop" style="width:1040px;text-align:center;font-weight: bold;font-size: 16px;letter-spacing: 2px;border-bottom: 1px solid lightgray;border-radius: 10px 10px 0px 0px;background-color: #FAF9F6;height: 60px;line-height:60px;margin-top:10px;">
				<input type="text" value="${listTitleA}"/>
			</div>
			<div style="margin-top:10px;">
				<c:forEach var="vo" items="${listA}">
					<div class="productPrev" style="width:260px;height:200px;float:left;">
						<div class="imgprint" style="width:240px;height:160px; margin-left:10px;margin-right:10px;">
							<c:if test="${vo.thumbimg != null}">
								<img src="resources/sellerProductImgs/${vo.thumbimg}"style="width:240px;height:160px;"/>
							</c:if>
							<c:if test="${vo.thumbimg == null}">
								<img src="resources/sellerProductImgs/dimgPrev"style="width:240px;height:160px;"/>
							</c:if>
						</div>
						
						<div class="buttons" style="width:70px;margin:5px auto;">
							<input type="hidden" value="${vo.catesort}"/>
							<input type="button" value="수정" style="width:30px;height:20px;"/>
							<input type="button" value="제거" style="width:30px;height:20px;margin-left:5px;"/>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--$%^-->
		<div class="contentBox" id = "popupselect"> 	
		<div id="title">
			<ul class="pul">
				<li>상품번호</li>
				<li>카테고리</li>
				<li id="kktitle">제목</li>
				<li>상호명</li>
				<li>등록일</li> 
				<li>추가</li>
			</ul>
		</div>  
			<ul class="pul">
			<c:forEach var="data" items="${list}">
				<li>${data.productnum}</li>
				<li><c:if test="${data.mcatenum>=1 &&data.mcatenum<=7}">
						건과류
					</c:if>
					<c:if test="${data.mcatenum>=8 &&data.mcatenum<=21}">
						견과류
					</c:if>
					<c:if test="${data.mcatenum>=22 &&data.mcatenum<=50}">
						과일
					</c:if>
					<c:if test="${data.mcatenum>=51 &&data.mcatenum<=68}">
						쌀/잡곡
					</c:if>
					<c:if test="${data.mcatenum>=69 &&data.mcatenum<=104}">
						야채
					</c:if>
				</li>
				<li id="kktitle"><a href="/sshj/productEditA?productnum=${data.productnum}">${data.productname}</a></li>
				<li>${data.storename}</li>
				<li>${data.sellstart}</li> 
				<li><input type="button" class="addproduct" value="선택" style="width:60px; height:35px;"></li>
		</c:forEach>
			</ul>
			<div class="page_wrap">
				<div class="page_nation">
				   <c:if test="${pageVO.pageNum>1}"><!-- 이전페이지가 있을때 -->
				   		<a class="arrow prev" href="javascript:pagemove(${pageVO.pageNum-1})<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
				   </c:if>
				   <!-- 페이지 번호                   1                                    5                     -->
		           <c:forEach var="p" begin="${pageVO.startPageNum}" step="1" end="${pageVO.startPageNum + pageVO.onePageNum-1}">
		              <c:if test="${p<=pageVO.totalPage}">
		                 <c:if test="${p==pageVO.pageNum}"> <!-- 현재페이지일때 실행 -->
		                    <a class="active">${p}</a>
		                 </c:if>   
		                 <c:if test="${p!=pageVO.pageNum}"> <!-- 현재페이지가 아닐때 실행 -->
		                    <a href="javascript:pagemove(${p})<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${p}</a>
		                 </c:if>
		              </c:if>
		           </c:forEach>
		           <c:if test="${pageVO.pageNum < pageVO.totalPage}">
		              <a class="arrow next" href="javascript:pagemove(${pageVO.pageNum+1})<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
	          	 </c:if>
				</div>
		 	</div>  
		</div>
		<!--$%^-->
		</div> 	 
	 	
		 	<!------------------ 카테고리 관리파트--------------------->
			
					<!----------------------- 팝업 파트 ------------------>
				 	<div id="popContainer">
						<div id="popHeader">팝업 관리</div>
					 	<div id="popBox">	
				 			<section id="popBox1">	
				 					<img src="<%=request.getContextPath()%>/img/y_tomato.jpg"/>
				 			</section>
				 			<section id="popBox2">	
				 				<div>
									<label for="file" class="attach"> 
										이미지 첨부하기
									</label>
									<input type="file" style="width: 500px;" id="file">
									<input class="uploadFile"  value="" placeholder="이미지 파일만 업로드하세요">
								</div>
				 				<div id="popDate">
				 					<input type="date" id="from">
				 					<div id="fromTo">&nbsp;&nbsp;~&nbsp;&nbsp;</div>
				 						<input type="date" id="todate"> 
				 					</div>
				 				<input type="text" value="링크 입력">
				 			</section>
				 		</div>
				 	</div>
				 	 
					
			</div>
	</div>  
</div> 
</html>