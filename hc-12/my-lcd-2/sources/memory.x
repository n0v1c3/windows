OUTPUT_FORMAT("elf32-m68hc11", "elf32-m68hc11",
            "elf32-m68hc11")
OUTPUT_ARCH(m68hc11)
ENTRY(_start)
SEARCH_DIR(C:\Program Files\GNU\lib\gcc-lib\m6811-elf\3.3.5-m68hc1x-20050129\mshort)

MEMORY
{
  ioports (!x)  : org = 0x1000, l = 0x400
  eeprom  (!i)  : org = 0xB600, l = 0x200
  data    (rwx) : org = 0x8800, l = 0x800
  text    (rx)  : org = 0x9000, l = 0x6000
}

PROVIDE (_stack = 0xff);
