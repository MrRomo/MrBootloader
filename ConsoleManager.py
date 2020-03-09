from PyQt5 import QtCore, QtGui, QtWidgets  
from collections import deque as dq 
from time import sleep as delay

class ConsoleManager():
    def __init__(self, console, translate):
        self.translate = translate
        self.console = console
        self.max_queu = 10
        self.console_queue = dq(maxlen=self.max_queu)
        self.status = True
        self.console_queue.append('Starting Console Manager \0')
        self.console.setReadOnly(True)
        self.status = True

    def console_agent(self):
        while 1:
            if(self.status and len(self.console_queue)):
                self.status = False
                console_queue = self.console_queue.copy()
                self.console_queue.clear()
                for msg in console_queue:
                    # self.console.moveCursor(QtGui.QTextCursor.End)
                    # self.console.ensureCursorVisible()
                    self.console.insertPlainText(msg)
                
                self.status = True
            delay(1)
            
            # # self.console_queue.appendleft(msg)
            # # text = ''.join(self.console_queue)
            # if(self.status):
            #     print(text)
            # #     # self.console.clear()
            # #     __sortingEnabled = self.console.isSortingEnabled()
            # #     self.console.setSortingEnabled(False)
            # #     for idx, val in enumerate(self.console_queue):
            # #         item = QtWidgets.QListWidgetItem()
            # #         self.console.addItem(item)
            # #         item = self.console.item(idx)
            # #         item.setText(self.translate("MainWindow", val))
            # #     self.console.setSortingEnabled(__sortingEnabled)
            #     self.status = True
    