/* LCD header file (to go with lcd.c) - fw02-05 */

#ifndef _LCD_H_
#define _LCD_H_


/* declare public functions */
void LCD_init(void);
void writeLine(char *string, int line);


#endif /* _LCD_H_ */