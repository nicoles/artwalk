package com.artwalk;

import java.util.List;

public class ArtPiece {
	int id;
	double latitude;
	double longitude;
	String title;
	List<Artist> artists;
	List<Media> media;	
	

	public String toString() {
		return title;
	}
}


