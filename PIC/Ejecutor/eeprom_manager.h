#ifndef _EEPROM_MANAGER
#define _EEPROM_MANAGER

unsigned int read_eeprom( char addrh, char addr);
void write_eeprom(char addrh,char addr, char datoh ,char dato);

#endif
