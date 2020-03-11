from PyQt5 import QtCore, QtGui, QtWidgets
from PyQtEngine import Ui_MainWindow
from SerialManager import SerialManager
from ConsoleManager import ConsoleManager
from FileManager import FileManager
from BurnerManager import BurnerManager
from time import sleep as delay
from Utils import Utils
import threading
import sys

class MrBurner():

    def __init__(self):
        self.ports = []
        self.MainWindow = None
        self.ui = None

    def startApp(self):
        self.app = QtWidgets.QApplication(sys.argv)
        self.MainWindow = QtWidgets.QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self.MainWindow)

        app_icon = QtGui.QIcon()
        app_icon.addFile('Logo.jpg', QtCore.QSize(256,256))
        self.MainWindow.setWindowIcon(app_icon)
        self.MainWindow.show()

        self.translate = self.ui.translate
        self.portSelector = self.ui.portSelector
        self.baudSelector = self.ui.baudSelector
        self.hexBox = self.ui.hexBox
        self.console = self.ui.console

        #Buttons
        self.connectButton = self.ui.connectButton
        self.flashButton = self.ui.flashButton
        self.eraseButton = self.ui.eraseButton
        self.sendButton = self.ui.sendButton
        #acciotns
        self.openFile = self.ui.actionOpen

        # Init Managers 
        self.consoleManager = ConsoleManager(self.console, self.translate)
        self.serialManager = SerialManager(self.consoleManager, self.ui, self.app)
        self.fileManager = FileManager(self.hexBox, self.translate, self.consoleManager)
        self.burnerManager = BurnerManager(self.serialManager, self.fileManager, self.ui.progressBar, self.consoleManager)
        self.startSignals()

        self.startThread(self.serialManager.port_events)
        self.startThread(self.serialManager.port_selector_observer)
        self.startThread(self.consoleManager.console_agent)
        self.startThread(self.serialManager.read_port)
        self.startThread(self.burnerManager.burn_task)

    def startThread(self, function):
        thread = threading.Thread(target=function)
        thread.daemon = True
        thread.start()
    
    def startSignals(self):
        self.consoleManager.pub('Starting Signals\n')
        self.portSelector.currentIndexChanged.connect(self.serialManager.change_port)
        self.connectButton.clicked.connect(self.serialManager.connect)
        self.eraseButton.clicked.connect(self.serialManager.change_port)
        self.flashButton.clicked.connect(self.burnerManager.burn)
        self.sendButton.clicked.connect(self.serialManager.write_port)
        self.openFile.triggered.connect(self.fileManager.open_file)

    

if __name__ == "__main__":

    app = MrBurner()
    app.startApp()
    sys.exit(app.app.exec_())





    


