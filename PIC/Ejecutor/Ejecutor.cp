#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Ejecutor/Ejecutor.c"
#line 1 "c:/users/wwrik/documents/code/micros/mrbootloader/pic/ejecutor/eeprom_manager.c"
unsigned int read_eeprom( char addrh, char addr) {
 unsigned int response;
 EEADR = addr;
 EEADRH = addrh;
 EEDAT = 0X00;
 EEDATH = 0X00;
 EECON1.EEPGD = 1;
 EECON1.RD = 1;
 asm{
 nop
 nop
 }
 while(EECON1.RD);
 UART1_Write(EEDAT);
 UART1_Write(EEDATH);
 response = EEDATH;
 response = response<<8;
 response |= EEDAT;
 return(response);
}

void write_eeprom(char * trama){

 unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5;
 unsigned int dir = (addrh << 8 | addr)/2;
 addrh = dir>>8;
 addr = dir;
 PORTB = 0xFF;
 if(!((dir==0x0000)||(dir>0x1FFF))){
 for(i = 0; i<trama[0]/2; i++){
 EEADR = addr;
 EEADRH = addrh;
 EEDATA = trama[i*2+4];
 EEDATH = trama[i*2+5];
 EECON1.EEPGD = 1;
 EECON1.WREN = 1;
 INTCON.GIE = 0;
 EECON2 = 0x55;
 EECON2 = 0xAA;
 EECON1.WR = 1;
 asm{
 nop
 nop
 }
 while(EECON1.WR);
 INTCON.GIE = 1;
 if(addr == 0xFF) addrh+=0x01;
 addr+=0x01;
 }
 }
 UART1_Write_Text("OK\n");
}
#line 1 "c:/users/wwrik/documents/code/micros/mrbootloader/pic/ejecutor/uart_manager.c"

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
#line 3 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Ejecutor/Ejecutor.c"
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
 goto 0x500;
 }
 }
 }
 }
 }
}
