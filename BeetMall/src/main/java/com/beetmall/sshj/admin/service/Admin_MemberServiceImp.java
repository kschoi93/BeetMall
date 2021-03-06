package com.beetmall.sshj.admin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.beetmall.sshj.admin.dao.Admin_MemberDAO;
import com.beetmall.sshj.admin.vo.Admin_ChatVO;
import com.beetmall.sshj.admin.vo.Admin_MemberVO;
import com.beetmall.sshj.admin.vo.Admin_Member_PageVO;
import com.beetmall.sshj.admin.vo.Admin_PointVO;
import com.beetmall.sshj.admin.vo.Admin_WishVO;
import com.beetmall.sshj.admin.vo.Admin_farmVO;
import com.beetmall.sshj.admin.vo.Admin_reportVO;

@Service
public class Admin_MemberServiceImp implements Admin_MemberService {

	@Inject
	Admin_MemberDAO memberdao;

	@Override
	public int memberCount(Admin_Member_PageVO vo) {
		return memberdao.memberCount(vo);
	}

	@Override
	public List<Admin_MemberVO> memberselect(Admin_Member_PageVO pageVO) {
		return memberdao.memberselect(pageVO);
	}

	@Override
	public int memberCountBlack(Admin_Member_PageVO vo) {
		return memberdao.memberCountBlack(vo);
	}

	@Override
	public List<Admin_MemberVO> memberselectblack(Admin_Member_PageVO pageVO) {
		return memberdao.memberselectblack(pageVO);
	}

	@Override
	public int memberCountall(Admin_Member_PageVO vo) {
		return memberdao.memberCountall(vo);
	}

	@Override
	public List<Admin_MemberVO> memberselectall(Admin_Member_PageVO pageVO) {
		return memberdao.memberselectall(pageVO);
	}

	@Override
	public int memberCountSeller(Admin_Member_PageVO vo) {
		return memberdao.memberCountSeller(vo);
	}

	@Override
	public List<Admin_MemberVO> memberselectSeller(Admin_Member_PageVO pageVO) {
		return memberdao.memberselectSeller(pageVO);
	}

	@Override
	public Admin_MemberVO memberinfoSelect(String userid) {
		return memberdao.memberinfoSelect(userid);
	}

	@Override
	public List<Admin_MemberVO> orderinfoSelect(String userid) {
		return memberdao.orderinfoSelect(userid);
	}

	@Override
	public Admin_MemberVO reportinfoSelect(String userid) {
		return memberdao.reportinfoSelect(userid);
	}

	@Override
	public int orderstatusSelect(String userid, String status) {
		return memberdao.orderstatusSelect(userid, status);
	}

	@Override
	public List<Admin_MemberVO> memberselectSellerAll(Admin_Member_PageVO pageVO) {
		return memberdao.memberselectSellerAll(pageVO);
	}

	@Override
	public List<Admin_PointVO> selectPoint(Admin_Member_PageVO vo) {
		return memberdao.selectPoint(vo);
	}

	@Override
	public List<Admin_PointVO> selectPointType(Admin_Member_PageVO vo) {
		return memberdao.selectPointType(vo);
	}

	@Override
	public List<Admin_PointVO> selectPointMonth(Admin_Member_PageVO vo) {
		return memberdao.selectPointMonth(vo);
	}

	@Override
	public List<Admin_PointVO> selectPointTypeMonth(Admin_Member_PageVO pageVOA) {
		return memberdao.selectPointTypeMonth(pageVOA);
	}

	@Override
	public int countPoint(String userid) {
		return memberdao.countPoint(userid);
	}

	@Override
	public int countPointType(String userid, String type) {
		return memberdao.countPointType(userid, type);
	}

	@Override
	public int countPointMonth(String userid, int month) {
		return memberdao.countPointMonth(userid, month);
	}

	@Override
	public int countPointTypeMonth(String userid, String type, int month) {
		return memberdao.countPointTypeMonth(userid, type, month);
	}

	@Override
	public int myPointView(String userid) {
		return memberdao.myPointView(userid);
	}

	@Override
	public int farmCount(String userid) {
		return memberdao.farmCount(userid);
	}

	@Override
	public List<Admin_farmVO> farmFavoriteList(Admin_Member_PageVO pageVO) {
		return memberdao.farmFavoriteList(pageVO);
	}

	@Override
	public int wishCount(String userid) {
		return memberdao.wishCount(userid);
	}

	@Override
	public List<Admin_WishVO> wishListSelect(Admin_Member_PageVO pageVO) {
		return memberdao.wishListSelect(pageVO);
	}

	@Override
	public int memberEdit(Admin_MemberVO vo) {
		return memberdao.memberEdit(vo);
	}

	@Override
	public List<Admin_reportVO> reportselect(Admin_Member_PageVO vo) {
		return memberdao.reportselect(vo);
	}

	@Override
	public int reportPageNum(Admin_Member_PageVO vo) {
		return memberdao.reportPageNum(vo);
	}

	@Override
	public int chatTotal(Admin_Member_PageVO vo) {
		return memberdao.chatTotal(vo);
	}

	@Override
	public List<Admin_ChatVO> chatList(Admin_Member_PageVO pageVO) {
		return memberdao.chatList(pageVO);
	}

	@Override
	public int countreport(String userid) {
		return memberdao.countreport(userid);
	}

	@Override
	public int sumreport(String userid) {
		return memberdao.sumreport(userid);
	}

	@Override
	public int insertreport(String userid, int reportdate) {
		return memberdao.insertreport(userid, reportdate);
	}

	@Override
	public int updateuserstop(String userid) {
		return memberdao.updateuserstop(userid);
	}


}
