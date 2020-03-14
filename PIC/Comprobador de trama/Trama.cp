#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Comprobador de trama/Trama.c"
#line 1 "c:/users/wwrik/documents/code/micros/mrbootloader/pic/comprobador de trama/eeprom_manager.c"

typedef struct trama{
 unsigned char size;
 unsigned char addr;
 unsigned char addrh;
 unsigned char type;
 unsigned char info[64];
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
#line 2 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Comprobador de trama/Trama.c"
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
 check_sum(Trama);







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
 while (1){
 if(UART1_Data_Ready()){
 dato = UART1_Read();
 PORTB = 0xFF;
 UART1_Write(dato);
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
