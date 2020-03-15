#include "eeprom_manager.c"
void start();
unsigned char ascii2hex();
unsigned char mult(unsigned char dato);
unsigned char readData();
unsigned char check_sum(trama_t * Trama);
void main() {
     trama_t * Trama;
     unsigned char byteRecv = 0x00;
     unsigned char j;
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
        Trama->size = ascii2hex();
        Trama->addr = ascii2hex();
        Trama->addrh = ascii2hex();
        Trama->type = ascii2hex();
        for (j = 0; j < Trama->size; j++)
        {
          Trama->info[j] = ascii2hex();
        }
        Trama->checksum = ascii2hex();
//        check_sum(Trama);
        // UART1_Write_Text("Start");
        // UART1_Write(Trama->size);
        // UART1_Write(Trama->addr);
        // UART1_Write(Trama->addrh);
        // UART1_Write(Trama->type);
        // UART1_Write(Trama->checksum);

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
    dato = mult(readData())*16;
    dato += mult(readData());
    UART1_Write(dato);
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

unsigned char check_sum(trama_t * Trama){
   unsigned char checksum = 0x00;
   unsigned char i = 0x00;
   checksum = Trama->size + Trama->addr+Trama->addrh+Trama->type;
   for (i=0; i<Trama->size; i++){
       checksum += Trama->info[i];
   }
   checksum = ~checksum + 1;
   UART1_Write(checksum);
}