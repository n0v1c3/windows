/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.util.*;

public class StateController {
    private static final int FPS = 12;
    private static final int MIN_LENGTH = 10;
    private static final int YELLOW_LENGTH = 5;

    private IntersectionState state;
     private IntersectionState nextState;

    private Vector lights;
    private int stateLength;
    private int FPScounter;
    private int secondCounter;

    private int NSFlow;
    private int EWFlow;
    private int NSProcessRate;
    private int EWProcessRate;
    private int NSBuildUp;
    private int EWBuildUp;

    public StateController(Vector lights) {
        this.lights = lights;
        FPScounter = 0;
        secondCounter = 0;
        stateLength = MIN_LENGTH;

        NSFlow = 0; EWFlow = 0;
        NSProcessRate = 0; EWProcessRate = 0;
        NSBuildUp = 0;
        EWBuildUp = 0;

        nextState = new IntersectionState(IntersectionState.NS_YELLOW, lights);
        state = new IntersectionState(IntersectionState.NS_GREEN, lights);
    }

    public void update() {
        Light NLight = (Light) lights.elementAt(0);
        Light ELight = (Light) lights.elementAt(1);
        Light SLight = (Light) lights.elementAt(2);
        Light WLight = (Light) lights.elementAt(3);

        if (FPScounter == FPS) {
            FPScounter = 0;
            secondCounter++;
            NSFlow += NLight.getNumNewCars();
            NSFlow += SLight.getNumNewCars();
            EWFlow += ELight.getNumNewCars();
            EWFlow += WLight.getNumNewCars();
        }
        FPScounter++;

        if (secondCounter == stateLength) {
            switchStates();
            secondCounter = 0;
        }
    }

    public void switchStates() {
        Light testLight = (Light)lights.elementAt(0);
        int ProcessRate, BuildRate;

        if (state.getState() == IntersectionState.NS_GREEN) {
            state.setState(IntersectionState.NS_YELLOW);
            stateLength = YELLOW_LENGTH;
        }
        
        else if (state.getState() == IntersectionState.NS_YELLOW) {
            state.setState(IntersectionState.NS_RED);
            stateLength = MIN_LENGTH;
        }
        
        else if (state.getState() == IntersectionState.NS_RED) {
            state.setState(IntersectionState.EW_YELLOW);
            stateLength = YELLOW_LENGTH;
        }

        else {
            state.setState(IntersectionState.NS_GREEN);
            stateLength = MIN_LENGTH;
        }
    }

    private void updateNS() {

    }

    private void updateEW() {

    }
}
