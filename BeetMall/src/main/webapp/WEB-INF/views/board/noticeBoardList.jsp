<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css"/>
<style>
	#topBar form, #noticeSearchFrm, #title, button, #contentBox{ position:relative; }
	#addBtn, #delBtn{position:absolute;}
	#container{ position:absolute; top:200px; left:190px; width:1080px; padding:0; }
	#container ul{ width:1700px; } 
	#container li{ list-style-type:none; float:left; width:8%; }
	#contentBox li:nth-of-type(5n+1){ width:2%;} 
	#contentBox li:nth-of-type(5n-1){ width:35%; padding-left:30px; } 
	#contentBox li:not(:nth-of-type(5n-1)){ text-align:center; } 
	#topBar{ background-color:lightgray; float:left; height:50px; padding:10px 0 0 0px; margin-left:10px; width:1080px;}
	#topBar li{ width:7%;}   
	#topBar li:nth-of-type(4){width:3%;} 
	#topBar li:nth-of-type(5){width:24%;} 
	#ascBtn, #descBtn{ top:-2px; } 
	#addBtn{top:7px; left:845px; width:100px;}
	#delBtn{top:7px; left:960px; width:100px;} 
	select{width:100px;}
	#btns{ top:-115px; left:460px; } 
	button{color: #444444; background: #F3F3F3; border: 1px #DADADA solid; outline: none; 
			padding: 5px 10px; margin:0 5px; border-radius: 5px; font-weight: bold; font-size: 12pt; }
	button:active, button:hover, button:focus{ background-color:rgb(153,153,153)}
	#btns a>button, button:nth-of-type(4){ margin-left:900px; }   
	#contentBox{ top:20px; margin-left:10px;}
	#title{ width: 1080px; font-weight:bold; padding:65px 0 25px 0; border-bottom:gray 1px solid;}
	#title li:nth-of-type(4){ padding-left: 250px; }
	.noticeList{ padding-top:5px;} 
	.noticeList:nth-of-type(1){ padding-top:10px;}
	#noticeSearchFrm{ top:30px; left:360px; }
	input[type=checkbox] {zoom: 1.8;} 
	#subjectLine{white-space:nowrap; overflow:hidden;text-overflow:ellipsis;}
	
	 	/*버튼*/
	button, .btn{
		padding: 3px 10px;
		color: #666666;
		border-radius: 8px;
		background:#fff;
		box-shadow: 0 0px 3px 0 rgba(0,0,0,0.5);
		text-align: center;
 		text-decoration: none;
		display: inline-block;
		border:none;
	}
	/*버튼*/
	button:hover{
		background: gray;
		color:white;
		display: inline-block;
	}

	#topBar Button:nth-of-type(1),#topBar Button:nth-of-type(2),#topBar Button:nth-of-type(3),#topBar Button:nth-of-type(4){
		padding:2px 7px;
	}
	 
	/* 페이징처리부분 */
	.page_wrap {
		text-align:center;
		font-size:0; 
	}
	.page_nation {
		display:inline-block;
		padding-top:60px;
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
		background:#f8f8f8 url('<%=request.getContextPath()%>/resources/img/kpage_pprev.png') no-repeat center center;
		margin-left:0;
	}
	.page_nation .prev {
		background:#f8f8f8 url('<%=request.getContextPath()%>/resources/img/kpage_prev.png') no-repeat center center;
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8 url('<%=request.getContextPath()%>/resources/img/kpage_next.png') no-repeat center center;
		margin-left:7px;
	}
	.page_nation .nnext {
		background:#f8f8f8 url('<%=request.getContextPath()%>/resources/img/kpage_nnext.png') no-repeat center center;
		margin-right:0;
	}
	.page_nation a.active {
		background-color:#42454c;
		color:#fff;
		border:1px solid #42454c;
	}
	/* 페이징처리끝 */
</style>
<script>
 
</script>
</head>
<body>
<%@ include file="/inc/leftBar.jspf" %>
	<div id="container">
		<div id="topBar">
			<ul>
				<li><strong>공지 목록</strong></li> 
				<li><select name="sort" > 
		   				<option value="all" selected>전체</option>
		   				<option value="seller">판매자</option>
		   				<option value="customer">소비자</option> 
			  		</select> 
	   			</li>
				<li><select name="sort" > 
		   				<option value="no" selected>글번호</option>
		   				<option value="subject" >제목</option>
		   				<option value="writedate" >등록일</option> 
	   			  	</select> 
	   			</li>
				<li><button class="success" value="asc" name="asc" id="ascBtn">▲</button></li>
				<li><button class="success" value="desc" name="desc" id="descBtn">▼</button></li>
				<li><button class="success" value="add" name="add" id="addBtn">추가</button></li>
				<li><button class="success" value="del" name="del" id="delBtn">삭제</button></li>
			</ul> 
		</div>  
   		<div id="contentBox"> 	
		<div id="title">
			<ul>
				<li><input type="checkbox" name="check"  ></li>
				<li>번호</li>
				<li>대상</li>
				<li>제목</li>
				<li>등록일</li> 
			</ul>
		</div>  
		<c:forEach var="data" items="${list}">
			<ul class="noticeList">
				<li><input type="checkbox" name="check"></li>
				<li>${data.no}?</li>
				<li>판매자?</li>
				<li id="subjectLine"><a href="boardView?no=${data.no}">${data.subject}?</a></li>  
				<li>${data.writedate}등록일?</li><br/>
			</ul>
		</c:forEach>
		</div>	 
		<div class="page_wrap">
			<div class="page_nation">
			   <a class="arrow pprev" href="<%=request.getContextPath()%>/img/kpage_pprev.png"></a>
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

	<!-- 
	 <ul class="breadcrumb pagination-md">
	 	 % if(nowNum>1){%>
	 		<li class="page-item"><a href="noticeBoardList.jsp?nowNum= %=nowNum-1%> %
	 		if(searchWord!=null && !searchWord.equals("")){
	 			out.write("&searchKey="+searchKey+"&searchWord="+searchWord);}%>" 
				class="page-link">Prev</a></li>
		 % }else{%>
			<li class="page-item disabled"><a href="#" class="page-link">Prev</a></li>
		 % }
	 		//페이지 번호 매기기                  
	 		for(int p=startPage; p<startPage+onePageSize; p++){
				if(p<=totalPage){
		 			if(nowNum==p){//현재 보고있는 페이지에 표시하기
		%>		 	
	 				<li class="page-item active"><a href="noticeBoardList.jsp?nowNum= %=p%> %
			if(searchWord!=null && !searchWord.equals("")){
				out.write("&searchKey="+searchKey+"&searchWord="+searchWord);}%>" class="page-link"> %=p%></a></li>
		  
		 % 		}else{//현재 보고있는 페이지가 아닐 때 표시하기
		    %>
        <li class="page-item"><a href="noticeBoardList.jsp?nowNum= %=p %> %if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>" class="page-link"> %=p %></a></li>   
           %   }
          }/// totalPage
      }

	 	if(nowNum==totalPage){ //마지막 페이지
	 	%>
	 		<li class="page-item disabled"><a href="#" class="page-link">Next</a></li>	
	 	 % }else{ %>
	 	 	<li class="page-item"><a href="noticeBoardList.jsp?nowNum= %=nowNum+1%> %
	 	if(searchWord!=null && !searchWord.equals("")){
	 		out.write("&searchKey="+searchKey+"&searchWord="+searchWord);}%>" class="page-link">Next</a></li>
	 	 % } %>
	 </ul>		
 -->
 
	 <div>
		<form method="get" id="noticeSearchFrm" action="<%=request.getContextPath() %>/board/noticeBoardList.jsp">
			<select name="searchKey">
				<option value="subject" selected>제목</option>
   				<option value="no">공지번호</option> 
   				<option value="who">대상</option> 
   				<option value="writedate">공지일</option> 
			</select>			
			<input type="text" name="searchWord" id="searchWord"/>
			<input type="submit" value="검색"/> 
		</form>
		
	</div>  
		</div>
</body>
</html>