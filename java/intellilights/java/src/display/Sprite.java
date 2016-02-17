/*
 * Written By: Travis Gall
 * Class Description:
 */

package display;

import java.awt.*;

public class Sprite {

    private Image image;
    private Point location;

    public Sprite() {
        image = null;
        location = new Point(0,0);
    }

    public Sprite(Image image, Point location) {
        this.image = image;
        this.location = new Point(location.getLocation());
    }

    public Image getImage() {
        return image;
    }

    public int getX() {
        return location.x;
    }

    public int getY() {
        return location.y;
    }

    public Point getLocation() {
        return location;
    }

    public void setLocation(Point location) {
        this.location = new Point(location.getLocation());
    }

    public void translate(int dx, int dy) {
        location.translate(dx, dy);
    }

    public void setImage(Image image) {
        this.image = image;
    }
}
