 package com.beetmall.sshj.admin.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.beetmall.sshj.admin.service.Admin_SettleService;
import com.beetmall.sshj.admin.vo.Admin_SettleVO;
import com.beetmall.sshj.seller.vo.SellerSettleVO;

@Controller
public class admin_settleController {
	
	@Autowired
	Admin_SettleService service;
	 
	
	@RequestMapping("/settleMng")
	public ModelAndView settleMng(HttpServletRequest req, Admin_SettleVO vo) {
		ModelAndView mav = new ModelAndView();
		
		Calendar sd = Calendar.getInstance();
		Calendar ed = Calendar.getInstance();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DecimalFormat formatter = new DecimalFormat("###,###");
		sd.add(Calendar.MONTH, -3);
		
		if(vo.getStartDate() != null) {
			
		} else {
			String startDate =format.format(sd.getTime());
			String endDate = format.format(ed.getTime());
			
			vo.setStartDate(startDate);
			vo.setEndDate(endDate);
		}
		
		int result = service.getSettleLength(vo);
		
		vo.setTotalRecord(result);

		Admin_SettleVO moneyData = service.getSettleMoney();
		
		
		mav.addObject("adminMoney",formatter.format(moneyData.getAdminMoney()));
		mav.addObject("sellerMoney",formatter.format(moneyData.getSellerMoney()));
		mav.addObject("pageVO",vo);
		mav.addObject("result",service.getSettleList(vo));
		mav.setViewName("admin/settleMng");
		return mav;
	}
	
	@RequestMapping("/adminSettleUpdate")
	public ModelAndView adminSettleUpdate() {
		ModelAndView mav = new ModelAndView();
		
		service.settleUpdate();
		
		mav.setViewName("redirect:settleMng");
		
		return mav;
	}
	
	// ???????????? ??????????????????
	@RequestMapping(value = "/Admin_settle_excelDown",method = RequestMethod.GET)
	@ResponseBody
	public void settle_excelDown(HttpServletRequest req, Admin_SettleVO vo) {
		vo.setUserid((String)req.getSession().getAttribute("logId"));
		
		
		
		
		
		int i = 0;
		// ???????????? ??????
		XSSFWorkbook xssfwb =  new XSSFWorkbook();
			// ????????????
			XSSFFont font = xssfwb.createFont();
			font.setFontName("????????????");
			font.setFontHeightInPoints((short)24);
			font.setBold(true);
			
			// ??? ?????????
			CellStyle style = xssfwb.createCellStyle();
			style.setFont(font);
			style.setFillForegroundColor(IndexedColors.LIME.getIndex());
			style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			style.setVerticalAlignment(VerticalAlignment.CENTER);
			style.setAlignment(HorizontalAlignment.CENTER);
		
		// ????????????
		XSSFSheet xssfsheet = xssfwb.createSheet("BEETMALL ????????????");
		

		// ????????? ?????? row ????????? cell??? ????????? ??????
		List<Admin_SettleVO> list;

			// ?????? ?????? ??????
			xssfsheet.setColumnWidth(0, 6000);
			xssfsheet.setColumnWidth(1, 6000);
			xssfsheet.setColumnWidth(2, 6000);
			xssfsheet.setColumnWidth(3, 6000);
			xssfsheet.setColumnWidth(4, 6000);
			xssfsheet.setColumnWidth(5, 6000);
			xssfsheet.setColumnWidth(6, 6000);
			xssfsheet.setColumnWidth(7, 6000);
			
			// 0 ~ 1??? : 2??? ???,  0 ~ 5??? : 6??? ?????? ????????????.
			xssfsheet.addMergedRegion(new CellRangeAddress(0,1,0,7));
			xssfsheet.autoSizeColumn(100);
			
			// ????????? ??????
			XSSFRow xssfrow = xssfsheet.createRow(i++);
			XSSFCell xssfcell = xssfrow.createCell(0);
			xssfcell.setCellStyle(style);
			xssfcell.setCellValue("BEETMALL ????????? ????????????");
			
			xssfsheet.createRow(i++);
			xssfrow = xssfsheet.createRow(i++); // ?????? ??????
				
				//????????? ?????? ??????
				XSSFFont tableFont = xssfwb.createFont();
				tableFont.setFontHeightInPoints((short)14);
				tableFont.setFontName("????????????");
				
			// ????????? ????????? ??????
			CellStyle tableStyle = xssfwb.createCellStyle();
			XSSFDataFormat format = xssfwb.createDataFormat();
			tableStyle.setDataFormat(format.getFormat("#,##0"));
			tableStyle.setAlignment(HorizontalAlignment.CENTER);
			tableStyle.setFont(tableFont);
			tableStyle.setBorderBottom(BorderStyle.THIN);
			tableStyle.setBorderLeft(BorderStyle.THIN);
			tableStyle.setBorderRight(BorderStyle.THIN);
			tableStyle.setBorderTop(BorderStyle.THIN);
			
			
			xssfrow = xssfsheet.createRow(i++);


			
				xssfcell = xssfrow.createCell(0);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("????????????");
				
				xssfcell = xssfrow.createCell(1);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("????????????");
				
				xssfcell = xssfrow.createCell(2);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("????????????");
				
				xssfcell = xssfrow.createCell(3);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("?????????");
				
				xssfcell = xssfrow.createCell(4);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("?????????");
				
				xssfcell = xssfrow.createCell(5);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("?????????");
				
				xssfcell = xssfrow.createCell(6);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("?????????");
				
				xssfcell = xssfrow.createCell(7);
				xssfcell.setCellStyle(tableStyle);
				xssfcell.setCellValue("?????????");
				
				
				list = service.adminSettleExcel(vo);
				
				for(int index = 0; index < list.size(); index++) {
					xssfrow = xssfsheet.createRow(i++);// ??? ?????? ?????????.
					// ?????? ???????????? ??? ?????? 8?????? ?????????.
					Admin_SettleVO listData = list.get(index);
						
					xssfcell = xssfrow.createCell(0);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getOrdernum());
					
					xssfcell = xssfrow.createCell(1);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getMcatename());
					
					xssfcell = xssfrow.createCell(2);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getOrderstatus());
					
					xssfcell = xssfrow.createCell(3);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getProductname());
					
					xssfcell = xssfrow.createCell(4);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getUserid());
					
					xssfcell = xssfrow.createCell(5);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getStorename() );
					
					xssfcell = xssfrow.createCell(6);
					xssfcell.setCellStyle(tableStyle);
					xssfcell.setCellValue(listData.getOrderconfirm() );
					
					xssfcell = xssfrow.createCell(7);
					xssfcell.setCellStyle(tableStyle);
					if(listData.getSettledate() !=null) {
						xssfcell.setCellValue(listData.getSettledate() );
					} else {
						xssfcell.setCellValue( "-" );
					}
				}
				
			
		
		String downloadFoler = System.getProperty("user.home")+"\\Downloads";
		File mk = new File(downloadFoler);
		mk.mkdirs();
		
		System.out.println("?????? ???????????? ?????? ===>"+System.getProperty("user.home")+"\\Downloads\\BEETMALL ????????????.xlsx");
		File file = new File(System.getProperty("user.home")+"\\Downloads\\BEETMALL ????????????.xlsx");
		try {
			// file??? ????????? ?????? outputStream
			FileOutputStream fos = new FileOutputStream(file);
			// ????????????
			xssfwb.write(fos);
			fos.close();
			System.out.println("???????????? ?????? ??????");
		} catch(Exception e) {
			System.out.println("???????????? ?????? ??????");
			e.printStackTrace();
		}
		
	}
	
	
}