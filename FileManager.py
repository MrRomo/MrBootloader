from PyQt5 import QtCore, QtGui, QtWidgets  
from collections import deque as dq 
from time import sleep as delay

class FileManager():
    def __init__(self,  console, ui):
        self.hex_box = ui.hex_box_thread
        self.code = None
        self.console = console
        self.hex_box_agent('Open a hex file to burn it! fuk')
        # self.console.pub('File Manager Started\n')

    def open_file(self):
        dlg = QtWidgets.QFileDialog()
        dlg.setFileMode(QtWidgets.QFileDialog.AnyFile)
        # dlg.setFilter('hex')
        
        if dlg.exec_():
            filenames = dlg.selectedFiles()
            f = open(filenames[0], 'r')
            
            with f:
                data = f.read()
                self.hex_box_agent(data)
                # self.console.pub('File Hex Loaded\n')

    def hex_box_agent(self, file):
        code = file.split('\n')
        last = code[-1]
        (last == '') if print('codigo completo') else code.pop()
        self.code = code
        self.hex_box.queue.append(self.code)