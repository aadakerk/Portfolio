package dtp;

public class DinnerTableException extends Exception {
	
	int nOfSinglesLooking = 0;

	// no-arg constructor
	public DinnerTableException() {
		super();
	}
	
	// constructor with specified parameter
	public DinnerTableException(int nOfSinglesLooking) {
		this.nOfSinglesLooking = nOfSinglesLooking;
}

	// getter
	public int getNumberSinglesLooking() {
		return nOfSinglesLooking;
	}

}
