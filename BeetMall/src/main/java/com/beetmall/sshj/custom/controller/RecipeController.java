package com.beetmall.sshj.custom.controller;

import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.beetmall.sshj.custom.service.RecipeServiceImp;
import com.beetmall.sshj.custom.vo.PageRecipeVO;
import com.beetmall.sshj.custom.vo.PageRecipeVO2;
import com.beetmall.sshj.custom.vo.RecipeVO;

	@Controller
	public class RecipeController {

	@Inject
	RecipeServiceImp recipeService;
//////////////////////////////////////////////////////////레시피 뷰///////////////////////////////////////////////////////////
	@RequestMapping("/recipeView")
	public ModelAndView RecipeSelect(int recipenum,String id) {
		//////////2해당 게시글 보이게 하기----------
		ModelAndView mav=new ModelAndView();
        
		///여기까지 아이디랑 넘 넘어옴
		
		///조회수//
		recipeService.recipeHit(recipenum);
		//좋아요 누른거 나오게 하기
		int countrk=recipeService.recikeepOnly(recipenum,id);
		//장바구니 누른거 나오게 하기
		int countrg=recipeService.recigoodOnly(recipenum, id);
		
		mav.addObject("countrk",countrk);
		mav.addObject("countrg",countrg);
		
		//System.out.println("Ff");
		
		//뷰어전체
	
		mav.addObject("vo", recipeService.RecipeSelect(recipenum));		
		mav.setViewName("custom/recipeView");

		return mav;
	}
	

//////////////////////////////////////////////////////////레시피 작성///////////////////////////////////////////////////////////	
	@RequestMapping("/recipeWrite")
	public String RecipeWrite() {
		return "custom/recipeWrite";
	}
	
	@RequestMapping(value="/recipeWriteOk", method=RequestMethod.POST)
	public ModelAndView recipeWriteOk(HttpSession session,RecipeVO vo, @RequestParam MultipartFile file, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		
    	//String userid = (String)req.getSession().getAttribute("logId");
		//파일업로드
		//저장 위치
		String userid = (String)session.getAttribute("logId");
		
		String path = req.getSession().getServletContext().getRealPath("/upload");
		System.out.println("path --> " + path);
		
 //   	String paramName = recipemainimg.getName(); //매개변수 이름확인할라고 SYSOUT찎을라고만든거
		String orgName = file.getOriginalFilename();//원파일명
		
   
		//실제 업로드 발생 : tansferTo()
		try {
			if(orgName != null && !orgName.equals("")) {
				file.transferTo(new File(path, orgName));//파일업로드
				vo.setRecipemainimg(orgName);
				vo.setUserid(userid);
			}
		}catch (Exception e) {
			System.out.println("파일업로드 에러발생 --> " + e.getMessage());
		}
		
		int result = recipeService.recipeWriteOk(vo);
		////////////////////////////////////////
		//레코드 추가 실패시 파일을 삭제
		if(result<=0) {
			//첫번쨰 파일삭제
			if(orgName != null) {
				File f = new File(path, orgName);
				f.delete();
			}
			mav.setViewName("redirect:recipeWrite"); //세팅이안됫을때
		}else {
			
			mav.setViewName("redirect:recipeList"); //됬을때
		}
		
		
		
		mav.setViewName("redirect:recipeList");
		
		return mav;
	}
	

//////////////////////////////////////////////////////////레시피 수정///////////////////////////////////////////////////////////
	//수정하기 뷰페이지로이동
		@RequestMapping("recipeEdite")
		public ModelAndView recipeEdite(int recipenum) {
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("vo", recipeService.RecipeSelect(recipenum));
			mav.setViewName("custom/recipeEdite");
			
			return mav;
		}
		
		//수정하기///////////////////////////////////////////////////////////
		@RequestMapping("/recipeEditeOk")
		public ModelAndView recipeEditeOk(RecipeVO vo,HttpSession session) {
			
			String id = (String)session.getAttribute("logId");
			vo.setUserid(id);
			
			ModelAndView mav = new ModelAndView();
			int result = recipeService.recipeEditeOk(vo);
			mav.addObject("recipenum", vo.getRecipenum());
			//System.out.println("recipenum2222222222"+vo.getRecipenum());레시피 숫자 잘 나옴
			
			if(result>0) {
				mav.setViewName("redirect:recipeList");
			}else {
				mav.setViewName("redirect:recipeEdite");
			}
			return mav;
		}
	
//////////////////////////////////////////////////////////레시피 지우기///////////////////////////////////////////////////////////
	
	@RequestMapping("/recipeDelete")
	@ResponseBody
	public int recipeDelete(int recipenum) {
		int result=0;
		
		if(recipeService.recipeDelete(recipenum)>0){//삭제
			result=1;
		}else {//삭제실패
			result=0;
		}
		return result;
		
	}
	
	
//////////////////////////////////////////////////////////레시피 리스트///////////////////////////////////////////////////////////	
		
	@RequestMapping("/recipeList")
	public ModelAndView RecipeAllList(HttpServletRequest req, HttpServletResponse res,PageRecipeVO pageVO) {
	
	ModelAndView mav=new ModelAndView();
	
	PageRecipeVO pageVO1 = new PageRecipeVO();
	
	 //////////1게시글 목록 뽑아내기
    String reqPageNum = req.getParameter("pageNum");
    
    if(reqPageNum == null) {
		pageVO1.setPageNum(1);
	}else if(reqPageNum != null) {
		pageVO1.setPageNum(Integer.parseInt(reqPageNum));
	}
	
  //검색어, 검색키
  	pageVO.setSearchKey(req.getParameter("searchKey"));
  	System.out.println("setSearchKey" + pageVO.getSearchKey());
  	System.out.println("setsearchWord" + pageVO.getSearchWord());
  	pageVO.setSearchWord(req.getParameter("searchWord"));
  	
  	pageVO1.setSearchKey(pageVO.getSearchKey());
  	pageVO1.setSearchWord(pageVO.getSearchWord());
  	
	System.out.println("setSearchKey1" + pageVO1.getSearchKey());
  	System.out.println("setsearchWord1" + pageVO1.getSearchWord());

	//총 레코드 수 구하기 
	pageVO1.setTotalRecord(recipeService.totalRecord8(pageVO1));
	//System.out.println("totalrecord 레시피 ->" +  recipeService.totalRecord4(pageVO1)); //여기까지 나옴
	System.out.println("totalrecord8 레시피 ->" +  recipeService.totalRecord8(pageVO1));
	mav.addObject("pageVO1", pageVO1);
    
	mav.addObject("list" , recipeService.RecipeAllList(pageVO1));			
	mav.setViewName("custom/recipeList");
	
	return mav;
	}
	
//////////////////////////////////////////////////////////레시피 홈///////////////////////////////////////////////////////////
	@RequestMapping("/recipeHome")
	public ModelAndView RecipeAllListHome(HttpServletRequest req, HttpServletResponse res,PageRecipeVO pageVO) {
		
		ModelAndView mav=new ModelAndView();
		
		
		PageRecipeVO pageVO1 = new PageRecipeVO();
        PageRecipeVO pageVO2 = new PageRecipeVO();
        
        //////////1게시글 목록 뽑아내기
        String reqPageNum = req.getParameter("pageNum");
        
        
        if(reqPageNum == null) {
			pageVO1.setPageNum(1);
		}else if(reqPageNum != null) {
			pageVO1.setPageNum(Integer.parseInt(reqPageNum));
		}
        
        if(reqPageNum == null) {
			pageVO2.setPageNum(1);
		}else if(reqPageNum != null) {
			pageVO2.setPageNum(Integer.parseInt(reqPageNum));
		}
		
		

	
		//총 레코드 수 구하기 
		pageVO1.setTotalRecord(recipeService.totalRecord4(pageVO1));
		//System.out.println("totalrecord 레시피 ->" +  recipeService.totalRecord4(pageVO1)); //여기까지 나옴
		mav.addObject("pageVO1", pageVO1);
		
		//총 레코드 수 구하기 
		pageVO2.setTotalRecord(recipeService.totalRecord5(pageVO2));
		//System.out.println("totalrecord 레시피2 ->" +  recipeService.totalRecord5(pageVO2)); //여기까지 나옴
		mav.addObject("pageVO2", pageVO2);
		
		mav.addObject("list" , recipeService.recipeAllListHome(pageVO1));
        mav.addObject("list2" , recipeService.recipeAllListHome2(pageVO2));
        

        
		mav.setViewName("custom/recipeHome");
		
		return mav;
	}
	

	
	
//////////////////////////////////////////////////////////내가 작성한 레시피///////////////////////////////////////////////////////////	
	@RequestMapping("/customMyrecipe")
	@ResponseBody
	public ModelAndView customMyrecipe(HttpSession session,HttpServletRequest req,PageRecipeVO2 pageVO,HttpServletResponse res) {
		
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
	
		
		PageRecipeVO2 pageVO1=new PageRecipeVO2();
		pageVO1.setUserid(userid);
		
		PageRecipeVO2 pageVO2=new PageRecipeVO2();
		pageVO2.setUserid(userid);
		
		
		//////////////////////////
		String reqPageNum1 = req.getParameter("rpageNum1"); //pageNum = 1로 sapvo에 이미 기본값 세팅이 되어 있음
		
		if(reqPageNum1 == null) {
			pageVO1.setPageNum2(1);
		}else if(reqPageNum1 != null) {
			pageVO1.setPageNum2(Integer.parseInt(reqPageNum1));
		}
		

		String reqPageNum2 = req.getParameter("rpageNum2"); //pageNum = 1로 sapvo에 이미 기본값 세팅이 되어 있음
		
		if(reqPageNum2 == null) {
			pageVO2.setPageNum2(1);
		}else if(reqPageNum2 != null) {
			pageVO2.setPageNum2(Integer.parseInt(reqPageNum2));
		}
		
		//총 레코드 수 구하기 
		pageVO1.setTotalRecord2(recipeService.totalRecord6(userid));
		mav.addObject("pageVO1", pageVO1);
		
		pageVO2.setTotalRecord2(recipeService.totalRecord7(userid));
		mav.addObject("pageVO2", pageVO2);
		
		//////////1게시글 목록 뽑아내기
		mav.addObject("list" ,recipeService.customMyrecipe(pageVO1));
		mav.addObject("list2" ,recipeService.customMyrecipe2(pageVO2));
		mav.setViewName("custom/customMyrecipe");
		
		return mav;
	}

	
////////////////////////////////////장바구니 담은 레시피 삭제/////////////////////////////////

@RequestMapping("/recikeepDelete")
@ResponseBody
public int recikeepDelete(int recipenum,HttpSession session) {
int result=0;	
String userid = (String)session.getAttribute("logId");

result=recipeService.recikeepDelete(recipenum,userid);

if(result>0){//삭제
result=1;
}else {//삭제실패
result=0;
}
return result;
}


	/////////////////////////////////////레시피 추천 수 올리기///////////////////////////////////////
	
	@RequestMapping("/recigoodOk")
	@ResponseBody
	public String recigoodOk(HttpServletRequest req) {

    String id=req.getParameter("id");
	int num= Integer.parseInt(req.getParameter("num"));
	
	//int countr=recipeService.recigoodOnly(num,id);
	
	//if(countr<0) {
	System.out.println(recipeService.recigoodOk(num));
	//return num+","+id+","+countr;
	//}
	
	
	return num+","+id;
}
	
	///////////////////////////////////// 레시피 추천 기록///////////////////////////////////////
	
	@RequestMapping("/recigoodOk2")
	@ResponseBody
	public String recigoodOk2(HttpServletRequest req) {
		
		String id=req.getParameter("id");
		int num=Integer.parseInt(req.getParameter("num"));
		
       // int countr=recipeService.recigoodOnly(num, id);
		
	   //if(countr<0) {
	   System.out.println(recipeService.recigoodOk2(num,id));		
	   //return num+","+id+","+countr;
	   //}
		
		
		return num+","+id;
}
    ///////////////////////////////////// 레시피 추천 기록 삭제///////////////////////////////////////
	
	@RequestMapping("/recigoodDelete")
	@ResponseBody
	public int recigoodDelete(HttpServletRequest req) {
		
		
		String id=req.getParameter("id");
		int num=Integer.parseInt(req.getParameter("num"));
		
		//System.out.println("삭제"+id+num);여기까지 옴
		
		return recipeService.recigoodDelete(num,id);
	
		
	}
	
	///////////////////////////////////레시피 장바구니 등록////////////////////////////////////////////
	
	@RequestMapping("/recikeepOk")
	@ResponseBody
	public String recikeepOk(HttpServletRequest req) {
		
		
		String id=req.getParameter("id");
		int num=Integer.parseInt(req.getParameter("num"));
		System.out.println(num);
		
		//int countr=recipeService.recikeepOnly(num,id);
		
		//if(countr<0) {
		System.out.println(recipeService.recikeepOk(num,id));
		//return num+","+id+","+countr;
		//}
	    return num+","+id;
}
	
	
	

	
}
