package dtp;

import java.util.ArrayList;

public class DinnerTable {
	
	// data field 
	private ArrayList<Person> guestlist = new ArrayList<>();
	
	// no-arg constructor
	public DinnerTable() throws DinnerTableException {
		this.guestlist = null;
	}
	
	// arg constructor with the arraylist
	public DinnerTable(ArrayList<Person> guestlist) 
			throws DinnerTableException {
		
		int numberOfSinglePeopleLooking = 0;
		for (int i = 0; i < guestlist.size(); i++) {
			if (guestlist.get(i) instanceof SinglePerson) {
				SinglePerson single = (SinglePerson)guestlist.get(i);
				if(single.isLooking().equalsIgnoreCase("y")) { // increases count if the person is looking
					numberOfSinglePeopleLooking++;
				}
			}
		}
		
		this.guestlist = guestlist;
		
		// throws custom exception if number is less or equal to one
		if (numberOfSinglePeopleLooking <= 1) {
			throw new DinnerTableException(numberOfSinglePeopleLooking);
		}
	}

	public ArrayList<Person> getGuestlist() {
		return guestlist;
	}

	public void setGuestlist(ArrayList<Person> guestlist) {
		this.guestlist = guestlist;
	}

	// tosString method
	@Override
	public String toString() {
		// initializing the string
		String printingNames = "";
		
		// prints the objects of the arraylist one at a time 
		for (int i = 0; i < guestlist.size(); i++) {
			printingNames += guestlist.get(i) + "\n";
		}
		return printingNames;
	}		
} 
