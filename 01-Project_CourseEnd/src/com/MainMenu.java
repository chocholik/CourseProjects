package com;

import java.util.Scanner;

public class MainMenu {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int choice = 0;
		char letter;
		String input;
		String file;
		BusinessOperation bo = new BusinessOperation();
		System.out.println("Welcome to Virtual Key for Your Repositories program from Jan Chochole (jan.chochole@vodafone.com)");
	do {
		System.out.println("Please make a choice:");
		System.out.println("1: Retrieving the file names in an ascending order   "+"2: Business-level operations (add/delete/search file)   "+"3: Close program");
		input = sc.next();
		letter = input.charAt(0);
		choice = (int)letter;
		switch (choice) {
			case 49:
				System.out.printf("%nList of files: ");
				System.out.println(bo.print());
				break;
			case 50:System.out.println("Business menu");
				do {
					System.out.println("a: Add new file   "+"d: Delete file   "+"s: Search file   "+"m:Go to prevorious menu");
					input = sc.next().toLowerCase();
					letter = input.charAt(0);
					choice = (int)letter;
					switch (choice) {
					case 97: System.out.print("Adding new file, please write the name of file: ");
						file = sc.next().strip().toLowerCase();
						System.out.println(bo.add(file));
						break;
					case 100: System.out.printf("!!!Removing file!!!%nWhat do want delete? ");
						file = sc.next().strip().toLowerCase();
						System.out.println(bo.remove(file));
						break;
					case 115: System.out.printf("Searching file...%nWhat do you want find? ");
						String search = sc.next().strip().toLowerCase();
						System.out.println(bo.search(search).toLowerCase());
						break;
					case 109: 
						break;
					default: System.out.println("Bad choice, please select A for add, D for delete, S for search and M to prevorious menu");
						break;
					}
					System.out.printf("%n");
				} while (choice!=109);
				break;
			case 51:System.out.println("Thank you and bye!");
				break;
			default:
				System.out.println("Bad choice, please select from range 1 - 3.");
				break;
			}
			
			
		System.out.printf("%n");
		} 
		while (choice!=51);
	sc.close(); //close the scanner 
	}
}
