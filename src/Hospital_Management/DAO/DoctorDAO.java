package Hospital_Management.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class DoctorDAO {
    Scanner sc = new Scanner(System.in);

    public int doctorAuth(String username, String password) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String sql = "select * from doctor where username = ? and password = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? 1 : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void displayPendingAppointments(String doctorUsername) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String getDocId = "select doctor_id from doctor where username = ?";
            PreparedStatement ps = con.prepareStatement(getDocId);
            ps.setString(1, doctorUsername);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                System.out.println("Doctor not found.");
                return;
            }
            int doctorId = rs.getInt("doctor_id");

            String docQuery = "select a.appointment_id, p.name as patient_name, a.status " +
                           "from appointment a join patient p on a.patient_id = p.patient_id " +
                           "where a.doctor_id = ? and a.status = 'pending'";
            PreparedStatement dPstmt = con.prepareStatement(docQuery);
            dPstmt.setInt(1, doctorId);
            ResultSet r = dPstmt.executeQuery();

            boolean found = false;
            while (r.next()) {
                System.out.println("Appointment ID: " + r.getInt("appointment_id") + " : Patient: " + r.getString("patient_name") +" : Status: " + r.getString("status"));
                found = true;
            }
            if (!found) System.out.println("No pending appointments.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void approveDeclineAppointments(String doctorUsername) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String getDocId = "select doctor_id from doctor where username = ?";
            PreparedStatement ps = con.prepareStatement(getDocId);
            ps.setString(1, doctorUsername);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                System.out.println("Doctor Not Found.");
                return;
            }
            int doctorId = rs.getInt("doctor_id");

            String docQuery = "select a.appointment_id, p.name from appointment a join patient p on a.patient_id = p.patient_id " +
                              "where a.doctor_id = ? and a.status = 'pending'";
            PreparedStatement stmt = con.prepareStatement(docQuery);
            stmt.setInt(1, doctorId);
            ResultSet r = stmt.executeQuery();

            List<Integer> appointmentIds = new ArrayList<>();
            int i = 1;
            while (r.next()) {
                System.out.println(i + ". Appointment ID " + r.getInt("appointment_id") +" : Patient: " + r.getString("name"));
                appointmentIds.add(r.getInt("appointment_id"));
                i++;
            }

            if (appointmentIds.isEmpty()) {
                System.out.println("No Pending Appointments.");
                return;
            }

            System.out.print("Select appointment to update: ");
            int ch = sc.nextInt(); sc.nextLine();
            int selectedId = appointmentIds.get(ch - 1);

            System.out.print("Type Y to Approve or N to Decline: ");
            String decision = sc.nextLine();

            String status;
            if (decision.equals("Y")) {
                status = "approved";
            } else if (decision.equals("N")) {
                status = "declined";
            } else {
                System.out.println("Invalid");
                status = "declined";
            }

            PreparedStatement updatePstmt = con.prepareStatement("update appointment set status = ? where appointment_id = ?");
            updatePstmt.setString(1, status);
            updatePstmt.setInt(2, selectedId);

            int res = updatePstmt.executeUpdate();
            if (res > 0) System.out.println("Appointment " + status);
            else System.out.println("Failed to update");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
