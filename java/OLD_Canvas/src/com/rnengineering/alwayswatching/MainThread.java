package com.rnengineering.alwayswatching;

import android.graphics.Canvas;
import android.util.Log;
import android.view.SurfaceHolder;

/**
 * Projects main thread, contains primary loop
 * @author Travis Gall
 *
 */
public class MainThread extends Thread{
	private static final String TAG = MainActivity.class.getSimpleName();
	
	private static final int FPS_MAX = 50;
	private static final int FPS_MAX_SKIPS = 5;
	private static final int FPS_MILLIS = 1000;
	private static final int FPS_PERIOD = FPS_MILLIS / FPS_MAX;
	
	private SurfaceHolder surfaceHolder;
	private MainPanel mainPanel;
	private Canvas canvas;
	
	private boolean running;
	
	/**
	 * @author Travis Gall
	 */
	public MainThread(SurfaceHolder surfaceHolder, MainPanel mainPanel) {
		super();

		//Debug
		Log.d(TAG, "MainThread() Start...");
		
		this.surfaceHolder = surfaceHolder;
		this.mainPanel = mainPanel;
		
		this.running = false;
		
		//Debug
		Log.d(TAG, "MainThread() Finish...");
	}
	
	@Override
	public void run() {
		//Debug
		Log.d(TAG, "MainThread().run() Start...");
		
		long beginTime;
		long timeDiff;
		int sleepTime;
		int framesSkipped;
		
		sleepTime = 0;
		
		while(running) {
			canvas = null;
			
			try {
				canvas = surfaceHolder.lockCanvas();
				synchronized(surfaceHolder) {
					beginTime = System.currentTimeMillis();
					framesSkipped = 0;
					
					mainPanel.update();
					mainPanel.render(canvas);
					
					timeDiff = System.currentTimeMillis() - beginTime;
					
					sleepTime = (int) ((FPS_PERIOD + sleepTime) - timeDiff);//(FRAME_PERIOD-timeDiff);//((FRAME_PERIOD + sleepTime) - timeDiff);
					
					if (sleepTime > 0) {
						try {
							Thread.sleep(sleepTime);
							sleepTime = 0;
						} catch (InterruptedException e) {}
					}
					
					while (sleepTime < 0 && framesSkipped < FPS_MAX_SKIPS) {
						mainPanel.update();
						sleepTime += FPS_PERIOD;
						framesSkipped++;
					}
				}
			} finally {
				if (canvas != null) {
					surfaceHolder.unlockCanvasAndPost(canvas);
				}
			}
		}
		
		//Debug
		Log.d(TAG, "MainThread().run() Finish...");
	}
	
	public void setRunning(boolean running) {
		this.running = running;
	}
	
	public boolean getRunning() {
		return this.running;
	}
}
