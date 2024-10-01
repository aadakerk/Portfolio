package dtp;

public class Person {

	// data fieds
	String name;
	String age;
	String sex;
	String status;
	
	// no-arg constructor
	public Person() {
		super();
	}
	
	// constructor with specified parameters
	public Person(String name, String age, String sex, String status) {
		this.name = name;
		this.age = age;
		this.sex = sex;
		this.status = status;
	}

	// getters and setters
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
