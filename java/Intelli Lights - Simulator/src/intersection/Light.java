/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.util.*;


public class Light {

    private Vector carList;
    private LightState state;

    private Direction direction;

    private int newCars;
    private int numProcessed;

    public Light(Direction direction) {
        carList = new Vector();
        this.direction = direction;
        state = new LightState(LightState.GREEN);
        newCars = 0;
        numProcessed = 0;
    }

    public char getState() {
        return state.getState();
    }

    public Direction getDirection() {
        return direction;
    }

    public void setState(LightState state) {
        this.state = state;
    }

    public int getNumNewCars() {
        int temp = newCars;
        newCars = 0;
        return temp;
    }

    public int getNumCarProcessed() {
        int temp = numProcessed;
        numProcessed = 0;
        return temp;
    }

    public void update(Vector carList) {
        //Compare the old cars with the new cars to update counts
        for (int i = 0; i < carList.size(); i++) {
            if (!(this.carList.contains(carList.elementAt(i))))
                newCars += 1;
        }
        numProcessed = (this.carList.size() - carList.size()) + newCars;
        this.carList = carList;
    }
}
