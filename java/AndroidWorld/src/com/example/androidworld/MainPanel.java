package com.example.androidworld;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

public class MainPanel extends SurfaceView implements SurfaceHolder.Callback {
	private static final String TAG = MainPanel.class.getSimpleName();
	
	private MainThread mainThread;

	private Paint paint;
	private double lastTime;
	private double betweenTime;
	private double thisTime;
	
	public MainPanel(Context context) {
		super(context);
		
		//Add callback to this surface holder to intercept events
		getHolder().addCallback(this);
		
		//Create main loop thread
		mainThread = new MainThread(getHolder(), this);
		paint = new Paint();
		//Set focus to handle events
		setFocusable(true);
	}

	@Override
	public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
		mainThread.setRunning(true);
		mainThread.start();
	}

	@Override
	public void surfaceCreated(SurfaceHolder holder) {
		
	}

	@Override
	public void surfaceDestroyed(SurfaceHolder holder) {
		Log.d(TAG, "Surface is being destroyed...");
		boolean retrySD = true;
		while (retrySD) {
			try {
				mainThread.join();
				retrySD = false;
			} catch (InterruptedException e) {
				//Try again
			}
		}
		Log.d(TAG, "Thread was shut down cleanly...");
	}
	
	@Override
	public boolean onTouchEvent(MotionEvent event) {
		mainThread.setRunning(false);
		return super.onTouchEvent(event);
	}
	
	public void render(Canvas canvas) {
		canvas.drawColor(Color.BLACK);
		
		paint.setStyle(Paint.Style.STROKE);
		paint.setStrokeWidth(1);
		paint.setColor(Color.WHITE);
		paint.setTextSize(30);
		
		thisTime = System.currentTimeMillis();
		betweenTime = thisTime - lastTime;
		lastTime = thisTime;
		
		betweenTime = 1000/betweenTime;
		String text = betweenTime + "";
		
		canvas.drawText(text, 100, 200, paint);
	}
}
