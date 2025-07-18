package Sample;
import java.sql.*;

class SampleClass {

	public static void main(String[] args) {
		try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcDemo","root","root")) {
			Class.forName("com.mysql.cj.jdbc.Driver");
//			Statement stmt = con.createStatement("select * from employees");
			
//			String pQuery1 = "insert into employees (employee_id,name) values (?,?)";
//			PreparedStatement pstmt1 = con.prepareStatement(pQuery1);
//			pstmt1.setInt(1, 001);
//			pstmt1.setString(2, "Jeevan");
//			pstmt1.executeUpdate();
			
			String pQuery2 = "select * from employees";
			PreparedStatement  pstmt2 = con.prepareStatement(pQuery2);
			ResultSet r = pstmt2.executeQuery();
			while(r.next()) {
				int id = r.getInt("employee_id");
				String name = r.getString("name");
				System.out.println(id + ":" + name);
			}
			
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
		finally {
			
		}

	}

}
