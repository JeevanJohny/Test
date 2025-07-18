[33mcommit 8d6905c65924d2213e8a59533bddad647447f900[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmaster[m[33m)[m
Author: JeevanJohny <jeevanjohnyej@gmail.com>
Date:   Fri Jul 18 10:21:00 2025 +0530

    1st commit: JDBC projects

[1mdiff --git a/src/Hospital_Management/DAO/AdminDAO.java b/src/Hospital_Management/DAO/AdminDAO.java[m
[1mnew file mode 100644[m
[1mindex 0000000..28aa262[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DAO/AdminDAO.java[m
[36m@@ -0,0 +1,79 @@[m
[32m+[m[32mpackage Hospital_Management.DAO;[m
[32m+[m
[32m+[m[32mimport java.sql.Connection;[m
[32m+[m[32mimport java.sql.DriverManager;[m
[32m+[m[32mimport java.sql.PreparedStatement;[m
[32m+[m[32mimport java.sql.ResultSet;[m
[32m+[m
[32m+[m[32mimport Hospital_Management.DTO.Doctor;[m
[32m+[m
[32m+[m[32mpublic class AdminDAO {[m
[32m+[m[41m	[m
[32m+[m[32m    public int addDoctor(Doctor doctor) {[m
[32m+[m[32m        try ([m
[32m+[m[32m            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");[m
[32m+[m[32m        ) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            String insertDoctor = "INSERT INTO doctor(name, specialization, username, password) VALUES (?, ?, ?, ?)";[m
[32m+[m[32m            PreparedStatement docPstmt = con.prepareStatement(insertDoctor);[m
[32m+[m[32m            docPstmt.setString(1, doctor.getName());[m
[32m+[m[32m            docPstmt.setString(2, doctor.getSpecialization());[m
[32m+[m[32m            docPstmt.setString(3, doctor.getUsername());[m
[32m+[m[32m            docPstmt.setString(4, doctor.getPassword());[m
[32m+[m
[32m+[m[32m            return docPstmt.executeUpdate();[m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            System.err.println(e.getMessage());[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m		[32mreturn 0;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public int removeDoctor(String username) {[m
[32m+[m[32m        try ([m
[32m+[m[32m            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");[m
[32m+[m[32m        ) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            String removeDoctor = "delete from doctor where username = ?";[m
[32m+[m[32m            PreparedStatement docPstmt = con.prepareStatement(removeDoctor);[m
[32m+[m[32m            docPstmt.setString(1, username);[m
[32m+[m
[32m+[m[32m            return docPstmt.executeUpdate();[m[41m [m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            System.err.println(e.getMessage());[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return 0;[m[41m [m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public void viewDoctorsAdmin() {[m
[32m+[m[32m        try ([m
[32m+[m[32m            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");[m
[32m+[m[32m        ) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            String retrieveQuery = "select * from doctor";[m
[32m+[m[32m            PreparedStatement selectPstmt = con.prepareStatement(retrieveQuery);[m
[32m+[m[32m            ResultSet r = selectPstmt.executeQuery();[m
[32m+[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                int id = r.getInt("doctor_id");[m
[32m+[m[32m                String name = r.getString("name");[m
[32m+[m[32m                String specialization = r.getString("specialization");[m
[32m+[m[32m                String username = r.getString("username");[m
[32m+[m[32m                System.out.println(id + " : " + name + " : " + specialization + " : " + username);[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            System.err.println(e.getMessage());[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/DAO/DoctorDAO.java b/src/Hospital_Management/DAO/DoctorDAO.java[m
[1mnew file mode 100644[m
[1mindex 0000000..60c49a5[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DAO/DoctorDAO.java[m
[36m@@ -0,0 +1,121 @@[m
[32m+[m[32mpackage Hospital_Management.DAO;[m
[32m+[m
[32m+[m[32mimport java.sql.*;[m
[32m+[m[32mimport java.util.ArrayList;[m
[32m+[m[32mimport java.util.List;[m
[32m+[m[32mimport java.util.Scanner;[m
[32m+[m
[32m+[m[32mpublic class DoctorDAO {[m
[32m+[m[32m    Scanner sc = new Scanner(System.in);[m
[32m+[m
[32m+[m[32m    public int doctorAuth(String username, String password) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            String sql = "select * from doctor where username = ? and password = ?";[m
[32m+[m[32m            PreparedStatement stmt = con.prepareStatement(sql);[m
[32m+[m[32m            stmt.setString(1, username);[m
[32m+[m[32m            stmt.setString(2, password);[m
[32m+[m[32m            ResultSet rs = stmt.executeQuery();[m
[32m+[m[32m            return rs.next() ? 1 : 0;[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return 0;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void displayPendingAppointments(String doctorUsername) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            String getDocId = "select doctor_id from doctor where username = ?";[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement(getDocId);[m
[32m+[m[32m            ps.setString(1, doctorUsername);[m
[32m+[m[32m            ResultSet rs = ps.executeQuery();[m
[32m+[m[32m            if (!rs.next()) {[m
[32m+[m[32m                System.out.println("Doctor not found.");[m
[32m+[m[32m                return;[m
[32m+[m[32m            }[m
[32m+[m[32m            int doctorId = rs.getInt("doctor_id");[m
[32m+[m
[32m+[m[32m            String docQuery = "select a.appointment_id, p.name as patient_name, a.status " +[m
[32m+[m[32m                           "from appointment a join patient p on a.patient_id = p.patient_id " +[m
[32m+[m[32m                           "where a.doctor_id = ? and a.status = 'pending'";[m
[32m+[m[32m            PreparedStatement dPstmt = con.prepareStatement(docQuery);[m
[32m+[m[32m            dPstmt.setInt(1, doctorId);[m
[32m+[m[32m            ResultSet r = dPstmt.executeQuery();[m
[32m+[m
[32m+[m[32m            boolean found = false;[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                System.out.println("Appointment ID: " + r.getInt("appointment_id") + " : Patient: " + r.getString("patient_name") +" : Status: " + r.getString("status"));[m
[32m+[m[32m                found = true;[m
[32m+[m[32m            }[m
[32m+[m[32m            if (!found) System.out.println("No pending appointments.");[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void approveDeclineAppointments(String doctorUsername) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            String getDocId = "select doctor_id from doctor where username = ?";[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement(getDocId);[m
[32m+[m[32m            ps.setString(1, doctorUsername);[m
[32m+[m[32m            ResultSet rs = ps.executeQuery();[m
[32m+[m[32m            if (!rs.next()) {[m
[32m+[m[32m                System.out.println("Doctor Not Found.");[m
[32m+[m[32m                return;[m
[32m+[m[32m            }[m
[32m+[m[32m            int doctorId = rs.getInt("doctor_id");[m
[32m+[m
[32m+[m[32m            String docQuery = "select a.appointment_id, p.name from appointment a join patient p on a.patient_id = p.patient_id " +[m
[32m+[m[32m                              "where a.doctor_id = ? and a.status = 'pending'";[m
[32m+[m[32m            PreparedStatement stmt = con.prepareStatement(docQuery);[m
[32m+[m[32m            stmt.setInt(1, doctorId);[m
[32m+[m[32m            ResultSet r = stmt.executeQuery();[m
[32m+[m
[32m+[m[32m            List<Integer> appointmentIds = new ArrayList<>();[m
[32m+[m[32m            int i = 1;[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                System.out.println(i + ". Appointment ID " + r.getInt("appointment_id") +" : Patient: " + r.getString("name"));[m
[32m+[m[32m                appointmentIds.add(r.getInt("appointment_id"));[m
[32m+[m[32m                i++;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            if (appointmentIds.isEmpty()) {[m
[32m+[m[32m                System.out.println("No Pending Appointments.");[m
[32m+[m[32m                return;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            System.out.print("Select appointment to update: ");[m
[32m+[m[32m            int ch = sc.nextInt(); sc.nextLine();[m
[32m+[m[32m            int selectedId = appointmentIds.get(ch - 1);[m
[32m+[m
[32m+[m[32m            System.out.print("Type Y to Approve or N to Decline: ");[m
[32m+[m[32m            String decision = sc.nextLine();[m
[32m+[m
[32m+[m[32m            String status;[m
[32m+[m[32m            if (decision.equals("Y")) {[m
[32m+[m[32m                status = "approved";[m
[32m+[m[32m            } else if (decision.equals("N")) {[m
[32m+[m[32m                status = "declined";[m
[32m+[m[32m            } else {[m
[32m+[m[32m                System.out.println("Invalid");[m
[32m+[m[32m                status = "declined";[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            PreparedStatement updatePstmt = con.prepareStatement("update appointment set status = ? where appointment_id = ?");[m
[32m+[m[32m            updatePstmt.setString(1, status);[m
[32m+[m[32m            updatePstmt.setInt(2, selectedId);[m
[32m+[m
[32m+[m[32m            int res = updatePstmt.executeUpdate();[m
[32m+[m[32m            if (res > 0) System.out.println("Appointment " + status);[m
[32m+[m[32m            else System.out.println("Failed to update");[m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/DAO/PatientDAO.java b/src/Hospital_Management/DAO/PatientDAO.java[m
[1mnew file mode 100644[m
[1mindex 0000000..76c0b3d[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DAO/PatientDAO.java[m
[36m@@ -0,0 +1,135 @@[m
[32m+[m[32mpackage Hospital_Management.DAO;[m
[32m+[m
[32m+[m[32mimport java.sql.*;[m
[32m+[m[32mimport java.util.*;[m
[32m+[m[32mimport Hospital_Management.DTO.Doctor;[m
[32m+[m[32mimport Hospital_Management.DTO.Patient;[m
[32m+[m
[32m+[m[32mpublic class PatientDAO {[m
[32m+[m
[32m+[m[32m    public int patientAuth(String name, String password) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement("select * from patient where name = ? and password = ?");[m
[32m+[m[32m            ps.setString(1, name); ps.setString(2, password);[m
[32m+[m[32m            ResultSet r = ps.executeQuery();[m
[32m+[m[32m            return r.next() ? 1 : 0;[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return 0;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public int registerPatient(Patient p) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement("insert into patient(name, password, phone) values (?, ?, ?)");[m
[32m+[m[32m            ps.setString(1, p.getName());[m
[32m+[m[32m            ps.setString(2, p.getPassword());[m
[32m+[m[32m            ps.setLong(3, p.getPhone());[m
[32m+[m[32m            return ps.executeUpdate();[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return 0;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void viewDoctorsPatient() {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement("select * from doctor");[m
[32m+[m[32m            ResultSet r = ps.executeQuery();[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                System.out.println(r.getInt("doctor_id") + " : " + r.getString("name") + " : " + r.getString("specialization"));[m
[32m+[m[32m            }[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public int bookAppointment(String patientUsername, String doctorUsername) {[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            PreparedStatement ps1 = con.prepareStatement("select patient_id from patient where name = ?");[m
[32m+[m[32m            ps1.setString(1, patientUsername);[m
[32m+[m[32m            ResultSet r1 = ps1.executeQuery();[m
[32m+[m[32m            if (!r1.next())[m[41m [m
[32m+[m[41m            [m	[32mreturn 0;[m
[32m+[m[32m            int patientId = r1.getInt("patient_id");[m
[32m+[m
[32m+[m[32m            PreparedStatement ps2 = con.prepareStatement("select doctor_id from doctor where username = ?");[m
[32m+[m[32m            ps2.setString(1, doctorUsername);[m
[32m+[m[32m            ResultSet r2 = ps2.executeQuery();[m
[32m+[m[32m            if (!r2.next())[m[41m [m
[32m+[m[41m            [m	[32mreturn 0;[m
[32m+[m[32m            int doctorId = r2.getInt("doctor_id");[m
[32m+[m
[32m+[m[32m            PreparedStatement ps3 = con.prepareStatement("insert into appointment(patient_id, doctor_id, status) values (?, ?, 'pending')");[m
[32m+[m[32m            ps3.setInt(1, patientId);[m
[32m+[m[32m            ps3.setInt(2, doctorId);[m
[32m+[m[32m            return ps3.executeUpdate();[m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return 0;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public List<Doctor> doctorsAvailable() {[m
[32m+[m[32m        List<Doctor> list = new ArrayList<>();[m
[32m+[m[32m        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root")) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m[32m            PreparedStatement ps = con.prepareStatement("select name, specialization, username from doctor");[m
[32m+[m[32m            ResultSet r = ps.executeQuery();[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                list.add(new Doctor(r.getString("name"), r.getString("specialization"), r.getString("username"), ""));[m
[32m+[m[32m            }[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m        return list;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void viewAppointmentStatus(String patientUsername) {[m
[32m+[m[32m        try ([m
[32m+[m[32m            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HospitalManagement", "root", "root");[m
[32m+[m[32m        ) {[m
[32m+[m[32m            Class.forName("com.mysql.cj.jdbc.Driver");[m
[32m+[m
[32m+[m[32m            String getPatientId = "select patient_id from patient where name = ?";[m
[32m+[m[32m            PreparedStatement getidPstmt = con.prepareStatement(getPatientId);[m
[32m+[m[32m            getidPstmt.setString(1, patientUsername);[m
[32m+[m[32m            ResultSet pidRs = getidPstmt.executeQuery();[m
[32m+[m[32m            if (!pidRs.next()) {[m
[32m+[m[32m                System.out.println("Patient not found");[m
[32m+[m[32m                return;[m
[32m+[m[32m            }[m
[32m+[m[32m            int patientId = pidRs.getInt("patient_id");[m
[32m+[m
[32m+[m[32m            String query = "select d.name, d.specialization, a.status " +[m
[32m+[m[32m                           "from appointment a join doctor d on a.doctor_id = d.doctor_id " +[m
[32m+[m[32m                           "where a.patient_id = ?";[m
[32m+[m[32m            PreparedStatement pstmt = con.prepareStatement(query);[m
[32m+[m[32m            pstmt.setInt(1, patientId);[m
[32m+[m[32m            ResultSet r = pstmt.executeQuery();[m
[32m+[m
[32m+[m[32m            boolean found = false;[m
[32m+[m[32m            while (r.next()) {[m
[32m+[m[32m                String docName = r.getString("name");[m
[32m+[m[32m                String specialization = r.getString("specialization");[m
[32m+[m[32m                String status = r.getString("status");[m
[32m+[m[32m                System.out.println("Doctor: " + docName + " : Specialization: " + specialization + " : Status: " + status);[m
[32m+[m[32m                found = true;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            if (!found) {[m
[32m+[m[32m                System.out.println("No appointments found.");[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        } catch (Exception e) {[m
[32m+[m[32m            e.printStackTrace();[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/DTO/Admin.java b/src/Hospital_Management/DTO/Admin.java[m
[1mnew file mode 100644[m
[1mindex 0000000..6380404[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DTO/Admin.java[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32mpackage Hospital_Management.DTO;[m
[32m+[m
[32m+[m[32mpublic class Admin {[m
[32m+[m[32m    private String username;[m
[32m+[m[32m    private String password;[m
[32m+[m
[32m+[m[32m    public Admin(String username, String password) {[m
[32m+[m[32m        this.username = username;[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getUsername(){[m
[32m+[m[41m    [m	[32mreturn username;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getPassword(){[m
[32m+[m[41m    [m	[32mreturn password;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/DTO/Doctor.java b/src/Hospital_Management/DTO/Doctor.java[m
[1mnew file mode 100644[m
[1mindex 0000000..f80fa23[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DTO/Doctor.java[m
[36m@@ -0,0 +1,31 @@[m
[32m+[m[32mpackage Hospital_Management.DTO;[m
[32m+[m
[32m+[m[32mpublic class Doctor {[m
[32m+[m[32m    private String name;[m
[32m+[m[32m    private String specialization;[m
[32m+[m[32m    private String username;[m
[32m+[m[32m    private String password;[m
[32m+[m
[32m+[m[32m    public Doctor(String name, String specialization, String username, String password) {[m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m        this.specialization = specialization;[m
[32m+[m[32m        this.username = username;[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getName(){[m
[32m+[m[41m    [m	[32mreturn name;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getSpecialization(){[m
[32m+[m[41m    [m	[32mreturn specialization;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getUsername(){[m
[32m+[m[41m    [m	[32mreturn username;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getPassword(){[m
[32m+[m[41m    [m	[32mreturn password;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/DTO/Patient.java b/src/Hospital_Management/DTO/Patient.java[m
[1mnew file mode 100644[m
[1mindex 0000000..cd50e37[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/DTO/Patient.java[m
[36m@@ -0,0 +1,25 @@[m
[32m+[m[32mpackage Hospital_Management.DTO;[m
[32m+[m
[32m+[m[32mpublic class Patient {[m
[32m+[m[32m    private String name;[m
[32m+[m[32m    private String password;[m
[32m+[m[32m    private long phone;[m
[32m+[m
[32m+[m[32m    public Patient(String name, String password, long phone) {[m
[32m+[m[32m        this.name = name;[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m        this.phone = phone;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getName(){[m
[32m+[m[41m    [m	[32mreturn name;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public String getPassword(){[m
[32m+[m[41m    [m	[32mreturn password;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    public long getPhone(){[m
[32m+[m[41m    [m	[32mreturn phone;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/src/Hospital_Management/Main/Main.java b/src/Hospital_Management/Main/Main.java[m
[1mnew file mode 100644[m
[1mindex 0000000..00726a7[m
[1m--- /dev/null[m
[1m+++ b/src/Hospital_Management/Main/Main.java[m
[36m@@ -0,0 +1,255 @@[m
[32m+[m[32mpackage Hospital_Management.Main;[m
[32m+[m
[32m+[m[32mimport Hospital_Management.DAO.*;[m
[32m+[m[32mimport Hospital_Management.DTO.*;[m
[32m+[m
[32m+[m
[32m+[m[32mimport java.util.*;[m
[32m+[m
[32m+[m[32mpublic class Main {[m
[32m+[m[32m    static Scanner sc = new Scanner(System.in);[m
[32m+[m[32m    static String patientUsernameLoggedIn = null;[m
[32m+[m[32m    static String doctorUsernameLoggedIn = null;[m
[32m+[m
[32m+[m[32m    public static void main(String[] args) {[m
[32m+[m[32m        int choice;[m
[32m+[m[32m        do {[m
[32m+[m[32m            System.out.println("HOSPITAL MANAGEMENT SYSTEM");[m
[32m+[m[32m            System.out.println("1. LOGIN");[m
[32m+[m[32m            System.out.println("2. REGISTER");[m
[32m+[m[32m            System.out.println("3. EXIT");[m
[32m+[m[32m            System.out.print("ENTER YOUR CHOICE: ");[m
[32m+[m[32m            choice = sc.nextInt();[m
[32m+[m[32m            sc.nextLine();[m
[32m+[m
[32m+[m[32m            switch (choice) {[m
[32m+[m[32m                case 1:[m
[32m+[m[32m                    System.out.println("1. Login As Administrator");[m
[32m+[m[32m                    System.out.println("2. Login As Doctor");[m
[32m+[m[32m                    System.out.println("3. Login As Patient");[m
[32m+[m[32m                    System.out.print("ENTER LOGIN CHOICE: ");[m
[32m+[m[32m                    int loginChoice = sc.nextInt();[m
[32m+[m[32m                    sc.nextLine();[m
[32m+[m[32m                    loginMethod(loginChoice);[m
[32m+[m[32m                    break;[m
[32m+[m[32m                case 2:[m
[32m+[m[32m                    patientRegistration();[m
[32m+[m[32m                    break;[m
[32m+[m[32m                case 3:[m
[32m+[m[32m                    System.out.println("Exit");[m
[32m+[m[32m                    break;[m
[32m+[m[32m                default:[m
[32m+[m[32m                    System.out.println("Invalid");[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        } while (choice != 3);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    static void loginMethod(int loginChoice) {[m
[32m+[m[32m        switch (loginChoice) {[m
[32m+[m[32m            case 1:[m
[32m+[m[32m                adminLogin();[m
[32m+[m[32m                break;[m
[32m+[m[32m            case 2:[m
[32m+[m[32m                doctorLogin();[m
[32m+[m[32m                break;[m
[32m+[m[32m            case 3:[m
[32m+[m[32m                patientLogin();[m
[32m+[m[32m                break;[m
[32m+[m[32m            default:[m
[32m+[m[32m                System.out.println("Invalid");[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    static void adminLogin() {[m
[32m+[m[32m        System.out.print("Enter Username: ");[m
[32m+[m[32m        String user = sc.nextLine();[m
[32m+[m[32m        System.out.print("Enter Password: ");[m
[32m+[m[32m        String pass = sc.nextLine();[m
[32m+[m[32m        if (user.equals("admin") && pass.equals("password")) {[m
[32m+[m[32m            System.out.println("Admin login successful");[m
[32m+[m[32m            adminMenu();[m
[32m+[m[32m        } else {[m
[32m+[m[32m            System.out.println("Invalid credentials");[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    static void adminMenu() {[m
[32m+[m[32m        System.out.println("ADMINISTRATOR PANEL");[m
[32m+[m[32m        System.out.println("1.Add Doctor \n2.Remove Doctor \n3.View Doctors \n4.Logout");[m
[32m+[m[32m        System.out.print("Enter your choice: ");[m
[32m+[m[32m        int ch = sc.nextInt();[m
[32m+[m[32m        sc.nextLine();[m
[32m+[m[32m        switch (ch) {[m
[32m+[m[32m            case 1:[m
[32m+[m[32m                addDoctor();[m
[32m+[m[32m                break;[m
[32m+[m[32m            case 2:[m
[32m+[m[32m                removeDoctor();[m
[32m+[m[32m                break;[m
[32m+[m[32m            case 3:[m
[32m+[m[32m                viewDoctorsAdmin();[m
[32m+[m[32m                break;[m
[32m+[m[32m            case 4:[m
[32m+[m[32m                break;[m
[32m+[m[32m            default:[m
[32m+[m[32m                System.out.println("Invalid");[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    static void addDoctor() {[m
[32m+[m[32m        System.out.println("Enter Doctor's Name:");[m
[32m+[m[32m        String name = sc.nextLine();[m
[32m+[m[32m        System.out.println("Enter Specialization:");[m
[32m+[m[32m        String spec = sc.nextLine();[m
[32m+[m[32m        System.out.println("Enter Username:");[m
[32m+[m[32m        String username = sc.nextLine();[m
[32m+[m[32m        System.out.println("Enter Password:");[m
[32m+[m[32m        String password = sc.nextLine();[m
[32m+[m
[32m+[m[32m        Doctor d = new Doctor(name, spec, username, password);[