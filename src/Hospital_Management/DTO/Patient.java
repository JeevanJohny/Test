package Hospital_Management.DTO;

public class Patient {
    private String name;
    private String password;
    private long phone;

    public Patient(String name, String password, long phone) {
        this.name = name;
        this.password = password;
        this.phone = phone;
    }

    public String getName(){
    	return name;
    }
    
    public String getPassword(){
    	return password;
    }
    
    public long getPhone(){
    	return phone;
    }
}
