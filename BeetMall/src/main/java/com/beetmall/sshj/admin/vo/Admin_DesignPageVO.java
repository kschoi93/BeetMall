package com.beetmall.sshj.admin.vo;

public class Admin_DesignPageVO {
	private int productnum;
	private int mcatenum;
	private String productname;
	private String storename;
	private String sellername;
	private int count;
	private String sellstart;
	
	public int getProductnum() {
		return productnum;
	}
	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}
	public int getMcatenum() {
		return mcatenum;
	}
	public void setMcatenum(int mcatenum) {
		this.mcatenum = mcatenum;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
	}
	public String getSellername() {
		return sellername;
	}
	public void setSellername(String sellername) {
		this.sellername = sellername;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getSellstart() {
		return sellstart;
	}
	public void setSellstart(String sellstart) {
		this.sellstart = sellstart;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	//	필요한정보를 세팅
	private int pageNum=1;//현재페이지
	private int onePageNum=5;//한페이지당 페이지 번호수
	private int onePageRecord=12;//한페이지당 레코드 수
	
//	디비에서 가져오는 정보
	private int startPageNum=1;//시작페이지-
	private int totalPage;//총페이지수-
	private int totalRecord;//총레코드수(게시글)-
	private int lastPageRecord;//마지막페이지에 남은 레코드수
	
//  디비에서 가져오는정보
	private String searchKey;//검색키
	private String searchWord;//검색어
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		
		//시작페이지 번호를 계산
		startPageNum =(pageNum-1)/onePageNum*onePageNum+1;
	}
	
	public int getOnePageNum() {
		return onePageNum;
	}
	public void setOnePageNum(int onePageNum) {
		this.onePageNum = onePageNum;
	}
	public int getstartPageNum() {
		return startPageNum;
	}
	public void setStartNum(int startNum) {
		this.startPageNum = startNum;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int geTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		//총레코드 수를 이용하여 총 페이지수를 계산하기
		totalPage = (int)Math.ceil(totalRecord/(double)onePageRecord); //36 
		
		//마지막페이지 레코드수
		if(totalRecord%onePageRecord==0) {
			lastPageRecord = onePageRecord;
		}else {
			lastPageRecord = totalRecord%onePageRecord; //마지막페이지의 남은 레코드수
		}
	}

	public int getLastPageRecord() {
		return lastPageRecord;
	}
	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
