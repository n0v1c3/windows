OC = C:/Program Files/GNU/bin/m6811-elf-objcopy
CC = C:/Program Files/GNU/bin/m6811-elf-gcc
RM = C:/Program Files/eGNU/rm.exe

CFLAGS  = -m68hc11 -Os -fno-ident -fno-common -fomit-frame-pointer -mshort -fsigned-char
LDFLAGS = -Wl,-u,-mm68hc11elfb
OCFLAGS = -O srec

CSRCS=isr_vectors.c lcd.c main.c pll.c

OBJS=$(CSRCS:.c=.o)

all:	HelloWorld.elf HelloWorld.s19

$(OBJS): %.o: %.c
	$(CC) $(CFLAGS) -c $<

HelloWorld.elf:	$(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o HelloWorld.elf $(OBJS)

HelloWorld.s19:	HelloWorld.elf
	$(OC) $(OCFLAGS) HelloWorld.elf HelloWorld.s19

clean:
	$(RM) -f HelloWorld.elf
	$(RM) -f HelloWorld.s19
	$(RM) -f HelloWorld.dmp
	$(RM) -f $(OBJS)
