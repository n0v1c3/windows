/* Example program for the Wytec Dragon 12 (MC9S12DP256C) */

#define __DECL__6812DP256_H__

#include <hidef.h>
#include <6812dp256.h>

#include "pll.h"								/* defines _BUSCLOCK, sets bus frequency to _BUSCLOCK MHz */
#include "lcd.h"                /* LCD_init(), writeLine() */


void main(void) {

  /* set system clock frequency to _BUSCLOCK MHz (24 or 4) */
  PLL_Init();

  /* set port B as output (LEDs) */
  DDRB  = 0xff;       // Port B is output
  PORTB = 0x55;       // switch on every other LED

  /* initialize LCD display */
  LCD_init();

  /* Initialisation complete, now write stuff */
  writeLine("Hello World!    ", 0);  // top line
  writeLine("I have a plan!  ", 1);  // bottom line

  /* forever */
  for(;;){}
}

