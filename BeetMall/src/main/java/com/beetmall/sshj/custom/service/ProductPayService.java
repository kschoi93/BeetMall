package com.beetmall.sshj.custom.service;

import com.beetmall.sshj.custom.vo.ProductPayVO;

public interface ProductPayService {

	public ProductPayVO productPay(String userid, int productnum);

	public ProductPayVO productPaySame(String userid);

	public void PointUpdate(int point, String userid);

	public void insertordertbl(ProductPayVO pro);

	public void inserOrderDetail(ProductPayVO pro);
	
}