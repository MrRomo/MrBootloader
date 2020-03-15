//#include "eeprom_manager.c"
void start();
unsigned char ascii2hex();
unsigned char mult(unsigned char dato);
unsigned char readData();
unsigned char check_sum(unsigned char * trama);
void main() {
     unsigned char trama[25] = {0};
     unsigned char size = 0x00;
     unsigned char byteRecv = 0xEE;
     unsigned char j, checksum = 0;
     start();
     for (j = 0; j < 3; j++)
      {
        Delay_ms(1000);
        UART1_Write_Text("Inicio");
      }
     while (1) {
      if(UART1_Data_Ready()){
       byteRecv = readData();
       if(byteRecv == ':'){
        trama[0] = ascii2hex();
        size = trama[0] + 0x05;
        UART1_Write(size);
        for(j = 1; j<size; j++){
          trama[j] = ascii2hex();
//          UART1_Write(trama[j]);
        }
        for(j = 0; j<trama[0]+4; j++)
        {
          checksum += trama[j];
//          UART1_Write(trama[j]);
        }
        checksum = ~checksum + 1;
//        UART1_Write(trama[trama[0]+5]);
//        UART1_Write(0xFF);
//        UART1_Write(checksum);
       }
       PORTB = 0x00;
      }
     }
}
void start() {
    PORTB=0X00;
    ANSELH=0X00;
    TRISB=0X00;
    UART1_Init(9600);
    Delay_ms(1);
    PORTB = 0xFF;
    PORTB=0X00;
 }
unsigned char ascii2hex(){
    unsigned char dato = 0x00;
    dato = mult(readData())<<4;
    dato += mult(readData());
//    UART1_Write(dato);
    PORTB = 0xFF;
    return dato;
}
unsigned char mult(unsigned char dato){
    if (dato>='A'){
      dato = (dato-55);
    }else{
      dato = (dato-48);
    }
    return dato;
}
unsigned char readData(){
   unsigned char dato;
   PORTB = 0x00;
   while (1){
     if(UART1_Data_Ready()){
        dato = UART1_Read();
        PORTB = 0xFF;
        return dato;
     }
   }
}