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
        self.consoleManager = ConsoleManager(self.console, self.translate)
        self.consoleManager.push2console('Starting Mr Bootloader')
        self.serialManager = SerialManager(self.consoleManager, self.ui.portSelector)
        self.portSelector.currentIndexChanged.connect(self.serialManager.change_port)


        self.startThread(self.serialManager.port_events)
        self.startThread(self.serialManager.port_selector_observer)

    def startThread(self, function):
        thread = threading.Thread(target=function)
        thread.daemon = True
        thread.start()
    

if __name__ == "__main__":

    app = MrBootloader()
    app.startApp()
    sys.exit(app.app.exec_())





    


