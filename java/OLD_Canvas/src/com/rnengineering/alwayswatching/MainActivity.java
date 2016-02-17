package com.rnengineering.alwayswatching;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;

/**
 * Main activity for the software bundle
 * @author Travis Gall
 */
public class MainActivity extends Activity {
	private static final String TAG = MainActivity.class.getSimpleName();
	
	/** 
	 * Run first when application is launched
	 * @author Travis Gall
	 * @param savedInstanceState Load from previous run state
	 */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//Debug
		Log.d(TAG, "MainActivity.onCreate Start...");
		
		//Request to turn the title OFF
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		
		//Make application full screen
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,  WindowManager.LayoutParams.FLAG_FULLSCREEN);
		
		//Set MainPanel as the View
		setContentView(new MainPanel(this));
		
		//Debug
		Log.d(TAG, "MainActivity.onCreate Finish...");
	}
	
	@Override
	protected void onDestroy() {
		Log.d(TAG, "Destroying MainActivity...");
		super.onDestroy();
	}

	@Override
	protected void onStop() {
		Log.d(TAG, "Stopping MainActivity...");
		super.onStop();
	}
}
