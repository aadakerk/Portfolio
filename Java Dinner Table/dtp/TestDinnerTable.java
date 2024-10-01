// Name: Aada Kerkkonen
// This project is all my own work.
// I have not knowingly allowed others to copy my work.

package dtp;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class TestDinnerTable {

	public static void main(String[] args) {

		boolean continueInput = true;
		
		// making a loop so that the program runs until user decides otherwise
		do {
			try {
				Scanner input = new Scanner(System.in);
				System.out.print("Please enter the name of the guest data file: ");
				String fileName = input.nextLine();
				java.io.File file = new java.io.File(fileName);

				//create an array list that the possible guests are added to 
				ArrayList<Person> possibleList = new ArrayList<Person>();

				try (Scanner input1 = new Scanner(file)) {	
					while(input1.hasNextLine()) {

						String name = input1.next();
						String age = input1.next();
						String sex = input1.next();
						String relationshipStatus = input1.next();
						String looking = input1.next();
						
						// constructs a SinglePerson object if relationship status is single
						if (relationshipStatus.equalsIgnoreCase("s")) {
							SinglePerson person = new SinglePerson(name, age, sex, relationshipStatus, looking);
							
							// adds to the arraylist possibleList
							possibleList.add(person);
						}
						
						// constructs a InRelationshipPerson if the person is not single
						else {
							InRelationshipPerson person = new InRelationshipPerson(
									name, age, sex, relationshipStatus, looking);
							
							// adds to the arraylist possibleList
							possibleList.add(person);
						}
					}

				} catch (FileNotFoundException e) {
					System.out.println("File not found.");
					continue;
				}

				// constructing and then printing the DinnerTable object with the arraylist as a parameter
				DinnerTable possibleGuestList = new DinnerTable(possibleList);
				System.out.println(possibleGuestList);

				// exists program if the user so decides
				System.out.print("Do you want to try another guest file? (Y/N): ");
				String choice = input.nextLine();

				if (choice.equalsIgnoreCase("N")) {
					System.out.println("Bye!");
					continueInput = false;
				}
			}
			
			// catches the possible exception created in the DinnerTable constructor (where it is thrown)
			catch (DinnerTableException ex) {
				System.out.println("Problems with Dinner Table");
				System.out.println("Number of Singles Looking: " + ex.getNumberSinglesLooking());
			} 
			
			// input continues while true
		}while (continueInput);

	}
}