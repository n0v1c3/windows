package com.example.androidworld;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;

/** Application's main activity */
public class MainActivity extends Activity {
	private static final String TAG = MainActivity.class.getSimpleName();
	
	/** Run first when application is launched */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		Log.d(TAG, "MainActivity.onCreate Begin...");
		super.onCreate(savedInstanceState);
		
		//Request to turn the title OFF
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		
		//Make application full screen
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,  WindowManager.LayoutParams.FLAG_FULLSCREEN);
		
		//Set MainPanel as the View
		setContentView(new MainPanel(this));
		Log.d(TAG, "MainActivity.onCreate Complete...");
	}
	
	/** Log onDestroy */
	@Override
	protected void onDestroy() {
		Log.d(TAG, "Destroying MainActivity...");
		super.onDestroy();
	}

	/** Log onStop */
	@Override
	protected void onStop() {
		Log.d(TAG, "Stopping MainActivity...");
		super.onStop();
	}
}