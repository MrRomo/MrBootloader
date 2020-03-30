#include "eeprom_manager.c"
#include "uart_manager.c"
#define dir_offset 0x0500
void main() {
   unsigned char * trama[25] = {0};
   unsigned char size = 0, j = 0, check = 0;
   TRISB=0X00;
   UART1_Init(9600);
   PORTB=0X00;
   while (1) {
    check = 0;
    if(UART1_Data_Ready()){
     check = readData();
     if(check == ':'){
      trama[0] = ascii2hex();
      check = trama[0];
      size = trama[0] + 0x05;
      for(j = 1; j<size; j++){
        trama[j] = ascii2hex();
        check += trama[j];
      }
      check -= trama[size-1];
      check = ~check + 1;
      check = (check == (unsigned char)trama[size-1]);
      check ? write_eeprom(trama) : UART1_Write_Text("BAD\n");
      PORTB = 0x00;
      if(!trama[0] && check) {
       PORTB = 0xFF;
       UART1_Write_Text("STR\n");
       asm {
        goto dir_offset;
       }
      }
     }
    }
   }
}