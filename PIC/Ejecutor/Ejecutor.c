#include "eeprom_manager.c"
#include "uart_manager.c"
void main() {
   unsigned char * trama[25] = {0};
   unsigned char size = 0, j = 0, check = 0;
   TRISB=0X00;
   PORTB=0X00;
   while (1) {
    check = 0;
    if(UART1_Data_Ready()){
     check = readData();
     if(check == ':'){
      check = 0;
      trama[0] = ascii2hex();
      size = trama[0] + 0x05;
      for(j = 1; j<size; j++){
        trama[j] = ascii2hex();
      }
      for(j = 0; j<size-1; j++)
      {
        check += trama[j];
      }
      check = ~check + 1;
      check = (check == (unsigned char)trama[size-1]);
      check ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
      PORTB = 0x00;
      if(!trama[0] && check) {
       PORTB = 0xFF;
       UART1_Write_Text("STR\n");
       asm {
        goto 0x500;
       }
      }
     }
    }
   }
}