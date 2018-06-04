package utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;

public class StringUtils {
	
	public String md5(String str){
		MessageDigest md;
		String result = "";
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			BigInteger bi = new BigInteger(1, md.digest());
			
			result = bi.toString(16);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}
	public String changeMoney(int price){
		DecimalFormat formater = new DecimalFormat("###,###,###");
		return formater.format(price)+ " VNĐ";
	}
	public int currentPrice(int price, int discount){
		float dis = (float) discount/100;
		return (int) (price-(dis)*price);
	}
}
