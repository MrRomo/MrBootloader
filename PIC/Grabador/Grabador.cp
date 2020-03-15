#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Grabador/Grabador.c"
#line 1 "c:/users/wwrik/documents/code/micros/mrbootloader/pic/grabador/eeprom_manager.c"
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

void write_eeprom(char addrh,char addr, char datoh ,char dato){
 EEADR = addr;
 EEADRH = addrh;
 EEDATA = dato;
 EEDATH = datoh;
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
}
#line 1 "c:/users/wwrik/documents/code/micros/mrbootloader/pic/grabador/uart_manager.c"

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
#line 4 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Grabador/Grabador.c"
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

 unsigned int addt = trama[1]<<8;
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
