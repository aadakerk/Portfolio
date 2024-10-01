package dtp;

public class InRelationshipPerson extends Person {

	String partnersName;
	
	// constructor that takes said parameters and then calls the superclass constructor
	public InRelationshipPerson(String name, String age, String sex, String status, String partnersName) {
		super(name, age, sex, status);
		this.partnersName = partnersName;
	}

	// getters and setters
	public String getPartnersName() {
		return partnersName;
	}

	public void setPartnersName(String partnersName) {
		this.partnersName = partnersName;
	}

	@Override
	public String toString() {
		String print = String.format(
				"Name: %s\t Age: %s\tSex: %s\t Relationship Status: %s\t Partner: %s ", 
				super.getName(),super.getAge(),super.getSex(), super.getStatus(), getPartnersName());
		return print;
	}
}
