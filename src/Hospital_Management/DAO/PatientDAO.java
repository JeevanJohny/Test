package Hospital_Management.DAO;

import java.sql.*;
import java.util.*;
import Hospital_Management.DTO.Doctor;
import Hospital_Management.DTO.Patient;

public class PatientDAO {

    public int patientAuth(String name, String password) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            PreparedStatement ps = con.prepareStatement("select * from patient where name = ? and password = ?");
            ps.setString(1, name); ps.setString(2, password);
            ResultSet r = ps.executeQuery();
            return r.next() ? 1 : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int registerPatient(Patient p) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            PreparedStatement ps = con.prepareStatement("insert into patient(name, password, phone) values (?, ?, ?)");
            ps.setString(1, p.getName());
            ps.setString(2, p.getPassword());
            ps.setLong(3, p.getPhone());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void viewDoctorsPatient() {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            PreparedStatement ps = con.prepareStatement("select * from doctor");
            ResultSet r = ps.executeQuery();
            while (r.next()) {
                System.out.println(r.getInt("doctor_id") + " : " + r.getString("name") + " : " + r.getString("specialization"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int bookAppointment(String patientUsername, String doctorUsername) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            PreparedStatement ps1 = con.prepareStatement("select patient_id from patient where name = ?");
            ps1.setString(1, patientUsername);
            ResultSet r1 = ps1.executeQuery();
            if (!r1.next()) 
            	return 0;
            int patientId = r1.getInt("patient_id");

            PreparedStatement ps2 = con.prepareStatement("select doctor_id from doctor where username = ?");
            ps2.setString(1, doctorUsername);
            ResultSet r2 = ps2.executeQuery();
            if (!r2.next()) 
            	return 0;
            int doctorId = r2.getInt("doctor_id");

            PreparedStatement ps3 = con.prepareStatement("insert into appointment(patient_id, doctor_id, status) values (?, ?, 'pending')");
            ps3.setInt(1, patientId);
            ps3.setInt(2, doctorId);
            return ps3.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Doctor> doctorsAvailable() {
        List<Doctor> list = new ArrayList<>();
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            PreparedStatement ps = con.prepareStatement("select name, specialization, username from doctor");
            ResultSet r = ps.executeQuery();
            while (r.next()) {
                list.add(new Doctor(r.getString("name"), r.getString("specialization"), r.getString("username"), ""));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void viewAppointmentStatus(String patientUsername) {
        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String getPatientId = "select patient_id from patient where name = ?";
            PreparedStatement getidPstmt = con.prepareStatement(getPatientId);
            getidPstmt.setString(1, patientUsername);
            ResultSet pidRs = getidPstmt.executeQuery();
            if (!pidRs.next()) {
                System.out.println("Patient not found");
                return;
            }
            int patientId = pidRs.getInt("patient_id");

            String query = "select d.name, d.specialization, a.status " +
                           "from appointment a join doctor d on a.doctor_id = d.doctor_id " +
                           "where a.patient_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, patientId);
            ResultSet r = pstmt.executeQuery();

            boolean found = false;
            while (r.next()) {
                String docName = r.getString("name");
                String specialization = r.getString("specialization");
                String status = r.getString("status");
                System.out.println("Doctor: " + docName + " : Specialization: " + specialization + " : Status: " + status);
                found = true;
            }

            if (!found) {
                System.out.println("No appointments found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
