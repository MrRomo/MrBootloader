from PyQt5 import QtCore, QtGui, QtWidgets  
from collections import deque as dq 
from time import sleep as delay

class FileManager():
    def __init__(self, hex_box, translate):
        self.hex_box = hex_box
        self.hex_box.setReadOnly(True)
        self.translate = translate
        self.code = None
        self.hex_box_agent('Open a hex file to burn it!')
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
                print(data)

    def hex_box_agent(self, file):
        self.hex_box.clear()
        self.code = file
        for line in file:
            self.hex_box.moveCursor(QtGui.QTextCursor.End)
            self.hex_box.ensureCursorVisible()
            self.hex_box.insertPlainText(line)