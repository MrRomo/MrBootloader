#include "eeprom_manager.c"
#include "uart_manager.c"
void start();
void main() {
   unsigned char * trama[21] = {0};
   unsigned char size = 0x00;
   unsigned char byteRecv = 0xEE;
   unsigned char j = 0;
   unsigned char check;
   unsigned int dir = 0;
   start();
   while (1) {
    if(UART1_Data_Ready()){
     byteRecv = readData();
     if(byteRecv == ':'){
      trama[0] = ascii2hex();
      size = trama[0] + 0x05;
      for(j = 1; j<size; j++){
        trama[j] = ascii2hex();
      }
      check = check_sum(trama);
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
void start() {
    ANSELH=0X00;
    TRISB=0X00;
    PORTB=0XFF;
    UART1_Init(9600);
    Delay_ms(1000);
    PORTB=0X00;
    UART1_Write_Text("MrBurner Ready");
}