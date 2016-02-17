/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import display.*;

import java.awt.*;
import javax.swing.*;

public class Car extends Sprite{
    private static final String IMAGE_FILE_PATH = new String("C:\\Documents and Settings\\Travis\\Desktop\\Final Project\\Simulation Software\\Intelli Lights - Simulator\\Images\\");
    private static final String IMAGE_TYPE = new String(".GIF");

    private Component component;
    private Direction direction;
    private int color;
    private Driver driver;

    private int speed;

    public Car(Component component) {
        super();
        this.driver = new Driver(this);
        this.component = component;
        speed = 0;
        color = (int)(1+Math.random()*9);
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
        setImage(getCarImage());
    }

    public int getWidth() {
        return getCarImage().getWidth(component);
    }

    public int getHeight() {
        return getCarImage().getHeight(component);
    }

    public Rectangle getArea() {
        if (getWidth() == 0)
            return (new Rectangle(super.getX(), super.getY(), 50, 50));
        return (new Rectangle(super.getX(), super.getY(), getWidth(), getHeight()));
    }

    public Direction getDirection() {
        return direction;
    }

    private Image getCarImage() {
        String imageDirection = new String();
        String color = new String();

        switch(direction.getDirection()) {
            case Direction.NORTH: imageDirection = "North"; break;
            case Direction.EAST: imageDirection = "East"; break;
            case Direction.SOUTH: imageDirection = "South"; break;
            case Direction.WEST: imageDirection = "West"; break;
        }

        if (this.color < 7)
            color = "Blue";
        else color = "Black";
        return new ImageIcon(IMAGE_FILE_PATH + color + imageDirection + IMAGE_TYPE).getImage();
    }

    public int getSpeed() {
        return speed;
    }

    public void accelerate(int acceleration) {
        speed+=acceleration;
        if (speed < 0)
            speed = 0;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public void update() {
        driver.update();
        super.translate(speed*direction.getMotionVector().x, speed*direction.getMotionVector().y);
    }
}
