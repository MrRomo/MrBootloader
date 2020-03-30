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
                    self.console.pub('{} - {} - Error de transmisión - Reenviando...\n'.format(i,line))
                    delay(1)
                    self.serialManager.connection.flushInput()
                    self.serialManager.write_port_byte(line)
                elif (res == 'OK'):
                    self.serialManager.connection.flushInput()
                    self.console.pub('{} - {} - Linea enviada correctamente. \n'.format(i,line))
                    print('{} - {} - Linea enviada correctamente.'.format(i,res))
                    break
                    # print('Size of trama:',size)
                    # size = int(line[1:3],16)+5
                    # for l in range(size):
                    #     temp = self.serialManager.connection.read()
                    #     code += temp.hex()
                    # self.console.pub('{} - :{} - Linea enviada correctamente. \n'.format(i,code.upper()))
                    # code = res = ''


                