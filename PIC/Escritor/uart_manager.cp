#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Escritor/uart_manager.c"

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
unsigned char mult(unsigned char dato){
 if (dato>='A'){
 return dato-55;
 }else{
 return dato-48;
 }
}
unsigned char ascii2hex(){
 unsigned char dato = 0x00;
 dato = mult(readData())<<4;
 dato += mult(readData());

 PORTB = 0xFF;
 return dato;
}
unsigned char check_sum(unsigned char * trama) {
 unsigned char checksum, j = 0x00;
 unsigned char size = trama[0]+0x04;
 for(j = 0; j<size; j++)
 {
 checksum += trama[j];

 }
 checksum = ~checksum + 1;



 j = (checksum == trama[size]);
 checksum = 0;
 return j;
}
