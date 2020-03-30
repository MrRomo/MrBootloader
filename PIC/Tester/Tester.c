
void main() org 0x500{
     TRISB = 0x00;
     PORTB = 0x00;
     while (1){
           Delay_ms(1000);
           PORTB = ~PORTB;
     }
}