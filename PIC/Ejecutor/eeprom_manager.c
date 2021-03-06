void write_eeprom(char * trama){
  unsigned char i = 0, addrh = trama[1], addr = trama[2], size = trama[0]+5;
  unsigned int dir = (addrh << 8 | addr)/2;
  addrh = dir>>8;
  addr = dir;
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