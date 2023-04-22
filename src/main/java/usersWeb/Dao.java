package usersWeb;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Dao {
	public static String authenticate(String username, String password) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://db:3306/usersProject", "user", "1234");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM users");
			while (rs.next()) {
				if (username.equals(rs.getString("username")) && strToHexString(password).equals(rs.getString("password")))
					return "ok";
			}
			st.close();
			con.close();
		}
		catch (SQLException | ClassNotFoundException e1) {return "error";};
		return "";
	}
	
	public static String addUser(String username, String password) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://db:3306/usersProject", "user", "1234");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM users");
			while (rs.next()) {
				if (username.equals(rs.getString("username")))
					return "userExists";
			}
			st.executeUpdate("INSERT INTO users (username, password) VALUES ('" + username + "', '" + strToHexString(password) + "')");
			st.close();
			con.close();
			return "ok";
		}
		catch (SQLException | ClassNotFoundException e1) {return "error";}
	}
	
	private static String strToHexString(String str) {
		byte[] bytes = new byte[32];
		try {
			bytes = MessageDigest.getInstance("SHA-256").digest(str.getBytes(StandardCharsets.UTF_8));
		} 
		catch (NoSuchAlgorithmException e) {e.printStackTrace();}
		char[] hexChars = new char[bytes.length * 2];
		final char[] HEX_ARRAY = "0123456789ABCDEF".toCharArray();
	    for (int i = 0; i < bytes.length; i++) {
	        int v = bytes[i] & 0xFF;
	        hexChars[i * 2] = HEX_ARRAY[v >>> 4];
	        hexChars[i * 2 + 1] = HEX_ARRAY[v & 0x0F];
	    }
		return new String(hexChars);
	}
}