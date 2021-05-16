<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/xstyle_editFarm.css">
<section>
	<article>
		<div class='seller_title'>농장소개 수정</div>
		<form method="post" action="farmInfo_Edit" id="info_frm">
			<input type="hidden" name="storenum" value="${storenum}"/>
			<!-- info 컨테이너 묶기 width:700px 고정 -->
			<div id="info_container">
				<div id="profile_box">
					<img src="<%=request.getContextPath()%>/resources/img/xprofile_img.png"/><br/>
					<input type="text" id="farmname" name="farmname" style="width:100px;height:25px"/>
					<div>
						방문자수 : ${farmvisitor }명<br/>
						즐겨찾기 : 즐겨찾기 수 명
					</div>
				</div><!-- profile_box 종료 -->
				<hr/>
				<div id="farm_info">
					<div>INFO</div>
					<textarea rows="5" cols="80" name="farmintro"></textarea>
				</div><!-- farm_info 종료 -->
				<div id="farm_contact">
					<div>CONTACT</div>
					<div id="contact_content">
						<b>스토어 정보</b>
						<div><span>상호명</span><input type="text" name="storename" style="width:400px"/></div>
						<div><span>대표자</span><input type="text" name="sellername" style="width:400px"/></div>
						<div><span>사업자등록번호</span><p name="sellerreginum">622-220-11234</p></div>
						<div><span>사업장 소재지</span><p name="storeaddr">서울특별시 영등포구 ...</p></div>
						<div><span>은행명</span><input type="text" name="bank" style="width:400px"/></div>
						<div><span>예금주</span><input type="text" name="bankname" style="width:400px"/></div>
						<div><span>계좌번호</span><input type="text" name="bankaccount" style="width:400px"/></div>
						<div><span>E-Mail</span><input type="text" name="storeemail" style="width:400px"/></div>
					</div>
				</div><!-- farm_contact 종료 -->
				<div id="farm_repMenu">
					<input type="hidden" name="productnum" value="productnum"/> 
					<div>대표메뉴</div>
					<div id="repMenu_content">
						<img src="<%=request.getContextPath()%>/resources/img/xeggplant.jpg" name="thumbimg"/>
						<div>
							<div><span name="">14%</span>&nbsp;<p name="saleprice">50,000원</p></div>
							<p name="productname">상추 품평회에서 대상 수상한 정말 맛있는 상추 설탕 먹여서 키움</p>
						</div>
					</div>
				</div>
			</div><!-- info_container 종료 -->
			<div>
				<input type="submit" id="edit_btn" value="저장하기"/>
			</div>
		</form>
	</article>
</section>