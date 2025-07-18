package Hospital_Management.DTO;

public class Doctor {
    private String name;
    private String specialization;
    private String username;
    private String password;

    public Doctor(String name, String specialization, String username, String password) {
        this.name = name;
        this.specialization = specialization;
        this.username = username;
        this.password = password;
    }

    public String getName(){
    	return name;
    }
    
    public String getSpecialization(){
    	return specialization;
    }
    
    public String getUsername(){
    	return username;
    }
    
    public String getPassword(){
    	return password;
    }
}
