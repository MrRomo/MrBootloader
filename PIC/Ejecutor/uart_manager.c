
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

unsigned char ascii2hex(){
    unsigned char dato = 0, datoh = 0;
    dato = readData();
    datoh = readData();
    dato = (dato>='A') ? (dato-55)<<4 : (dato-48)<<4;
    dato += (datoh>='A') ? datoh-55 : datoh-48;
    PORTB = 0xFF;
    return dato;
}