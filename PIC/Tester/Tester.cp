#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Tester/Tester.c"
void main() org 0x500{
 TRISB = 0x00;
 PORTB = 0x00;
 while (1){
 Delay_ms(500);
 PORTB = ~PORTB;
 }
}
