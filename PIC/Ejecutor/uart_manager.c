
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