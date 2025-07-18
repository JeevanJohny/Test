package Hospital_Management.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Hospital_Management.DTO.Doctor;

public class AdminDAO {
	
    public int addDoctor(Doctor doctor) {
        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String insertDoctor = "INSERT INTO doctor(name, specialization, username, password) VALUES (?, ?, ?, ?)";
            PreparedStatement docPstmt = con.prepareStatement(insertDoctor);
            docPstmt.setString(1, doctor.getName());
            docPstmt.setString(2, doctor.getSpecialization());
            docPstmt.setString(3, doctor.getUsername());
            docPstmt.setString(4, doctor.getPassword());

            return docPstmt.executeUpdate();

        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
		return 0;
    }
    
    public int removeDoctor(String username) {
        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String removeDoctor = "delete from doctor where username = ?";
            PreparedStatement docPstmt = con.prepareStatement(removeDoctor);
            docPstmt.setString(1, username);

            return docPstmt.executeUpdate(); 

        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return 0; 
    }
    
    public void viewDoctorsAdmin() {
        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String retrieveQuery = "select * from doctor";
            PreparedStatement selectPstmt = con.prepareStatement(retrieveQuery);
            ResultSet r = selectPstmt.executeQuery();

            while (r.next()) {
                int id = r.getInt("doctor_id");
                String name = r.getString("name");
                String specialization = r.getString("specialization");
                String username = r.getString("username");
                System.out.println(id + " : " + name + " : " + specialization + " : " + username);
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
    }




}
