package com.beetmall.sshj.seller.service;

import com.beetmall.sshj.seller.vo.SellerEditFarmVO;

public interface SellerEditFarmService {
	//Edit 접속시 판매자 데이터 가져오기
	public SellerEditFarmVO selectInfo(String userid);
	//Edit 접속시 즐겨찾기 수 가져오기
	public int selectFavorite(String userid);
	//저장된 이미지 꺼내오기
	public String getImgName(int storenum);
	// 농장 업데이트
	public int farmUpdate(SellerEditFarmVO vo);
	// 사업자 업데이트
	public int sellerUpdate(SellerEditFarmVO vo);
	// 할인율 확인
	public SellerEditFarmVO discountSelect(String userid);
	
}
