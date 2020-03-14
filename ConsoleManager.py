from PyQt5 import QtCore, QtGui, QtWidgets  
from collections import deque as dq 
from datetime import datetime
from time import sleep as delay
class ConsoleManager():
    def __init__(self, console):
        self.console = console
        self.pub('Starting Console Manager\n')

    def pub (self, msg):
        self.console.queue.append(msg)
        return 0
        
    # def console_agent(self):
    #     while 1:
    #         if(self.status and len(self.console_queue)):
    #             self.status = False
    #             msg = self.console_queue[0]
    #             print(msg)
    #             self.console_queue.popleft()                
    #             self.status = True
    #             delay(0.1)
            