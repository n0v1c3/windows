package com.example.bigbrother;

import android.util.Log;

public class CameraThread extends Thread {
	/** Debug Log: Class Name */
	private static final String TAG = CameraThread.class.getSimpleName();
	
	private boolean running;
	private CameraSurfaceView cameraSurfaceView;
	
	public CameraThread(CameraSurfaceView cameraSurfaceView) {
		super();
		this.cameraSurfaceView = cameraSurfaceView;
		this.running = false;
	}
	
	public void setRunning(boolean running) {
		this.running = running;
	}
	
	public boolean getRunning() {
		return this.running;
	}
	
	@Override
	public void run() {
		while(this.running) {
			synchronized(cameraSurfaceView) {
				try {
					Thread.sleep(1500, 0);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Log.d(TAG, "CameraThread.run(): Loop...");
				this.cameraSurfaceView.takePicture(cameraSurfaceView);
			}
		}
	}
}
