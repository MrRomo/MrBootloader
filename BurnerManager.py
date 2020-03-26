import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils
import threading
import sys
from collections import deque as dq 

class BurnerManager:

    def __init__(self, SerialManager, file, progressBar, console):  
        self.progressBar = progressBar
        self.serialManager = SerialManager
        self.fileManager = file
        self.console = console
        self.console.pub('Burner Manager Started\n')


    def burn(self):
        self.console.pub('\nBurn .hex file \n')
        threading.Thread(target=self.burn_task, daemon=True).start()

    def burn_task(self):    
        code = self.fileManager.code
        if not(self.serialManager.connected):
            self.serialManager.connect()
        res = 'BAD'
        for i, line in enumerate(code):
            self.serialManager.connection.flushInput()
            self.serialManager.write_port_byte(line)
            while True:
                res = self.serialManager.connection.readline().decode().split('\n')[0]
                code = ''
                if (res == 'BAD'):
                    self.console.pub('{} - {} - {} Transmition Error - Resend...\n'.format(i,line,res))
                    self.serialManager.connection.flushInput()
                    self.serialManager.write_port_byte(line)
                elif (res == 'OK'):
                    self.console.pub('{} - {} - {} Line send correctly. \n'.format(i,line,res))
                    print('{} - {} - Line send correctly.'.format(i,res))
                    size = int(line[1:3],16)//2
                    print('Size of trama:',size)
                    for l in range(size):
                        for j in range(2):
                            for z in range(4):
                                temp = self.serialManager.connection.read()
                                code += temp.hex()
                                if(z==1): code += '->'    
                            code += ' '    
                        code += ' '
                        self.console.pub('{} - Line write on: {} \n'.format(i, code.upper()))
                        code = res = ''
                    break
                    # code = ' '.join([code[g:g+4] for g in range(0, len(code), 4)])
                print('-{}-'.format(res))
                delay(1)


                