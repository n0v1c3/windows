// Before loading the commands written below will be executed
// The following commands must be enabled to load in flash with the ICD12
// initialize the flash mechanism
TARGETRESET
FLASH
// select the flash modules
FLASH SELECT
// unprotect the flash modules
FLASH UNPROTECT
// erase the flash modules
FLASH ERASE
// arm the flash for programming
FLASH ARM