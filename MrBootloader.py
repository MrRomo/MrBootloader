from PyQt5 import QtCore, QtGui, QtWidgets
from PyQtEngine import Ui_MainWindow
from SerialManager import SerialManager
from StreamModule import StreamModule
from ConsoleManager import ConsoleManager
from time import sleep as delay
from Utils import Utils
import threading
import sys

class MrBootloader():

    def __init__(self):
        self.ports = []
        self.MainWindow = None
        self.ui = None

    def startApp(self):
        self.app = QtWidgets.QApplication(sys.argv)
        self.MainWindow = QtWidgets.QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self.MainWindow)
        self.MainWindow.show()
        self.translate = self.ui.translate
        self.portSelector = self.ui.portSelector
        self.baudSelector = self.ui.baudSelector
        self.hexBox = self.ui.hexBox
        self.console = self.ui.console
        self.connectButton = self.ui.connectButton
        self.flashButton = self.ui.flashButton
        self.eraseButton = self.ui.eraseButton
        self.sendButton = self.ui.sendButton
        
        # Init Managers 
        self.consoleManager = ConsoleManager(self.console, self.translate)
        self.serialManager = SerialManager(self.consoleManager, self.ui)
        
        self.startSignals()

        self.startThread(self.serialManager.port_events)
        self.startThread(self.serialManager.port_selector_observer)
        self.startThread(self.serialManager.read_port)

    def startThread(self, function):
        thread = threading.Thread(target=function)
        thread.daemon = True
        thread.start()
    
    def startSignals(self):
        self.consoleManager.push2console('Starting Signals')
        self.portSelector.currentIndexChanged.connect(self.serialManager.change_port)
        self.connectButton.clicked.connect(self.serialManager.connect)
        self.eraseButton.clicked.connect(self.serialManager.change_port)
        self.flashButton.clicked.connect(self.serialManager.change_port)
        self.sendButton.clicked.connect(self.serialManager.change_port)

    

if __name__ == "__main__":

    app = MrBootloader()
    app.startApp()
    sys.exit(app.app.exec_())





    


