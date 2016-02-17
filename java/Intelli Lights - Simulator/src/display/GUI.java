/*
 * Written By: Travis Gall
 * Class Description: Used to display a background and a Vector of sprites onto
 * the screen.
 */

package display;

//Built in packages
import java.awt.*;
import java.awt.event.*;
import java.util.*;
import javax.swing.*;
import java.applet.*;

public class GUI extends Frame {
    //Constants
    private static final Image imageIcon = new ImageIcon("C:\\Documents and Settings\\Travis\\Desktop\\Final Project\\Simulation Software\\Intelli Lights - Simulator\\Images\\ImageIcon.GIF").getImage();
        //Used to center the frame on the screen
        private static final int LOCATION_X = 334;
        private static final int LOCATION_Y = 50;

    //Given variables
    private Image BGImage;

    //Components of the GUI
    private BGHandler bgHandler;
    private SpriteHandler spriteHandler;
    private Graphics offScreenGraphicsCtx;
    private Image offScreenImage;

    private JButton jButton;


    GraphicsEnvironment graphEnv = GraphicsEnvironment.getLocalGraphicsEnvironment();
    GraphicsDevice graphDevice = graphEnv.getDefaultScreenDevice();
    GraphicsConfiguration graphicConf = graphDevice.getDefaultConfiguration();



    public GUI(Image BGImage) {
        //Create a new background handler with the given background image
        this.BGImage = BGImage;
        bgHandler = new BGHandler(this, BGImage);

        jButton = new JButton("Test");

        //Used to display sprites onto the background
        spriteHandler = new SpriteHandler(this);

        //Calculating the size of the window
        int width = BGImage.getWidth(this);
        int height = BGImage.getHeight(this);

        //Create, initialize and display this frame
        setIconImage(imageIcon);
        setTitle("Intersection V 0.01");
        setVisible(true);
        setSize((width+(this.getInsets().left)), (height+(this.getInsets().top)));
        this.setLocation(334, 50);
        //graphDevice.setFullScreenWindow(this);
        setResizable(false);
        setIgnoreRepaint(true);


        //Initialize the graphics to fit the background
        offScreenImage = createImage(getSize().width, getSize().height);
        offScreenGraphicsCtx = offScreenImage.getGraphics();

        //Events
        addWindowListener(new WindowAdapter() {

            //Exit program on closing
            @Override
            public void windowClosing(WindowEvent e){
                System.exit(0);
            }
        });
    }

    /*
     * Repaint the screen using the update(Graphics g) call function found in
     * the Frame class
     */
    public void update(Vector spriteVector) {
        spriteHandler.setSprites(spriteVector);
        update(offScreenGraphicsCtx);
        repaint();
    }

    /*
     * Override the Frame class update function to draw the background and the
     * sprites onto the Frame
     */
    @Override
    public void update(Graphics g) {
        bgHandler.drawBGImage(g);
        spriteHandler.drawSprites(g);
        
    }
}
