/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.util.*;
import java.awt.*;

public class Lane extends Vector {
    private Point startPoint;
    private static final int laneWidth = 31;
    private static final int lineWidth = 6;
    private Vector buildUp;

    public Lane(Point startPoint) {
        this.startPoint = startPoint;
        buildUp = new Vector();
    }

    public static int getLaneWidth() {
        return laneWidth;
    }

    public static int getLineWidth() {
        return lineWidth;
    }

    public void addCar(Car car) {
        car.setLocation(startPoint);
        if (isClear (car)) {
            add(car);
        }
        else buildUp.add(car);
    }

    private boolean isClear(Car car) {
        Car tempCar;
        Rectangle testArea = new Rectangle();
        //Car cars = (Car) elementAt(0);
        if (size() > 1) {
            tempCar = (Car) elementAt(size()-1);
            testArea = tempCar.getArea();
            if (testArea.intersects(car.getArea())) {
                return false;
            }
        } else return true;

        

        return true;
    }


    public void removeCar(Car car) {
        remove(car);
    }

    public void update() {
        if (buildUp.size() > 0) {
            Car car = (Car) buildUp.elementAt(0);
            if (isClear(car)) {
                Car newCar = (Car) buildUp.get(0);
                //newCar.setSpeed(car.getSpeed());
                addCar(newCar);

                buildUp.remove(0);
            }
        }


        if (size() > 0) {
            Car car = (Car) elementAt(0);
            if (!(car.getArea().intersects(Intersection.BOUNDS))) {
                remove(car);
            }
            for (int i = 0; i < size(); i++) {
                car = (Car) elementAt(i);
                car.update();
            }
        }

        
    }
}
