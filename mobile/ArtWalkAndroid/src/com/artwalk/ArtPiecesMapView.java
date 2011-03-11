package com.artwalk;

import android.os.Bundle;

import com.google.android.maps.MapActivity;

public class ArtPiecesMapView extends MapActivity {

	@Override
	protected boolean isRouteDisplayed() {
		return false;
	}

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.mapview);
	}
}
