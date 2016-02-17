/*
 * Written By: Travis Gall
 * Class Description:
 */

package display;

import java.awt.*;

public class BGHandler {
    private Component component;
    private Image BGImage;

    public BGHandler(Component component, Image BGImage) {
        this.component = component;
        this.BGImage = BGImage;
    }

    /*
     *  Addjust the drawing location to account for the insets of the component
     */
    private Point getDrawLocation() {
        Frame frame = (Frame)component;
        int x = frame.getInsets().left;
        int y = frame.getInsets().top;
        return new Point(x, y);
    }

    public void drawBGImage(Graphics g) {
        Point location = getDrawLocation();
        g.drawImage(BGImage, location.x, location.y, component);
    }

}
