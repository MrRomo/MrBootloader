import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils
import threading
import sys

class BurnerManager:

    def __init__(self, SerialManager, file, progressBar, console):
        self.progressBar = progressBar
        self.connection = True #SerialManager.connection
        self.connected = SerialManager.connection
        self.fileManager = file
        self.console = console
        self.console.pub('Burner Manager Started\n')
        self.burn_signal = False
        self.finish = False

    def burn(self):
        self.console.pub('Burn .hex file \n')
        self.burn_signal = True

    def burn_task(self):
        while 1:
            delay(1)
            if self.burn_signal:
                self.burn_signal = False
                if(self.connection):
                    code = self.fileManager.code
                    for i, line in enumerate(code):
                        progress = i*100/len(code)
                        self.progressBar.setValue(progress)
                        self.SerialManager

                    self.progressBar.setValue(100)
                    progress = threading.Thread(target=self.delay_for_progress_bar)
                    progress.start()
                        # self.console.console_queue.append('Uploading line: ' + line + '\n')
                        # self.console.pub(line + '\n')
            # msg = self.ui.sendField.toPlainText()
            # self.connection.writelines(msg.encode())

    def delay_for_progress_bar(self):
        delay(5)
        self.progressBar.setValue(0)

