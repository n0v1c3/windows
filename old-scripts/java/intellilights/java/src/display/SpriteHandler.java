/*
 * Written By: Travis Gall
 * Class Description:
 */

package display;

import java.awt.*;
import java.util.*;

public class SpriteHandler{
    private Vector spriteVector;
    private Component component;

    public SpriteHandler(Component component) {
        spriteVector = new Vector();
        this.component = component;
    }

    public void setSprites(Vector spriteVector) {
        this.spriteVector = spriteVector;
    }

    public void drawSprites(Graphics g) {
        Sprite sprite;
        Frame frame = (Frame) component;
        for (int i = 0; i < spriteVector.size(); i++) {
            sprite = (Sprite) spriteVector.elementAt(i);
            g.drawImage(sprite.getImage(), sprite.getX() + frame.getInsets().left, sprite.getY() + frame.getInsets().top, component);
        }
    }
}
