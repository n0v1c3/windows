package com.rnengineering.alwayswatching;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

/**
 * @author Travis Gall
 *
 */
public class MainPanel extends SurfaceView implements SurfaceHolder.Callback {
	private static final String TAG = MainActivity.class.getSimpleName();
	
	private static final int FPS_SAMPLES = 10;
	
	private MainThread mainThread;
	
	private int counter;
	private String counterText;
	
	private Paint paint;

	private double runTimeCurrent;
	private double runTimePrevious;
	private double runTimeDiff;
	private double runTimeTotal;
	private double runTimes[];
	private int runTimeIndex;
	
	/**
	 * @author Travis Gall
	 *
	 */
	public MainPanel(Context context) {
		super(context);

		//Debug
		Log.d(TAG, "MainPanel() Start...");
		
		getHolder().addCallback(this);
		
		mainThread = new MainThread(getHolder(), this);
		
		paint = new Paint();
		
		setFocusable(true);
		
		counter = 0;
		
		runTimeTotal = 1000;
		runTimePrevious = System.currentTimeMillis();
		runTimeIndex = 0;
		runTimes = new double[FPS_SAMPLES];
		
		//Debug
		Log.d(TAG, "MainPanel() Finish...");
	}
	
	public void update() {
		counterText = ++counter + "";
	}
	
	public void render(Canvas canvas) {
		//Refresh screen
		canvas.drawColor(Color.BLACK);

		paint.setStyle(Paint.Style.FILL_AND_STROKE);
		paint.setStrokeWidth(1);
		paint.setColor(Color.WHITE);
		paint.setTextSize(30);

		runTimeCurrent = System.currentTimeMillis();
		runTimeDiff = runTimeCurrent - runTimePrevious;
		runTimePrevious = runTimeCurrent;
		
		runTimeTotal -= runTimes[runTimeIndex];
		runTimes[runTimeIndex] = runTimeDiff;
		runTimeTotal += runTimeDiff;
		if (++runTimeIndex == FPS_SAMPLES)
			runTimeIndex = 0;
		
		double FPS = runTimeTotal / FPS_SAMPLES;
		FPS = 1000/FPS;
		
		String text;
		text = (int)FPS + "";
		canvas.drawText(text, 0, canvas.getHeight(), paint);
		canvas.drawText(counterText, canvas.getWidth()-(counterText.length()*20), canvas.getHeight(), paint);
	
	}
	
	/**
	 * Start mainThread for the first run
	 * @author Travis Gall
	 * @param holder  The SurfaceHolder whose surface has changed. 
	 * @param format  The new PixelFormat of the surface. 
	 * @param width  The new width of the surface. 
	 * @param height  The new height of the surface.
	 */
	@Override
	public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
		//Debug
		Log.d(TAG, "MainPanel.surfaceChanged() Start...");
		
		mainThread.setRunning(true);
		mainThread.start();
		
		//Debug
		Log.d(TAG, "MainPanel.surfaceChanged() Finish...");
	}
	
	/**
	 * @author Travis Gall
	 *
	 */
	@Override
	public void surfaceCreated(SurfaceHolder holder) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void surfaceDestroyed(SurfaceHolder holder) {
		//Debug
		Log.d(TAG, "MainPanel.surfaceDestroyed() Start...");
		boolean retrySD = true;
		while (retrySD) {
			try {
				mainThread.join();
				retrySD = false;
			} catch (InterruptedException e) {
				//Try again
				Log.d(TAG, "MainPanel.surfaceDestroyed() Failed (Try Again)...");
			}
		}
		
		//Debug
		Log.d(TAG, "MainPanel.surfaceDestroyed() Finish...");
	}
}
