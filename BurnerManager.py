import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils
import threading
import sys

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
            while True:
                self.serialManager.write_port_byte(line)
                res = self.serialManager.connection.readline().decode().split('\n')[0]
                print (i, line,res)
                if (res == 'BAD'):
                    print('Error de linea', line)
                    self.console.pub('{} - {} - Error de transmisión - Reenviando...\n'.format(i,res))
                else:
                    self.console.pub('{} - {} - Linea enviada correctamente. \n'.format(i,res))
                    break
                