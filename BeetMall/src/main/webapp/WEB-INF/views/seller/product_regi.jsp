<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>	
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		
		<!-- include summernote css/js -->
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
		<!-- font -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300&display=swap" rel="stylesheet">

	
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jcss/basicStyle.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jcss/headerStyle.css">
</head>

<style>

	li{padding-bottom:10px;}
	select{height:28px;}
	input, textarea, select{
		border:1px solid lightgray; 
	}
	input,select,button{height:30px;}
	textarea{
		width:100%;
	}
/*검색하기*/
#article{
   width: 1280px;
   border-bottom: #ddd;
   padding: 50px;
   margin: 5px auto 0 auto;
}

	/*선택사항 제목, div*/
	.wrapTitle{
		margin:40px 40px 40px 0px;
		text-align:center;}
	.category_title{
	   width: 100%;
	   height: 30px;
	   line-height: 30px;
	   text-indent: 0.4em;
	   font-size:16px;
	   margin-top:20px;
	   margin-bottom:10px;
	   font-size:16px;
	}
	.category_wrap{
		border:1px solid lightgray;
		padding:20px;
		margin-bottom:10px;
	}
	 .category_wrap>div{margin-bottom:20px; font-size:15px;}
	/* 리뷰 검색 */
	/* 카테고리 검색 */
	#categoryList{
	   width: 90%;
	   margin: 30px auto;
	   border: 1px solid #aaa;
	}
	
	#categoryListMiddle{
	   width: 100%;
	   height: 170px;
	   display: flex;
	   flex-basis: 1;
	   margin-bottom: 5px;
	   border-top:1px solid #aaa;
	}
	
	#categoryListMiddle ul{
	   border-bottom: 1px solid #aaa;
	   overflow: auto;
	   flex: 1;
	   display: flex;
	   flex-direction: column;
	}
	
	#category{
	   border-right: 1px solid #aaa;
	   font-size:14px;
	}
	#category a{
	   color: black;
	}
	
	#categoryListMiddle li{
	   width: 100%;
	   text-indent: 0.4em;
	   display: flex;
	   margin-top:5px;
	}
	
	#categoryListMiddle span{
	   margin-left: auto;
	   margin-right: 10px;
	}
	
	#categoryManagement{
	   width: 90%;
	   display: flex;
	   flex-wrap: wrap;
	}
	
	#categoryManagement li{
	   text-indent: 0.4em;
	   margin-right: 5px;
	}
	
	#categoryManagement a{
	   color: black;
	   font-weight: bold;
	}
	#mcategory li>a{
	   color: black;
	}

/*제목*/
	.notice{
		font-size:0.7em;
		color:gray;
	}
/*판매가격*/
	#total_price{
		font-weight:bold;
		font-size:17px;
	}
	label{margin-right:10px;}
/*옵션*/
	.regi_option_table input{
		border:none;
		height:30px;
	}
	th{
		height: 30px;
	}
	table,td {
		border:1px solid lightgray;
	}
/*상품내용*/

/*상세설명*/
	.info_detail{
		width:90%;
		margin-left:40px;
		height:700px;
	}
	.note-editable, .note_editor {
		height:500px; width:80%;
	}
/*배송*/
	#pay{height:50px; line-height:30px;}
/*취소 저장하기 버튼*/
	.end_button_wrap{
		text-align:center;
	}
	.save_btn, .cancel_btn{
		width: 100px;
		height: 35px;
		background: #fff;
		margin: 20px 10px 40px 0 ;
	}
	span{line-height:30px;}
	
</style>
<script>
//1. 카테고리 변경
// 데이터에서 불러오기 
   //선택한 대분류 카테고리에 속한 중분류 카테고리 불러오기
   $(function(){
      $(document).on('click',"#category>li",function(){
         // 선택된 카테고리 번호
         let cateNum = $(this).val();
         // 태그를 이용해 선택된 카테고리의 중분류 카테고리를 담는 변수
         let tag ="";
         
         // category 대분류 클릭시  bold처리
         $('#category>li').css('font-weight','normal');
         $(this).css('font-weight','bold');
         
         
         // 카테고리 리스트가 널이 아닐경우
         <c:if test="${cateList!=null }">
            //  카테고리 넘버가 무엇인지에 따라서 불러온다, 카테고리 넘버가 1이면 중분류 카테고리 1번의 값들을 불러오기
            <c:forEach var="mcateList" items="${cateList}">
               if(${mcateList.catenum}==cateNum){
                  tag += "<li value='${mcateList.catename}'>"
                        +"<input type='hidden' name='mcatenum' value='${mcateList.mcatenum}'/>"
                        +"<a href='#' onclick = 'return false;'/>${mcateList.mcatename}</a></li>";	
               }
            </c:forEach>
            $('#mcategory').html(tag);
         </c:if>
      });
      // mcategory 중분류 클릭시 
      $(document).on('click',"#mcategory>li",function(){
    	  // 선택한 중분류 bold처리
    	  $('#mcategory>li').css('font-weight','normal');
          $(this).css('font-weight','bold');
          // 선택한 목록의 중분류 이름, 번호 구하기
          let selectName = $(this).text();
          let selectNum = $(this).children().val();
          // li 개수 구하여 상품 등록은 한 개의 카테고리만 선택 가능
          let liLength = $('#categoryManagement>li').length;
          if(liLength>=1){
             return alert('판매 상품 등록은 한 가지 카테고리만 선택해주세요. 원하시는 품목이 없으신 경우 관리자에게 문의해주세요.'); 
          }
          // 선택된 목록 [카테고리 선택] 하단에 보여주기 
          let tag = "<li value="+selectNum+">"+"<input type='hidden' value="+selectName+">"+"<a href='#' onclick='return false'>"+$(this).attr('value')+"&gt;"+selectName+"<span>⊠</span></a></li>";
          $('#categoryManagement').append(tag);
          // append 된 selectName을 배열에 넣어서 저장
          // 1. DB 에서 데이터 구할때 쓰이고/ 2. 나중에 지울때 써야한다.
          resultData.push(selectNum);
          // 데이터 컨트롤러 실행
          dataController();  
      });
   });
/* 	카테고리 선택 임시 데이터
	var dried_fruits = ['감말랭이', '건망고','건바나나','건자두', '건포도', '곶감', '기타건과류'];
	var nut = ['대추','땅콩','마카다미아','밤','아몬드','은행','잣','캐슈너트','피스타치오','피칸','해바라기씨','호두','호박씨','기타견과류'];
	var fruits = ['감', '감귤', '과일바구니','딸기','레몬','리치','망고','매실','바나나','배','복분자','복숭아','블루베리','사과','석류','수박','아보카도','오렌지','자두', '자몽','참외','천혜향 ','체리','키위/참다래', '토마토', '파인애플','포도','한라봉','혼합과일세트', '기타과일'];
	var rice = ['기능성쌀','백미','찹쌀', '현미', '흑미'];
	var multigrain = ['기장','기타잡곡','녹두','들깨','메밀','보리','수수','옥수수','율무','참깨','콩','팥','혼합곡'];
	var vegetable =['감자','건나물','고구마','고추','기타채소류','단호박','당근','대파','더덕','도라지','마','마늘','무','배추','버섯','부추','브로콜리','산나물','삶은나물','상추','새싹채소','생강','시금치','쌈채소','아스파라거스','알로에','애호박','양배추','양파','연근','열무','오이','우엉','죽순','쪽파','피망/파프리카'];
	$('#category>li').click(function(){
		var option=$(this).text();
		console.log(option);
		//견과류
		if(option=='견과류>'){
			$('#mcategory').empty();
			for(var i=0; i<nut.length; i++){
				var tag; 
				tag = "<li>"+nut[i]+"</li>";
				$('#mcategory').append(tag);
			} //for end
		//건과류	
		}else if(option=='건과류>'){
			$('#mcategory').empty();
			for(var i=0; i<dried_fruits.length; i++){
				var tag; 
				tag = "<li>"+dried_fruits[i]+"</li>";
				$('#mcategory').append(tag);
			}//for end
		}else if(option=='과일>'){
			$('#mcategory').empty();
			for(var i=0; i<fruits.length; i++){
				var tag; 
				tag = "<li>"+fruits[i]+"</li>";
				$('#mcategory').append(tag);
			}//for end
		}else if(option=='쌀>'){
			$('#mcategory').empty();
			for(var i=0; i<rice.length; i++){
				var tag; 
				tag = "<li>"+rice[i]+"</li>";
				$('#mcategory').append(tag);
			}//for end
		}else if(option=='잡곡/혼합곡>'){
			$('#mcategory').empty();
			for(var i=0; i<multigrain.length; i++){
				var tag; 
				tag = "<li>"+multigrain[i]+"</li>";
				$('#mcategory').append(tag);
			}//for end
		}else if(option=='채소>'){
			$('#mcategory').empty();
			for(var i=0; i<dried_fruits.length; i++){
				var tag; 
				tag = "<li>"+vegetable[i]+"</li>";
				$('#mcategory').append(tag);
			}//for end
		}//if else end
		
	}); */

//버튼 클릭시 위로 올라가기 방지
	$('button').click(function(e){
		e.preventDefault();   
		e.stopPropagation();
		return false;
	});
		
//서머노트
	$(document).ready(function() {
		  $('#summernote').summernote();
		});
	
//썸네일 메인이미지 업로드 미리보기
	function readURL(input) {
         if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(event) {
                    $('#thumb_image').attr('src', event.target.result);
                }
              reader.readAsDataURL(input.files[0]); //in
            }
        }
//작은 썸네일 업로드 미리보기 (실패)
	
$(document).ready(function(){	
//할인
		$('#sale_check').click(function(){
			$('#sale_ul').css('display','block');
		});
		$('#sale_uncheck').click(function(){
			$('#sale_ul').css('display','none');
		});
	

//버튼
	/* 	$('.btn').mouseover('click',function(){
			$(this).css('background', 'gray').css('color','white');
		});
		 */
//국내산, 수입산
		$('#import').on('click',function(){
			$('#import_wrap').css('display','block');
		});
		$('#domestic').click(function(){
			$('#import_wrap').css('display','none');
		});
		
//택배
		$('#delivery').on('click',function(){
			$('#delivery_option').css('display','block');
		});
		$('#pickup').click(function(){
			$('#delivery_option').css('display','none');
		});
		
	
//판매기간 설정
	$('#sell_check').on('click',function(){
		$('#sell_start_finish').css('display','block');
		$('#date_group').css('display','block');
	});
	$('#sell_uncheck').on('click',function(){
		$('#sell_start_finish').css('display','none');
		$('#date_group').css('display','none');
	});

//특정기간만 할인 날짜 가져오기
	//현재 날짜 구하기
	//https://ninearies.tistory.com/197
	
//할인판매가 계산

//기간설정하면 달력날짜 바꾸기

//옵션 적용안함 이면 표 비활성화

	$('#option_tbody').children('tr').css('display','none');
	$('#select_option').change(function(){
		var option = $(this).val();
		console.log(option);
		
		for(var i=0; i<5; i++){
			if(option=='i'){
				$('#option_tbody').children('tr').each(function(){
					
				});
				
			}
		}
	});
	
	
	
});		

//취소 history back
	


</script>
<body>
	<div class="main">
	<!-- 가운데 content -->
	  <div id="seller_header">
      <!-- 상단 메뉴 바 -->
      <nav>
         <div id="headerMember">
            <c:if test="${logStatus != 'Y'}">
               <div class="sellerLoginBtn">   <!-- 로그인 전 -->
                  <input type="button" value="회원가입" class="sellerMenuButtons"/>
                  <input type="button" value="로그인" class="sellerMenuButtons"/>
                  <input type="button" value="고객센터" class="sellerMenuButtons"/>
               </div>
            </c:if>
            <c:if test="${logStatus == 'Y' }">
               <div class="sellerLoginBtn">   <!-- 로그인 후 -->
                  <c:if test="${logType==2}">
                     <input type="button" value="판매자 페이지로 이동하기" class="sellerMenuButtons"/>
                  </c:if>
                  <a href="myinfoEdit">${logName}님</a><span id="sellerMenuButtons">▼</span>
                  <input type="button" value="로그아웃" class="sellerMenuButtons"/>
                  <input type="button" value="고객센터" class="sellerMenuButtons"  onClick="location.href='<%=request.getContextPath() %>/ask_admin_list'"/>
               </div>
            </c:if>
         </div>   
         <ul>
            <li><a href="#">BEETMALL</a></li>
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
   </div>
	<div id="article">
	<div class="wrapTitle" style="font-size:20px">상품등록</div>
		<!--검색하기 -->
		<!-- 상품등록 -->
		<!-- 카테고리 -->
		<!-- 상품명 -->
		<!-- 판매가격 설정-->
		<!-- 옵션 -->
		<!-- 재고수량 -->
		<!-- 상품이미지 -->
		<!-- 상세설명 -->
		<!-- 배송 -->
		<!-- 상품내용 -->
		<!-- 취소 저장하기 버튼 -->
	<form method="post" action="">
	<!------------------------------------------ 카테고리------------------------------------------------->
	 <div class="category_title">카테고리</div>
		<div class="category_wrap">
            <div id="categoryList">
               <strong>&nbsp;&nbsp;카테고리 선택</strong>
                 <div id="categoryListMiddle">
                  <!--카테고리에서 대분류 카테고리 선택-------------------------->
                  <ul id="category"><!-- 카테고리 리스트에서 모든 카테고리 리스트를 가져오지만 우선 대분류만 보이게 한다.-->
                     <c:if test="${cateList!=null}">
                        <!-- 변수 i를 선언해주고 -->
                        <c:set var="i" value="1"/>
                        <!-- 변수 i 즉, catenum이 i와 일치하는 데이터 하나를 가지고 오면 
                                 i를 더해주어 다음 조건을 만들어 다음 번호 것만 가져오게 한다 -->
                           <c:forEach var="categoryList" items="${cateList}">
                              <c:if test="${categoryList.catenum==i}">
                                 <li value="${categoryList.catenum}"><a href="#" onclick="return false">${categoryList.catename}</a><span>&gt;</span></li>
                                 <c:set var="i" value="${i+1 }"/>
                              </c:if>
                           </c:forEach>
                        <c:remove var="i"/>
                     </c:if>
                  </ul>
                  
                  <!--카테고리에서 중분류 카테고리 선택-------------------------->
                  <ul id="mcategory"></ul>
               </div>
  				<!--------------------------선택된 카테고리 항목-------------------------->
            </div><!-- categoryList end -->
			<ul id="categoryManagement"></ul>
		</div><!-- categorySelection div end -->
		
	<!----------------------------------------------상품명------------------------------------------>
		<div class="category_title">상품명 등록</div>
	<div class="category_wrap">
			<ul>
				<li><label for="">상품명</label>&nbsp;
					<input type="text" name="productname" id="productRegisterName" size="70"/><span>0/100</span><br/>
					<span class="notice">
					판매 상품과 직접 관련이 없는 다른 상품명, 스팸성 키워드 입력 시 관리자에 의해 판매 금지될 수 있습니다.<br/>
					유명 상품 유사문구를 무단으로 도용하여 기재하는 경우 별도 고지 없이 제재될 수 있습니다. <br/>
					상품명을 검색최적화 가이드에 잘 맞게 입력하면 검색 노출에 도움이 될 수 있습니다. <br/>
					</span>
				</li>
			</ul>
		</div> <!-- productNameRegi div end -->
		
	<!-----------------------------------------------판매가격 설정--------------------------------------->
	<div class="category_title">판매가격</div>
	<div class="category_wrap">		
		<ul>
			<li><label>판매가 </label>&nbsp;<input type="number" name="productprice" id="productprice" min="100" placeholder="숫자만 입력하세요."/><span>원</span></li>
			<br/>
			<li>
				<label>할인여부 </label>&nbsp;
				<input type="button" name="saleselect" class="btn" id="sale_check" value="설정">&nbsp;
				<input type="button" name="saleselect"  class="btn" id="sale_uncheck" value="설정안함">
			</li>
			<ul id="sale_ul" style="display:none">
				<li><label>전체할인 </label>&nbsp;<input type="number" name="saleprice" id="saleprice" placeholder="할인적용금액" max="0"/><span>원</span>&nbsp;<span>할인</span></li>
				<li><input type="checkbox" name="saledate" id=""/><span>특정기간만 할인</span></li>
				<li>
					<input type="date" name="salestart" id="salestart"  class="start_date"/> ~ <input type="date" name="salefinish" id="finish_date"/>
					<span class="notice">특정기간이 지난후에는 판매가로 적용됩니다.</span>
				</li>
				<li>
					<label for="">할인 판매가</label>&nbsp; <span id="total_price" >9000</span>&nbsp;원 &nbsp;(-<span id="discount_price">0</span>원 할인) 
					<span class="notice">수수료는 전체매출에서 2%차감된금액입니다.&nbsp;<a href="">안내 바로가기</a></span>
				</li>
				<li><input type="checkbox" name="saleb" id="saleb"/><span>못난이 할인 상품으로 등록</span></li>
			</ul>
			<li>
				<label>판매기간</label>&nbsp;&nbsp;
				<input type="button" name="selldate" class="btn" id="sell_check"  value="설정"/ >&nbsp;
				<input type="button" name="selldate" class="btn" id="sell_uncheck" value="설정안함"/>
			</li>
			<li id="date_group"><label>기간설정</label><div id="btn_group">
				<input type="button" name="" class="btn" value="5일"/>
				<input type="button" name="" class="btn" value="10일"/>
				<input type="button" name="" class="btn" value="15일"/>
				<input type="button" name="" class="btn" value="30일"/>
				<input type="button" name="" class="btn" value="60일"/>
				</div>
			</li>
			<li id="sell_start_finish"><input type="date" name="sellstart" id="sale_start" class="start_date"/> ~ <input type="date" name="sellfinish" id="finish_date"/></li>
		</ul>
		</div>
	
	<!-----------------------------------------------재고수량--------------------------------------->
	 <div class="category_title">재고수량</div>
	<div class="category_wrap">
			<ul>
				<li><label>재고수량</label>&nbsp; <input type="number" name="totalstock" id="totalstock" min="0"/><span>개</span></li>
				<li><span class="notice">판매할 총 재고량을 입력하세요.</span></li>
			</ul>			
	</div>	
	<!-----------------------------------------------옵션--------------------------------------->
	<div class="category_title">옵션</div>
	<div class="category_wrap">
			<ul class="regi_option_wrap">
				<li><label>옵션 갯수</label>&nbsp;
					<select id="select_option" name="selectoption">
						<option selected value='none'>적용안함</option>
						<option value='1'>1</option>
						<option value='2'>2</option>
						<option value='3'>3</option>
						<option value='4'>4</option>
						<option value='5'>5</option>
					</select>
				</li>
				<li><label>옵션 목록</label>
					<table class="regi_option_table">
						<thead>
							<tr>
								<th>옵션명</th>
								<th>가격</th>
								<th>재고수량</th>
							</tr>
						</thead>
						<tbody id="option_tbody">
							<tr id='tr1'>
								<td><input type="text" name="optionname" id="optionname" placeholder="상품명을 입력해주세요."/></td>
								<td><input type="number" name="optionstock" id="optionstock" min="100" placeholder="원"/></td>
								<td><input type="number" name="optionprice" id="optionprice" placeholder="개"/></td>
							</tr>
							<tr id='tr2'>
								<td><input type="text" name="optionname" id="optionname" placeholder="상품명을 입력해주세요."/></td>
								<td><input type="number" name="optionstock" id="optionstock" min="100" placeholder="원"/></td>
								<td><input type="number" name="optionprice" id="optionprice" placeholder="개"/></td>
							</tr>
							<tr id='tr3'>
								<td><input type="text" name="optionname" id="optionname" placeholder="상품명을 입력해주세요."/></td>
								<td><input type="number" name="optionstock" id="optionstock" min="100" placeholder="원"/></td>
								<td><input type="number" name="optionprice" id="optionprice" placeholder="개"/></td>
							</tr>
							<tr id='tr4'>
								<td><input type="text" name="optionname" id="optionname" placeholder="상품명을 입력해주세요."/></td>
								<td><input type="number" name="optionstock" id="optionstock"  min="100" placeholder="원"/></td>
								<td><input type="number" name="optionprice" id="optionprice" placeholder="개"/></td>
							</tr>
							<tr id='tr5'>
								<td><input type="text" name="optionname" id="optionname" placeholder="상품명을 입력해주세요."/></td>
								<td><input type="number" name="optionstock" id="optionstock"  min="100" placeholder="원"/></td>
								<td><input type="number" name="optionprice" id="optionprice" placeholder="개"/></td>
							</tr>
						</tbody>
					</table>
				</li>
				<li><span class="notice">상세페이지에 예시) 호박고구마 1kg (+3000원)으로 표기됩니다.</span></li>
			</ul>
			</div>
	<!-----------------------------------------------상품 이미지-------------------------------------->
	<div class="category_title">상품 이미지</div>
	<div class="category_wrap">
			<ul>
				<li><label>대표이미지</label><br/>
					<img name="thumb_image" id="thumb_image"src="#" alt="image upload" style="width:400px;"/><br/>
					<input type="file" id="thumb_image_upload" accept="img/*" onchange="readURL(this);" /></li>
				<li>
					<img name=""  id="thumb_image_small" width="200" src="#" alt="image upload" />&nbsp;	
					<img name=""  id="thumb_image_small"  width="200" src="#" alt="image upload" />&nbsp; 
					<img name=""  id="thumb_image_small"  width="200" src="#" alt="image upload" /></br>
		 			<input type="file" id="thumb_image_uplaod" accept="img/*" multiple/>
		 		</li>
		   </ul>	
		</div>
 	<!-----------------------------------------------상세설명------------------------------------->
	<div class="category_title">상세설명</div>
	<div class="category_wrap">
		<textarea id="summernote" name="editordata"></textarea>
		</div>
	<!-----------------------------------------------배송----------------------------------------->
	<div class="category_title">배송</div>
	<div class="category_wrap">
			<ul>
				<li><label>배송방법</label>&nbsp; 
					<input type="button" name="deliveryoption" class="btn" id="delivery" value="택배"/>
					<input type="button" name="deliveryoption" class="btn" id="pickup" value="픽업">
				</li>
				<ul id="delivery_option">
					<li><label>배송비</label>&nbsp;
						<input type="number" name="deliveryprice" id="delivery_price"/><span>원</span>	 <!-- 픽업 선택시 배송비 0원 고정 -->
					</li>
					<li id="pay"><label>결제방식</label>&nbsp;
						<input type="radio" name="paymentoption" id="delivery_price_option" value="착불"/><label for="착불">착불</label>&nbsp;
						<input type="radio" name="paymentoption" id="delivery_price_option" value="선결제"/><label for="선결제">선결제</label>&nbsp;
						<input type="radio" name="paymentoption" id="delivery_price_option"  value="착불 또는 선결제"/><label for="착불또는선결제">착불 또는 선결제</label>
					</li>
				</ul>
			</ul>
		</div>
	<!----------------------------------------------상품내용--------------------------------------->
	<div class="category_title">상품 내용</div>
	<div class="category_wrap">
			<ul>
				<li><label for="">판매단위</label>&nbsp;
					<input type="number" name="selloption" id=""/>
					<select id="select_unit">
						<option value="none">해당없음</option>
						<option value="pack">팩</option>
						<option value="box">박스</option>
					</select>
				</li>
				<li><label for="">중량/용량</label>&nbsp;
					<input type="number" name="sellweight" id="sellweight" />
					<select id="select_weight">
						<option value="g">g</option>
						<option value="kg">kg</option>
					</select>
				</li>
				<li><label for="">원산지</label>&nbsp;
					<input type="button" name="origin" class="btn" id="domestic" value="국내산"/> <input type="button" name="origin" class="btn" id="import" value="수입산"/>
					<div id="import_wrap" style="display:none">
						<input type="button" name="origin" id="china" class="btn" class="import_nation" value="중국산"/>
						<input type="button" name="origin" id="japan" class="btn" class="import_nation" value="일본산"/>
						<input type="button" name="origin"  id="malaysia" class="btn" class="import_nation" value="말레이시아산"/>
						<input type="button" name="origin" id="philippines" class="btn" class="import_nation" value="필리핀산"/>
						<input type="button" name="origin" id="vietnam" class="btn" class="import_nation" value="베트남산">
						<input type="button" name="origin" id="chile" class="btn" class="import_nation" value="칠레산"> 
					</div>
				</li>
				<li><label for="보관/포장타입">보관/ 포장타입</label>&nbsp;
					<select id="select_packing" name="wrapping">
						<option value='실온'>실온</option>
						<option value='냉장'>냉장</option>
						<option value='냉동'>냉동</option>
					</select>
				</li>
				<li><label for="">상품정보</label><br/>
					<textarea placeholder="간략한 상품정보를 입력해주세요."></textarea>
				</li>
				<li><label for="">주의사항</label><br/>
					<textarea placeholder="주의사항을 입력해주세요."></textarea>
				</li>
				<li><label for="">보관방법</label><br/>
					<textarea placeholder="보관방법을 입력해주세요. 예) 습기가 없는 서늘한 곳에 보관하세요."></textarea>
				</li>
				<li><label for="">유통기한</label><br/>
					<textarea placeholder="유통기한을 입력해주세요. 예) 수령후 일주일 또는, 신선식품이므로 가능한 빨리 드시기를 바랍니다."></textarea>
				</li>
			</ul>
		</div>
		<hr/>
	<!--------------------------------------------취소/ 저장하기 버튼---------------------------------------->
		<div class="end_button_wrap">
			<input type="button" class="cancel_btn" class="btn" value="취소">
			<input type="submit" name="" value="저장하기" class="save_btn" class="btn"/>
		</div>
	</form>
	</div><!-- article end -->
	</div><!-- main end -->
</body>
</html>