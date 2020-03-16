
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
//    UART1_Write(dato);
    PORTB = 0xFF;
    return dato;
}
unsigned char check_sum(unsigned char * trama) {
  unsigned char checksum, j = 0x00;
  unsigned char size = trama[0]+0x04;
  for(j = 0; j<size; j++)
  {
    checksum += trama[j];
//    UART1_Write(trama[j]);
  }
  checksum = ~checksum + 1;
//  UART1_Write(trama[size]);
//  UART1_Write(0xFF);
//  UART1_Write(checksum);
  j = (checksum == trama[size]);
  checksum = 0;
  return j;
}