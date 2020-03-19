#include "eeprom_manager.c"
#include "uart_manager.c"
void start();
void write_intel(unsigned char * trama);
unsigned char addrh  = 0x05;
unsigned char addr = 0x00;
unsigned char dath  = 0x00;
unsigned char dat = 0xEE;
void main() {
   unsigned char * trama[21] = {0};
   unsigned char size = 0x00;
   unsigned char byteRecv = 0xEE;
   unsigned char j = 0;
   unsigned char check;
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
      check ? write_intel(trama) : UART1_Write_Text("BAD\n");
      j = 0;
      for(j = 0; j<size; j++){
       UART1_Write(trama[j]);
       trama[j] = 0x00;
      }
      j = 0;
      PORTB = 0x00;
     }
    }
   }
}
void write_intel(unsigned char * trama){
  unsigned char i = 0x00;
  PORTB = 0xFF;
  for(i = 0; i<trama[0]; i+=2){
    delay_ms(1);
    write_eeprom(trama[1], trama[2], trama[i+0x05], trama[i+0x04]);
    if(trama[2] == 0xFF) trama[1]+=0x01;
    trama[2]+=0x01;
    delay_ms(1);
  }
  i = 0;
  UART1_Write_Text("OK\n");
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