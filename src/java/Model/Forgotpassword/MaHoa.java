/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.Forgotpassword;

import java.security.MessageDigest;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author ViQuan
 */
public class MaHoa {
   // md5
	// sha-1 => thường được sử dụng
	public  String toSHA1(String str) {
		String salt = "asjrlkm1234!@#$%^&**()coewj@tjle;oxqskjhdjksjf1jurVn";// Làm cho mật khẩu phức tap
		String result = null;
		
		str = str + salt;
		try {
			byte[] dataBytes = str.getBytes("UTF-8");
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			result = Base64.encodeBase64String(md.digest(dataBytes));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static void main(String[] args) {
            MaHoa ma =new MaHoa();
		System.out.println(ma.toSHA1("sfgh"));
	}
}
