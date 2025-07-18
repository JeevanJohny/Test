package Hospital_Management.Main;

import Hospital_Management.DAO.*;
import Hospital_Management.DTO.*;


import java.util.*;

public class Main {
    static Scanner sc = new Scanner(System.in);
    static String patientUsernameLoggedIn = null;
    static String doctorUsernameLoggedIn = null;

    public static void main(String[] args) {
        int choice;
        do {
            System.out.println("HOSPITAL MANAGEMENT SYSTEM");
            System.out.println("1. LOGIN");
            System.out.println("2. REGISTER");
            System.out.println("3. EXIT");
            System.out.print("ENTER YOUR CHOICE: ");
            choice = sc.nextInt();
            sc.nextLine();

            switch (choice) {
                case 1:
                    System.out.println("1. Login As Administrator");
                    System.out.println("2. Login As Doctor");
                    System.out.println("3. Login As Patient");
                    System.out.print("ENTER LOGIN CHOICE: ");
                    int loginChoice = sc.nextInt();
                    sc.nextLine();
                    loginMethod(loginChoice);
                    break;
                case 2:
                    patientRegistration();
                    break;
                case 3:
                    System.out.println("Exit");
                    break;
                default:
                    System.out.println("Invalid");
            }

        } while (choice != 3);
    }

    static void loginMethod(int loginChoice) {
        switch (loginChoice) {
            case 1:
                adminLogin();
                break;
            case 2:
                doctorLogin();
                break;
            case 3:
                patientLogin();
                break;
            default:
                System.out.println("Invalid");
        }
    }

    static void adminLogin() {
        System.out.print("Enter Username: ");
        String user = sc.nextLine();
        System.out.print("Enter Password: ");
        String pass = sc.nextLine();
        if (user.equals("admin") && pass.equals("password")) {
            System.out.println("Admin login successful");
            adminMenu();
        } else {
            System.out.println("Invalid credentials");
        }
    }

    static void adminMenu() {
        System.out.println("ADMINISTRATOR PANEL");
        System.out.println("1.Add Doctor \n2.Remove Doctor \n3.View Doctors \n4.Logout");
        System.out.print("Enter your choice: ");
        int ch = sc.nextInt();
        sc.nextLine();
        switch (ch) {
            case 1:
                addDoctor();
                break;
            case 2:
                removeDoctor();
                break;
            case 3:
                viewDoctorsAdmin();
                break;
            case 4:
                break;
            default:
                System.out.println("Invalid");
        }
    }

    static void addDoctor() {
        System.out.println("Enter Doctor's Name:");
        String name = sc.nextLine();
        System.out.println("Enter Specialization:");
        String spec = sc.nextLine();
        System.out.println("Enter Username:");
        String username = sc.nextLine();
        System.out.println("Enter Password:");
        String password = sc.nextLine();

        Doctor d = new Doctor(name, spec, username, password);
        AdminDAO dao = new AdminDAO();
        int result = dao.addDoctor(d);
        if (result > 0) System.out.println("Doctor Added");
        else System.out.println("Error");
        adminMenu();
    }

    static void removeDoctor() {
        System.out.print("Enter Doctor Username to Remove: ");
        String username = sc.nextLine();
        AdminDAO dao = new AdminDAO();
        int result = dao.removeDoctor(username);
        if (result > 0) System.out.println("Doctor Removed");
        else System.out.println("Error");
        adminMenu();
    }

    static void viewDoctorsAdmin() {
        System.out.println("Doctor's List:");
        new AdminDAO().viewDoctorsAdmin();
        adminMenu();
    }

    static void doctorLogin() {
        System.out.print("Enter Username: ");
        String user = sc.nextLine();
        System.out.print("Enter Password: ");
        String pass = sc.nextLine();
        if (new DoctorDAO().doctorAuth(user, pass) > 0) {
            System.out.println("Doctor login successful");
            doctorUsernameLoggedIn = user;
            doctorMenu();
        } else {
            System.out.println("Invalid");
        }
    }

    static void doctorMenu() {
        int ch;
        do {
            System.out.println("DOCTOR PANEL");
            System.out.println("1.View Pending Appointments \n2.Approve/Decline \n3.Logout");
            ch = sc.nextInt();
            sc.nextLine();
            switch (ch) {
                case 1:
                    viewPendingAppointments();
                    break;
                case 2:
                    approveDeclineAppointments();
                    break;
            }
        } while (ch != 3);
    }

    static void viewPendingAppointments() {
        new DoctorDAO().displayPendingAppointments(doctorUsernameLoggedIn);
    }

    static void approveDeclineAppointments() {
        new DoctorDAO().approveDeclineAppointments(doctorUsernameLoggedIn);
    }

    static void patientLogin() {
        System.out.print("Enter Username: ");
        String user = sc.nextLine();
        System.out.print("Enter Password: ");
        String pass = sc.nextLine();
        if (new PatientDAO().patientAuth(user, pass) > 0) {
            System.out.println("Patient login successful");
            patientUsernameLoggedIn = user;
            patientMenu();
        } else {
            System.out.println("Invalid");
        }
    }

    static void patientMenu() {
        int ch;
        do {
            System.out.println("PATIENT PANEL");
            System.out.println("1.View Doctors \n2.Book Appointment \n3.View Appointment Status \n4.Logout");
            ch = sc.nextInt();
            sc.nextLine();
            switch (ch) {
                case 1:
                    viewDoctorsPatient();
                    break;
                case 2:
                    bookAppointment();
                    break;
                case 3:
                    viewAppointmentStatus();
                    break;
            }
        } while (ch != 4);
    }

    static void viewDoctorsPatient() {
        new PatientDAO().viewDoctorsPatient();
    }

    static void bookAppointment() {
        List<Doctor> list = new PatientDAO().doctorsAvailable();
        if (list.isEmpty()) {
            System.out.println("No Doctors Available");
            return;
        }
        int i = 1;
        for (Doctor d : list) {
            System.out.println(i + ". " + d.getName() + " - " + d.getSpecialization());
            i++;
        }
        System.out.print("Select Doctor: ");
        int ch = sc.nextInt();
        sc.nextLine();

        String docUsername = list.get(ch - 1).getUsername();
        int result = new PatientDAO().bookAppointment(patientUsernameLoggedIn, docUsername);
        if (result > 0) {
        	System.out.println("Appointment booked");
        }
        else System.out.println("Failed");
    }

    static void viewAppointmentStatus() {
        new PatientDAO().viewAppointmentStatus(patientUsernameLoggedIn);
    }

    static void patientRegistration() {
        System.out.print("Enter Name: ");
        String name = sc.nextLine();
        System.out.print("Enter Password: ");
        String pass = sc.nextLine();
        System.out.print("Enter Phone: ");
        long phone = sc.nextLong();
        sc.nextLine();
        Patient p = new Patient(name, pass, phone);
        int res = new PatientDAO().registerPatient(p);
        if(res > 0) {
        	System.out.println("Registered");
        }
        else System.out.println("Error");
    }
}
