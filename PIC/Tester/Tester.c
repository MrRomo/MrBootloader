
void main() org 0x200{
     TRISA = 0x00;
     TRISB = 0x00;
//      TRISC = 0x00;
     ANSEL = 0X00;
     ANSELH = 0X00;
     PORTA = 0x02;
     PORTB = 0x08;
//      PORTC = 0x02;
     while (1){
           Delay_ms(100);
           PORTA = PORTA<<1;
           PORTB = PORTB<<1;
      //      PORTC = PORTC<<1;
           if(PORTA.F5 == 1) PORTA++;
           if(PORTB.F7 == 1) PORTB++;
      //      if(PORTC.F7 == 1) PORTC++;
     }
}