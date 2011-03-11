package com.artwalk;

import java.io.InputStream;
import java.lang.reflect.Type;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class ArtPiecesListView extends Activity {
	/** Called when the activity is first created. */

	LayoutInflater mFactory;

	private class ArtPieceAdapter extends ArrayAdapter {

		List<ArtPiece> mArtPieces;

		public ArtPieceAdapter(Context context,int resource, int textViewResourceId,
				List objects) {
			super(context, resource, textViewResourceId, objects);
			mArtPieces = objects;


		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {		
			View ret = mFactory.inflate(R.layout.art_piece_view_cell, parent, false);
			ArtPiece thisArtPiece = mArtPieces.get(position);
			String url;
			if(thisArtPiece.media.size()!=0)
			{
				url = thisArtPiece.media.get(0).url;
				ImageView image = (ImageView)ret.findViewById(R.id.thumbnail);
				Drawable drawable = LoadImageFromWebOperations(url);
				image.setImageDrawable(drawable);
			}
			TextView text = (TextView)ret.findViewById(R.id.title);
			text.setText(thisArtPiece.title);
			return ret;
		}

		private Drawable LoadImageFromWebOperations(String url)

		{
			try
			{
				InputStream is = (InputStream) new URL(url).getContent();
				Drawable d = Drawable.createFromStream(is, "src name");
				return d;
			}catch (Exception e) {
				System.out.println("Exc="+e);
				return null;
			}
		}
		
			}


	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		mFactory = LayoutInflater.from(this);

		WebService webService = new WebService("http://75.101.166.190/recent/");
		Map<String,String> params = new HashMap<String,String>();
		params.put("mode", "json");
		String response = webService.webGet("", params);

		ListView artPieceList;
		artPieceList = (ListView)findViewById(R.id.art_piece_list);

		try
		{
			//Parse Response into our object
			Type collectionType = new TypeToken<List<ArtPiece>>(){}.getType();
			List<ArtPiece> artPieces = new Gson().fromJson(response, collectionType);

			ArtPieceAdapter adapter = new ArtPieceAdapter(this, R.layout.art_piece_view_cell, R.id.title, artPieces);
			artPieceList.setAdapter(adapter);
		}
		catch(Exception e)
		{
			Log.d("Error: ", e.getMessage());
		}

		Button mapButton = (Button)findViewById(R.id.map_view_button);
		mapButton.setOnClickListener(new Button.OnClickListener() {

			@Override
			public void onClick(View v) {
				ArtPiecesListView.this.startActivity(new Intent(ArtPiecesListView.this, ArtPiecesMapView.class));
			
			}
			

		});



	}
}