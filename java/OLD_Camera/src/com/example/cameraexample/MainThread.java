package com.example.cameraexample;

public class MainThread extends Thread{
	private CameraSurfaceView thePanel;
	private boolean running;
	public MainThread(){
		super();
		while(running){
			try {
			//	thePanel.update(); 
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} finally {
				
			}
		}
	}
	public void setRunning(boolean running) {
		this.running = running;
	}
	
	public boolean getRunning() {
		return this.running;
	}

}
