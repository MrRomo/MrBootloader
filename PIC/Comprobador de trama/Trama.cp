#line 1 "C:/Users/wwrik/Documents/Microcontroladores 2/Primer Seguimiento/Comprobador de trama/Trama.c"
#line 1 "c:/users/wwrik/documents/microcontroladores 2/primer seguimiento/comprobador de trama/eeprom_manager.c"

typedef struct trama{
 unsigned char size;
 unsigned char addr;
 unsigned char addrh;
 unsigned char type;
 unsigned char * info;
 unsigned char checksum;
}trama_t;

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

void write_eeprom(char addrh, char addr, char datoh,char dato){
 unsigned char i = 0;
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
#line 2 "C:/Users/wwrik/Documents/Microcontroladores 2/Primer Seguimiento/Comprobador de trama/Trama.c"
void start();
unsigned char ascii2hex();
unsigned char mult(unsigned char dato);
unsigned char readData();
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
 UART1_Write_Text("Start");
 Trama->size = ascii2hex();
 UART1_Write(Trama->size);
 Trama->addr = ascii2hex();
 UART1_Write(Trama->addr);
 Trama->addrh = ascii2hex();
 UART1_Write(Trama->addrh);
 Trama->type = ascii2hex();
 UART1_Write(Trama->type);
 for (j = 0; j < Trama->size; j++)
 {
 byteRecv = ascii2hex();
 }
 Trama->checksum = ascii2hex();
 UART1_Write(Trama->checksum);
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
 Delay_ms(1);
 dato = UART1_Read();
 PORTB = 0xFF;
 Delay_ms(1);
 return dato;
}
