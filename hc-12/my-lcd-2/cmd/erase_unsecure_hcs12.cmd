// HCS12 Core erasing + unsecuring command file:
// These commands mass erase the chip then program the security byte to 0xFE (unsecured state).

// Evaluate the clock divider to set in ECLKDIV/FCLKDIV registers:

// An average programming clock of 175 kHz is chosen.

// If the oscillator frequency is less than 10 MHz, the value to store
// in ECLKDIV/FCLKDIV is equal to " oscillator frequency (kHz) / 175 ".

// If the oscillator frequency is higher than 10 MHz, the value to store
// in ECLKDIV/FCLKDIV is equal to " oscillator frequency (kHz) / 1400  + 0x40 (to set PRDIV8 flag)".

// Datasheet proposed values:
//
// oscillator frequency     ECLKDIV/FCLKDIV value (hexadecimal)
// 
//  16 MHz            		$49
//   8 MHz            		$27
//   4 MHz            		$13
//   2 MHz             		$9
//   1 MHz             		$4

define CLKDIV 0x49


FLASH MEMUNMAP   // do not interact with regular flash programming monitor

//mass erase flash
wb 0x100 CLKDIV  // set FCLKDIV clock divider
wb 0x103 0       // FCFNG select block 0
wb 0x102 0x10    // set the WRALL bit in FTSTMOD to affect all blocks
wb 0x104 0xa4    // FPROT all protection disabled
wb 0x105 0x30    // clear PVIOL and ACCERR in FSTAT register 
ww 0xD000 0xFFFF // (dummy) write to flash array to buffer address and data
wb 0x106 0x41    // write MASS ERASE command in FCMD register
wb 0x105 0xC0    // clear CBEIF in FSTAT register to execute the command 
wait 10

//mass erase eeprom
wb 0x12  0x01    // set EEPROM at 0-$1000 in INITEE
wb 0x110 CLKDIV  // set ECLKDV clock divider 
wb 0x114 0x88    // EPROT all protection disabled
wb 0x115 0x30    // clear PVIOL and ACCERR in ESTAT register 
ww 0x800 0xFFFF  // (dummy) write to eeprom array to buffer address and data
wb 0x116 0x41    // write MASS ERASE command in ECMD register
wb 0x115 0xC0    // clear CBEIF in ESTAT register to execute the command
wait 10

TARGETRESET

//reprogram Security byte to Unsecure state
wb 0x100 CLKDIV  // set FCLKDIV clock divider
wb 0x103 0       // FCFNG select block 0 
wb 0x104 0xa4    // FPROT all protection disabled
wb 0x105 0x30    // clear PVIOL and ACCERR in FSTAT register  
ww 0xFF0E 0xFFFE // write security byte to "Unsecured" state
wb 0x106 0x20    // write MEMORY PROGRAM command in FCMD register
wb 0x105 0xC0    // clear CBEIF in FSTAT register to execute the command 
wait 10

TARGETRESET

FLASH MEMMAP     // restore regular flash programming monitor
undef CLKDIV

