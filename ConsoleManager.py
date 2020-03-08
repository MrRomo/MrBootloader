from PyQt5 import QtCore, QtGui, QtWidgets
from collections import deque as dq 
from time import sleep as delay

class ConsoleManager():
    def __init__(self, console, translate):
       self.translate = translate
       self.console = console
       self.console_queue = dq(maxlen=20)
       self.push2console('Starting Console Manager')

    def push2console(self, msg):
        print(msg)
        if(msg):
            self.console_queue.appendleft(msg)
            self.console.clear()
            __sortingEnabled = self.console.isSortingEnabled()
            self.console.setSortingEnabled(False)
            for idx, val in enumerate(self.console_queue):
                item = QtWidgets.QListWidgetItem()
                self.console.addItem(item)
                item = self.console.item(idx)
                item.setText(self.translate("MainWindow", val))

            self.console.setSortingEnabled(__sortingEnabled)
