from PyQt5 import QtCore, QtGui, QtWidgets  
from collections import deque as dq 
from datetime import datetime
from time import sleep as delay

class ConsoleManager():
    def __init__(self, console, translate):
        self.translate = translate
        self.console = console
        self.max_queu = 200
        self.console_queue = dq(maxlen=self.max_queu)
        self.status = True
        self.pub('Starting Console Manager\n')
        self.console.setReadOnly(True)
        self.status = True

    def pub (self, msg):
        self.console_queue.append(msg)
        return 0
        
    def console_agent(self):
        while 1:
            if(self.status and len(self.console_queue)):
                self.status = False
                msg = self.console_queue[0]
                # self.console.moveCursor(QtGui.QTextCursor.End)
                self.console.ensureCursorVisible()
                self.console.insertPlainText(msg)
                # print(self.console.verticalScrollBar().maximum())
                self.console_queue.popleft()                
                self.status = True
                delay(0.1)
            