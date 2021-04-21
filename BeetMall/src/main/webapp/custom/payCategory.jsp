<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/menu_c.jspf"%>
<style>
	*{margin:0px; padding:0px; list-style-type :none;}
	#leftMenu{ display:block;}
	/* 페이징처리부분 */
	.page_wrap {
		text-align:center;
		font-size:0;
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
	.main{
		width:1080px;
	}
	#mainName{
		text-align: left;
		margin-bottom: 20px;
	}
	#search{
		text-align:right;
		padding-bottom: 40px;
	}
	#pickupMain{
		float: right;
		vertical-align: middle;
		padding-top: 15px;
   		font-size: large;
	}
	#productMain{
		width: 1100px;
		overflow:auto;
		padding-left: 100px;
	}
	#productMain div{
		text-align: left;
		margin-right: 30px;
		margin-bottom: 30px;
	}
	#productDiv{
		width:200px;
		float: left;
		border: 1px solid black;
	}

	#Sequence{
		margin-left:20px;
		width: 100px;
		padding: .8em .5em;
		border: 1px solid #999;
		font-family: inherit;
		background: url('<%=request.getContextPath()%>/img/karrow.jpg') no-repeat 95% 50%/30px;
		border-radius: 0px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	#img-button{
		background: url("<%=request.getContextPath()%>/img/kzoom.png") no-repeat;
        border: none;
        width: 32px;
        height: 32px;
        cursor: pointer;
	}
	#searchid {
		width: 130px;
		box-sizing: border-box;
		border: 2px solid #ccc;
		border-radius: 4px;
		font-size: 16px;
		background-color: white;
		background-image: url('<%=request.getContextPath()%>/img/kzoom.png');
		background-position: 10px 10px; 
		background-repeat: no-repeat;
		padding: 12px 20px 12px 40px;
		transition: width 0.4s ease-in-out;
	}

	#searchid:focus {
		width: 300px;
	}

	#productDiv>ul>li>img{
		width:200px;
	}
	
	#searchBtn{
		left:0px;
		top:0px;
	}
	#hrMain{
		overflow:auto;
	}
	#hrMain>#Sequence, #hrMain>div, #hrMain>pickupMain{
		float:left;
	    padding-left: 30px;
	}
	#hrMain>div{
		height:24px;
		padding-top:15px;
	}
	
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	#minNum{
		width:120px;
	}
	#MaxNum{
		width:150px;
	}

</style>
<script>

</script>
<div class="section">
	<div class="main">
		<div id="mainName"><h1>가격대별 찾기</h1></div>
			<div id="hrMain">
				<hr/>
					<select id="Sequence" style="padding-left: 10px;">
						<option value="평점순" selected="selected">평점순</option>
						<option value="가격순">가격순</option>
						<option value="조회수순">조회수순</option>
					</select>
					<div>5,000원 이하</div>
					<div>10,000원 이하</div>
					<div>50,000원 이하</div>
					<div>50,000원 이상</div>
					<div>
						<form>
							<input type="number" id="minNum" min="1000"/>~ <input type="number" id="MaxNum" min="1000"/>
							<input type="submit" value="검색하기"/>
						</form>
					</div>
			</div>
			<hr/>
			<form id="search">
				<input type="text" id="searchid" placeholder="검색"/>
			</form>
		<div id="productMain">
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k001.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k002.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k003.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k004.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k005.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k006.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k007.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k008.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k009.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k010.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k011.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k012.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k013.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k014.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k015.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
			<div id="productDiv">
				<ul>
					<li><img src="<%=request.getContextPath()%>/img/k001.png"></li>
					<li>28,000원</li>
					<li>제목제목제목제목제목제목</li>
					<li>리뷰 50,000|4.8/5</li>
					<li>판매지역 이강산</li>
				</ul>
			</div>
		</div>
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

