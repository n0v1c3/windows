/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.util.*;
import java.awt.*;

public class Driver {
    private int SAFE_DISTANCE;
    private int START_LAG;

    private static final int GOAL_SPEED = 17;
    private static final int STOP_SPEED = 1;
    private static final int ACCELERATE = 1;

    private Car car;

    public Driver(Car car) {
        SAFE_DISTANCE =(((int) (3+Math.random()*5)));
        START_LAG =(int) (2+Math.random()*5);
        this.car = car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public void update() {
        int acceleration = 0;
        int random = (int) (1 + Math.random()*2);

        acceleration = react(car.getDirection().getLight());

        if (acceleration == 0) {
            Vector carList = car.getDirection().getCars();
            Car tempCar;

            for (int i = 0; i < carList.size(); i++) {
                tempCar = (Car) carList.elementAt(i);
                if (acceleration == 0) {
                    acceleration = react(tempCar);
                    if (acceleration != 0) {
                        break;
                    }
                }
            }
        }

        if (acceleration == 0) {
            if (car.getSpeed() < GOAL_SPEED)
                acceleration = ACCELERATE;
            else if (car.getSpeed() > GOAL_SPEED)
                acceleration = -STOP_SPEED;
        }
        car.accelerate(acceleration);
    }

    public Car getCar() {
        return car;
    }

    private int stopDistance() {
        int stopDistance = car.getSpeed()+5;// + SAFE_DISTANCE;
        int speed = car.getSpeed();

        while (speed > 0) {
            stopDistance += speed;
            speed-=STOP_SPEED;
        }

        if (stopDistance < SAFE_DISTANCE)
            stopDistance = SAFE_DISTANCE;

        return stopDistance;
    }

    private Rectangle calcStopZone() {
        int x, y, width, height;
        Point location = car.getLocation();

        switch(car.getDirection().getDirection()) {
            case Direction.NORTH:   x = location.x;
                                    y = (location.y-1)-stopDistance();
                                    width = car.getWidth();
                                    height = stopDistance(); break;

            case Direction.EAST:;   x = location.x + 1 + car.getWidth();
                                    y = location.y;
                                    width = stopDistance();
                                    height = car.getHeight(); break;

            case Direction.SOUTH:   x = location.x;
                                    y = location.y + car.getHeight() + 1;
                                    width = car.getWidth();
                                    height = stopDistance(); break;

            case Direction.WEST:    x = (location.x - 1) - stopDistance();
                                    y = location.y;
                                    width = stopDistance();
                                    height = car.getHeight(); break;
            default : x=0; y=0; width=0; height=0;
        }

        return new Rectangle(x, y, width, height);
    }

    private int react(Car car) {
        if (calcStopZone().intersects(car.getArea())) {
            if (car.getSpeed() <= this.car.getSpeed()+ START_LAG)
                return -STOP_SPEED;
        }

        return 0;
    }

    /*
     * Returns the speed at which to slow the car down at based upon the lights
     */

    private int react(Light light) {
        Rectangle stopZone = calcStopZone();

        if (stopZone.intersects(Intersection.MIDDLE_ZONE)) {
            switch (light.getState()) {
                case LightState.RED : return -STOP_SPEED;
                case LightState.YELLOW :return setYellowSpeed();
            }
        }

        return 0;
    }

    private int setYellowSpeed() {
        if (car.getArea().intersects(Intersection.MIDDLE_ZONE))
            return 0;
        return -STOP_SPEED;
    }
}
