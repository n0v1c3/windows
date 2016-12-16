/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.awt.*;
import java.util.*;

public class Direction {
    //CONSTANTS
    public static final char NORTH = 'N';
    public static final char EAST = 'E';
    public static final char SOUTH = 'S';
    public static final char WEST = 'W';

    //Given variables
    private char direction;

    //Calculated variables
    private Point motionVector;
    private Point lightLocation;
    private Rectangle stopLine;
    private Light light;
    private Lane[] lanes;

    //==========================================================================Direction(char) Constructor
    public Direction(char direction) {
        if (setDirection(direction))
            this.direction = direction;

        light = new Light(this);
        lanes = new Lane[2];

        createLanes();
    }
    //==========================================================================END Direction(char) Constructor

    //==========================================================================Public Functions

    public char getDirection() {
        return direction;
    }

    public Point getMotionVector() {
        return motionVector;
    }

    public Vector getCars() {
        Vector tempVector = new Vector();

        //Loop here when udjustable lanes inserted
        tempVector.addAll(lanes[0]);
        tempVector.addAll(lanes[1]);

        return tempVector;
    }

    public Light getLight() {
        return light;
    }

    public void addCar(Car car) {
        car.setDirection(this);
        lanes[(int) (1+Math.random()*10)%2].addCar(car);
    }

    public void removeCar(Car car) {
        lanes[0].removeCar(car);
        lanes[1].removeCar(car);
    }

    public void update() {
        light.update(getCars());
        lanes[0].update();
        lanes[1].update();
    }

    //==========================================================================Private Functions

    private void createLanes() {
        Point startPoint = new Point();
        Point laneWidth = new Point();
        int width = Lane.getLaneWidth();

        switch (direction) {
            case NORTH: startPoint.setLocation(300 + Lane.getLineWidth()*2, 610);
                        laneWidth.setLocation(width + Lane.getLineWidth(), 0);  break;

            case EAST:  startPoint.setLocation(-30, 300 + Lane.getLineWidth()*2);
                        laneWidth.setLocation(0, width + Lane.getLineWidth());  break;

            case SOUTH: startPoint.setLocation(300 - width + Lane.getLineWidth()/2, -30);
                        laneWidth.setLocation(-width - Lane.getLineWidth(), 0);  break;

            case WEST:  startPoint.setLocation(610, 300 - width + Lane.getLineWidth()/2);
                        laneWidth.setLocation(0, -width - Lane.getLineWidth());  break;

            default :   startPoint.setLocation(0,0);
                        laneWidth.setLocation(0,0); break;
        }

        lanes[0] = new Lane(startPoint);
        int x = (int) startPoint.getX() + laneWidth.x;
        int y = (int) startPoint.getY() + laneWidth.y;
        lanes[1] = new Lane(new Point(x,y));

    }

    //Set the motionVector, returns false for invalid directions
    private boolean setDirection(char direction) {
        switch (Character.toUpperCase(direction)) {
            case NORTH: motionVector = new Point(0,-1); return true;
            case EAST: motionVector = new Point(1,0); return true;
            case SOUTH: motionVector = new Point(0,1); return true;
            case WEST: motionVector = new Point(-1,0); return true;
            default : return false;
        }
    }
}

//==============================================================================END Direction Class