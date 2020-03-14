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
        threading.Thread(target=self.burn_task).start()

    def burn_task(self):    
        code = self.fileManager.code
        if not(self.serialManager.connected):
            self.serialManager.connect()
        for i, line in enumerate(code):
            print(list(line))
            self.serialManager.write_port_byte(line)
            delay(1.5)
            self.console.pub('\n')
                        # progress = i*100/len(code)
                        # self.progressBar.setValue(progress)
                    # self.progressBar.setValue(100)
                    # progress = threading.Thread(target=self.delay_for_progress_bar)
                    # progress.start()

    # def delay_for_progress_bar(self):
    #     delay(5)
    #     self.progressBar.setValue(0)

