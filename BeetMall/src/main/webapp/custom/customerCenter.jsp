<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/menu_c.jspf"%>
<style>
	#boardList{list-style-type:none;}
   #boardList li{width:20%; height:40%; line-height:40px; border-bottom:1px solid gray; float:left;}
   #boardList li:nth-child(3n+2){width:60%;}
   #boardList li:nth-child(3n+3){width:20%;}
   .wordcut{white-space:nowrap; overflow:hidden; text-overflow:ellipsis;}
   #noticeMainn{
   		overflow: auto;
   }
   #Main{
	   	margin:30px;
	   	text-align: center;
   }
   #NoticeleftMenu{
   		display:block;
   }
   #Inquiry{
   		position: absolute;
	    top: 290px;
	    left: 1400px;
   }
   
</style>
<script>

</script>
<div class="section">
	<div id="Main">
		<h1>1:1 문의</h1>
	</div>
	<div id="Inquiry"><input type="button" value="문의하기"/></div>
	<div id="noticeMainn">
		<ul id="boardList">
			<li>번호</li>
			<li>제목</li>
			<li>등록일</li>
			
			<%-- <c:forEach var="data" items="${list }"> --%>
	        <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <li>번호</li>
	        <li class="wordcut">제목</li>
	        <li>등록일</li>
	         <%-- </c:forEach>  --%>
		</ul>
	</div>
</div>