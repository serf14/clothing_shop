package com.wzx.util;

import java.util.Calendar;
import java.util.Date;

public class TimeUtil {
	/**
	 * 	获取当天开始时间
	 * */
	public static Date getStartTime() {
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		return todayStart.getTime();
	}
	/**
	 * 	获取当天结束时间
	 * */
	public static Date getEndTime() {
		Calendar todayEnd = Calendar.getInstance();
		todayEnd.set(Calendar.HOUR, 23);
		todayEnd.set(Calendar.MINUTE, 59);
		todayEnd.set(Calendar.SECOND, 59);
		todayEnd.set(Calendar.MILLISECOND, 999);
		return todayEnd.getTime();
	}
	/**
	 * 	获取上个月的第一天
	 * */
	public static Date getlastMonth() {
		Calendar todayEnd = Calendar.getInstance();
		todayEnd.set(Calendar.DAY_OF_MONTH, 1);
		todayEnd.set(Calendar.HOUR, 0);
		todayEnd.set(Calendar.MINUTE, 0);
		todayEnd.set(Calendar.SECOND, 0);
		todayEnd.set(Calendar.MILLISECOND, 0);
		return todayEnd.getTime();
	}

	/**
	 * 	获取未来的第next天
	 * */
	public static Date getfutureDate(int next) {  
	       Calendar calendar = Calendar.getInstance(); 
	       calendar.set(Calendar.HOUR, 0);
	       calendar.set(Calendar.MINUTE, 0);
	       calendar.set(Calendar.SECOND, 0);
	       calendar.set(Calendar.MILLISECOND, 0);
	       calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) + next);  
	       Date today = calendar.getTime();  
	       return today;  
	   }  
	public static Date getPastDate(int past) {  
	       Calendar calendar = Calendar.getInstance(); 
	       calendar.set(Calendar.HOUR, 0);
	       calendar.set(Calendar.MINUTE, 0);
	       calendar.set(Calendar.SECOND, 0);
	       calendar.set(Calendar.MILLISECOND, 0);
	       calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);  
	       Date today = calendar.getTime();  
	       return today;  
	   }  
	/**
	 * 取得当月天数
	 * */
	public static int getCurrentMonthLastDay()
	{
		Calendar a = Calendar.getInstance();
		a.set(Calendar.DATE, 1);//把日期设置为当月第一天
		a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
		int maxDate = a.get(Calendar.DATE);
		return maxDate;
	}

	/**
	 * 得到指定月的天数
	 * */
	public static int getMonthLastDay(int year, int month)
	{
		Calendar a = Calendar.getInstance();
		a.set(Calendar.YEAR, year);
		a.set(Calendar.MONTH, month - 1);
		a.set(Calendar.DATE, 1);//把日期设置为当月第一天
		a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
		int maxDate = a.get(Calendar.DATE);
		return maxDate;
	}
	/**
	 * 得到上个月最后一天
	 * */
	public static Date getLastMonthDay()
	{
		Calendar a = Calendar.getInstance();
		a.set(Calendar.DATE, 1);//把日期设置为当月第一天
		a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
		Date today = a.getTime();  
		
		return today;
	}
	/**
	 * 得到上个月从月末往回数的past天
	 * */
	public static Date getPastDatebyMonth(int past) {  
	       Calendar calendar = Calendar.getInstance(); 
	       calendar.set(Calendar.DATE, 0);//把日期设置为当月第一天
	       calendar.set(Calendar.HOUR, 23);
	       calendar.set(Calendar.MINUTE, 59);
	       calendar.set(Calendar.SECOND, 59);
	       calendar.set(Calendar.MILLISECOND, 999);
	       calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);  
	       Date today = calendar.getTime();  
	       return today;  
	   }  
	
}
