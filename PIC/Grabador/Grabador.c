#include "eeprom_manager.c"
#include "uart_manager.c"

void start();
void write_intel(unsigned char * trama);

void main() {
   unsigned char trama[21] = {0};
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
      check ? UART1_Write_Text("OK\n") : UART1_Write_Text("BAD\n");
      PORTB = 0x00;
     }
    }
   }
}
void write_intel(unsigned char * trama){

  unsigned int addt  = trama[1]<<8;
  unsigned char addr = 0x00;
  unsigned char size = trama[0]+0x04;
  unsigned char i = 0;

  Delay_ms(100);
  addt += trama[2];
  addt += 0x0300;
  for (i=4; i<size; i+2) {
      addr = addt;
      write_eeprom(addt>>8, addr, trama[i], trama[i+1]);
      delay_ms(1000);
      addt++;
  }
  PORTB = 0x00;
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