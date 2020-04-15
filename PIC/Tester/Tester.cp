#line 1 "C:/Users/wwrik/Documents/Code/Micros/MrBootloader/PIC/Tester/Tester.c"

void main() org 0x200{
 TRISA = 0x00;
 TRISB = 0x00;

 ANSEL = 0X00;
 ANSELH = 0X00;
 PORTA = 0x02;
 PORTB = 0x08;

 while (1){
 Delay_ms(100);
 PORTA = PORTA<<1;
 PORTB = PORTB<<1;

 if(PORTA.F5 == 1) PORTA++;
 if(PORTB.F7 == 1) PORTB++;

 }
}
