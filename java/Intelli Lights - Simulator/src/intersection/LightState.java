/*
 * Written By: Travis Gall
 * Class Description:
 */

package intersection;

public class LightState {
    public static final char RED = 'R';
    public static final char YELLOW = 'Y';
    public static final char GREEN = 'G';

    private char state;

    public LightState(char state) {
        this.state = state;
    }

    public char getState() {
        return state;
    }

}
