package com.example.androidworld;

import android.graphics.Canvas;
import android.util.Log;
import android.view.SurfaceHolder;

public class MainThread extends Thread{
	private static final String TAG = MainThread.class.getSimpleName();
	
	private SurfaceHolder surfaceHolder;
	
	private MainPanel mainPanel;
	
	private boolean running;
	public void setRunning(boolean running) {
		this.running = running;
	}
	
	public MainThread(SurfaceHolder surfaceHolder, MainPanel mainPanel) {
		super();
		this.surfaceHolder = surfaceHolder;
		this.mainPanel = mainPanel;
	}
	
	private final static int MAX_FPS = 10;
	private final static int MAX_FRAME_SKIPS = 5;
	private final static int FRAME_PERIOD = 1000 / MAX_FPS;
	
	@Override
	public void run() {
		Log.d(TAG, "Starting application loop...");
		
		Canvas canvas;
		
		long beginTime;
		long timeDiff;
		int sleepTime;
		int framesSkipped;
		
		sleepTime = 0;
		
		while(running) {
			//Application Loop
			canvas = null;
			
			try {
				canvas = this.surfaceHolder.lockCanvas();
				synchronized (surfaceHolder) {
					beginTime = System.currentTimeMillis();
					framesSkipped = 0;
					
					//this.mainPanel.update();
					this.mainPanel.render(canvas);
					
					timeDiff = System.currentTimeMillis() - beginTime;
					
					sleepTime = (int) ((FRAME_PERIOD + sleepTime) - timeDiff);
					
					if (sleepTime > 0) {
						try {
							Thread.sleep(sleepTime);
							sleepTime = 0;
						} catch (InterruptedException e) {}
					}
					
					while (sleepTime < 0 && framesSkipped < MAX_FRAME_SKIPS) {
						//this.mainPanel.update();
						sleepTime += FRAME_PERIOD;
						framesSkipped++;
					}
				} 
			} finally {
				if (canvas != null) {
					surfaceHolder.unlockCanvasAndPost(canvas);
				}
			}
		}
		Log.d(TAG, "Ending application loop...");
	}
}
