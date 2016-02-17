/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.awt.*;
import java.util.*;

public class Intersection {
    public static final Rectangle MIDDLE_ZONE = new Rectangle(205,205,190,190);
    public static final Rectangle BOUNDS = new Rectangle(-50,-50, 700, 700);

    private Direction[] direction;

    private StateController stateController;
    private Component component;

    public Intersection(Component component) {
        this.component = component;

        direction = new Direction[4];

        direction[0] = new Direction(Direction.NORTH);
        direction[1] = new Direction(Direction.EAST);
        direction[2] = new Direction(Direction.SOUTH);
        direction[3] = new Direction(Direction.WEST);

        Vector lights = new Vector();
        lights.add(direction[0].getLight());
        lights.add(direction[1].getLight());
        lights.add(direction[2].getLight());
        lights.add(direction[3].getLight());

        stateController = new StateController(lights);
    }

    public Vector getSprites() {
        Vector sprites = new Vector();

        sprites.addAll(getCarSprites());
        sprites.addAll(getLightSprites());

        return sprites;
    }

    private Vector getCarSprites() {
        Vector sprites = new Vector();

        for (int i = 0; i < direction.length; i++) {
            sprites.addAll(direction[i].getCars());
        }
        
        return sprites;
    }

    private Vector getLightSprites() {
        Vector sprites = new Vector();
        return sprites;
    }

    public Light getLight() {
        return direction[0].getLight();
    }

    public void addCar(char direction) {
        Driver driver = new Driver(new Car(component));
        Car car = driver.getCar();
        
        switch (direction) {
            case Direction.NORTH: this.direction[0].addCar(car); break;
            case Direction.EAST: this.direction[1].addCar(car); break;
            case Direction.SOUTH: this.direction[2].addCar(car); break;
            case Direction.WEST: this.direction[3].addCar(car); break;
            default : break;
        }
    }

    private boolean offScreen(Point location) {
        if (location.getX() <= -50 || location.getX() >= 650 || location.getY() <= -50 || location.getY() >= 650) {
            return true;
        }
        return false;
    }

    public void update() {
        stateController.update();
        for (int i = 0; i < direction.length; i++)
            direction[i].update();
    }
}