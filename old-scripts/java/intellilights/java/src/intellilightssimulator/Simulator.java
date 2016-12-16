/*
 * Written By: Travis Gall
 * Class Description: This class is the runnable class with the main program
 * loop within the run() function. All of the major elements of the project
 * are implemented here.
 */

package intellilightssimulator;

//Packages within the project
import display.*;
import intersection.*;

//Built in packages
import java.util.*;
import javax.swing.*;

public class Simulator implements Runnable {
    public static final int FPS = 10;
    //Delay for 10 FPS
    private static final int MSDELAY = 1000/FPS;

    //Components of the simulator
    private GUI display;
    private Intersection intersection;

    //Program thread for the run() function
    private Thread runThread;

    public Simulator() {
        //Create a new GUI with the following background
        display = new GUI(new ImageIcon("C:\\Documents and Settings\\Travis\\Desktop\\Final Project\\Simulation Software\\Intelli Lights - Simulator\\Images\\Road2.JPG").getImage());

        //Create a new Intersection
        intersection = new Intersection(display);

        //Initialize and start the program thread
        runThread = new Thread(this);
        runThread.start();
    }

    /*
     * Program starts here
     */
    @Override
    public void run() {
        Vector spriteVector;

        long time = System.currentTimeMillis();
        int oneSecondDelay = 0;

        int random;

       // Endless program loop
        while (true) {
            
            

            //One second delay
            if (oneSecondDelay == 10) {
                System.out.println(intersection.getLight().getState());
                oneSecondDelay = 0;
                random = (int) (1+Math.random()*49);
                if (random < 50)
                    intersection.addCar(Direction.NORTH);
                if (random < 50)
                    intersection.addCar(Direction.EAST);
                if (random <50)
                    intersection.addCar(Direction.WEST);
                if (random < 50)
                    intersection.addCar(Direction.SOUTH);
                
            }
            oneSecondDelay++;

            //Get the car and light sprites from the intersection
            spriteVector = intersection.getSprites();
            //Update the intersection and the display
            intersection.update();
            display.update(spriteVector);

            //Delay
            try {
                time += MSDELAY;
                Thread.sleep(Math.max(0,time -
                System.currentTimeMillis()));
            }catch (InterruptedException e) {
                System.out.println(e);
            }//end catch

        }
    }//End Program
}
