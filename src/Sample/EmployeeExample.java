package Sample;
import java.sql.*;

package Sample;
import java.sql.*;

public class EmployeeExample{
	public static void main(String[] args) {
		try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcDemo", "root", "root")) {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String insertQuery = "insert into employee(name,department,salary)values(?, ?, ?)";
			PreparedStatement insertPstmt = con.prepareStatement(insertQuery);
			
			insertPstmt.setString(1, "Al Pacino");
			insertPstmt.setString(2, "Manager");
			insertPstmt.setDouble(3, 100000);
			insertPstmt.addBatch();

			insertPstmt.setString(1, "Robert De Niro");
			insertPstmt.setString(2, "HR");
			insertPstmt.setDouble(3, 60000);
			insertPstmt.addBatch();

			insertPstmt.setString(1, "Jack Nicholson");
			insertPstmt.setString(2, "Software Engineer");
			insertPstmt.setDouble(3, 55000);
			insertPstmt.addBatch();
			insertPstmt.executeBatch();


			String updateQuery = "update employee set salary = ? where id = ?";
			PreparedStatement updatePstmt = con.prepareStatement(updateQuery);
			updatePstmt.setDouble(1, 150000);
			updatePstmt.setInt(2, 1); 
			updatePstmt.executeUpdate();

			String deleteQuery = "delete from employee where id = ?";
			PreparedStatement deletePstmt = con.prepareStatement(deleteQuery);
			deletePstmt.setInt(1, 3); 
			deletePstmt.executeUpdate();

			String retrieveQuery = "select * from employee";
			PreparedStatement selectPstmt = con.prepareStatement(retrieveQuery);
			ResultSet r = selectPstmt.executeQuery();
			while (r.next()) {
				int id = r.getInt("id");
				String name = r.getString("name");
				String department = r.getString("department");
				double salary = r.getDouble("salary");
				System.out.println(id + " : " + name + " : " + department + " : " + salary);
			}

			String highestQuery = "select * from employee order by salary desc limit 1";
			PreparedStatement highPstmt = con.prepareStatement(highestQuery);
			ResultSet highest = highPstmt.executeQuery();
			if (highest.next()) {
				int id = highest.getInt("id");
				String name = highest.getString("name");
				String department = highest.getString("department");
				double salary = highest.getDouble("salary");
				System.out.println("Highest Paid Employee Of The Company");
				System.out.println(id + " : " + name + " : " + department + " : " + salary);
			}


		} catch (Exception e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
