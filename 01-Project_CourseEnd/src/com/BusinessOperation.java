package com;

import java.util.Iterator;
import java.util.TreeSet;

public class BusinessOperation {
	private TreeSet<String> ts = new TreeSet<>();
	String message;


	public BusinessOperation() {
		super();
//		ts.add("a.txt");
//		ts.add("aa.txt");
//		ts.add("b.txt");
//		ts.add("baba.pdf");
//		ts.add("babo.xls");
	}
	
	public String add(String file) {
		if (ts.isEmpty()) {
			ts.add(file);
			message = "File "+file+"was added";
		} else {
			if (ts.contains(file)) {
				message = "File exist, you can't add this "+file.toUpperCase();
			} else {
				ts.add(file);
				message = "File "+file+"was added";
			}
		}
		return message;

	}
	
	public String print() {
		if (ts.isEmpty()) {
			return "No files";
		} else {
			return ts.toString();
		}
	}
	
	public String remove(String file) {
		if (ts.contains(file)) {
			ts.remove(file);
			return "File was deleted.";
		} else {
			return "File not found!";
		}
	}
	
	public String search(String search) {
		Iterator<String> ii = ts.iterator();
		TreeSet<String> tsTemp = new TreeSet<>();
		while (ii.hasNext()) {
			String word = ii.next();			
			if (word.toLowerCase().contains(search)) {
				tsTemp.add(word);
			}
		}
		return tsTemp.toString();
	}



}
