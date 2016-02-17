/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

import java.util.*;

public class IntersectionState {
    public static final int NS_GREEN = 1;
    public static final int NS_YELLOW = 2;
    public static final int NS_RED = 3;
    public static final int EW_YELLOW = 4;

    private int state;
    private Vector lights;

    public IntersectionState(int state, Vector lights) {
        this.state = state;
        this.lights = lights;

        updateLights();
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
        updateLights();
    }

    private void updateLights() {
        Light[] lightArray = new Light[4];

        for (int i = 0; i < lightArray.length; i++) {
            lightArray[i] = (Light) lights.get(i);
        }

        switch (state) {
            case NS_GREEN:  lightArray[0].setState(new LightState(LightState.GREEN));
                            lightArray[2].setState(new LightState(LightState.GREEN));
                            lightArray[1].setState(new LightState(LightState.RED));
                            lightArray[3].setState(new LightState(LightState.RED)); break;

            case NS_YELLOW: lightArray[0].setState(new LightState(LightState.YELLOW));
                            lightArray[2].setState(new LightState(LightState.YELLOW));
                            lightArray[1].setState(new LightState(LightState.RED));
                            lightArray[3].setState(new LightState(LightState.RED)); break;
                            
            case NS_RED:    lightArray[0].setState(new LightState(LightState.RED));
                            lightArray[2].setState(new LightState(LightState.RED));
                            lightArray[1].setState(new LightState(LightState.GREEN));
                            lightArray[3].setState(new LightState(LightState.GREEN)); break;

            case EW_YELLOW: lightArray[0].setState(new LightState(LightState.RED));
                            lightArray[2].setState(new LightState(LightState.RED));
                            lightArray[1].setState(new LightState(LightState.YELLOW));
                            lightArray[3].setState(new LightState(LightState.YELLOW)); break;
        }
    }

}
