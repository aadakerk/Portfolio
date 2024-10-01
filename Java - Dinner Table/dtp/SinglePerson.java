package dtp;

public class SinglePerson extends Person {

	String isLooking;
	
	// constructor that takes said parameters and then calls the superclass constructor
	public SinglePerson(String name, String age, String sex, String status, String isLooking) {
		super(name, age, sex, status);
		this.isLooking = isLooking;
	}		

	// getters and setters
	public String isLooking() {
		return isLooking;
	}

	public void setLooking(String isLooking) {
		this.isLooking = isLooking;
	}
	
	@Override
	public String toString() {
			String print = String.format(
				"Name: %s\t Age: %s\tSex: %s\t Relationship Status: %s\t IsLooking? %s ", 
				super.getName(), super.getAge(), super.getSex(), super.getStatus(), isLooking());
		return print;
	}
}
