# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'MrBootloader.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import Qt, QThread, pyqtSignal



class HexBox(QThread):
    # Create a counter thread
    change_value = pyqtSignal(int)
    def run(self):
        while 1:
            


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(641, 758)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.sendButton = QtWidgets.QPushButton(self.centralwidget)
        self.sendButton.setGeometry(QtCore.QRect(30, 680, 110, 30))
        self.sendButton.setObjectName("sendButton")
        self.eraseButton = QtWidgets.QPushButton(self.centralwidget)
        self.eraseButton.setGeometry(QtCore.QRect(150, 490, 110, 30))
        self.eraseButton.setObjectName("eraseButton")
        self.progressBar = QtWidgets.QProgressBar(self.centralwidget)
        self.progressBar.setGeometry(QtCore.QRect(270, 490, 340, 30))
        self.progressBar.setProperty("value", 0)
        self.progressBar.setObjectName("progressBar")
        self.portSelector = QtWidgets.QComboBox(self.centralwidget)
        self.portSelector.setGeometry(QtCore.QRect(90, 30, 210, 20))
        self.portSelector.setObjectName("portSelector")
        self.portSelector.addItem("")
        self.portSelector.addItem("")
        self.portSelector.addItem("")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(30, 30, 71, 20))
        font = QtGui.QFont()
        font.setPointSize(13)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(320, 30, 111, 20))
        font = QtGui.QFont()
        font.setPointSize(13)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.baudSelector = QtWidgets.QComboBox(self.centralwidget)
        self.baudSelector.setGeometry(QtCore.QRect(400, 30, 80, 20))
        self.baudSelector.setObjectName("baudSelector")
        self.baudSelector.addItem("")
        self.baudSelector.addItem("")
        self.connectButton = QtWidgets.QPushButton(self.centralwidget)
        self.connectButton.setGeometry(QtCore.QRect(500, 30, 110, 20))
        self.connectButton.setObjectName("connectButton")
        self.console = QtWidgets.QPlainTextEdit(self.centralwidget)
        self.console.setGeometry(QtCore.QRect(30, 540, 581, 131))
        self.console.setObjectName("console")
        self.console.setMaximumBlockCount(10)
        self.sendField = QtWidgets.QPlainTextEdit(self.centralwidget)
        self.sendField.setGeometry(QtCore.QRect(150, 680, 461, 31))
        self.sendField.setObjectName("sendField")
        self.flashButton = QtWidgets.QPushButton(self.centralwidget)
        self.flashButton.setGeometry(QtCore.QRect(30, 490, 111, 31))
        self.flashButton.setObjectName("flashButton")
        self.hexBox = QtWidgets.QPlainTextEdit(self.centralwidget)
        self.hexBox.setGeometry(QtCore.QRect(30, 60, 581, 411))
        self.hexBox.setObjectName("hexBox")
        
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 641, 21))
        self.menubar.setObjectName("menubar")
        self.menuFile = QtWidgets.QMenu(self.menubar)
        self.menuFile.setObjectName("menuFile")
        self.menuOptions = QtWidgets.QMenu(self.menubar)
        self.menuOptions.setObjectName("menuOptions")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)
        self.actionOpen = QtWidgets.QAction(MainWindow)
        self.actionOpen.setObjectName("actionOpen")
        self.actionExit = QtWidgets.QAction(MainWindow)
        self.actionExit.setObjectName("actionExit")
        self.menuFile.addAction(self.actionOpen)
        self.menuFile.addSeparator()
        self.menuFile.addAction(self.actionExit)
        self.menubar.addAction(self.menuFile.menuAction())
        self.menubar.addAction(self.menuOptions.menuAction())

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

        self.thread = HexBox()
        self.thread.start()

    def retranslateUi(self, MainWindow):
        self.translate = _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MrBurner"))
        self.sendButton.setText(_translate("MainWindow", "Send"))
        self.connectButton.setText(_translate("MainWindow", "Connect"))
        self.eraseButton.setText(_translate("MainWindow", "Erase"))
        self.progressBar.setFormat(_translate("MainWindow", "%p%"))
        self.portSelector.setItemText(0, _translate("MainWindow", "Arduino"))
        self.portSelector.setItemText(1, _translate("MainWindow", "ESP32"))
        self.portSelector.setItemText(2, _translate("MainWindow", "PIC 16F887"))
        self.label.setText(_translate("MainWindow", "Port"))
        self.label_2.setText(_translate("MainWindow", "Speed"))
        self.baudSelector.setItemText(0, _translate("MainWindow", "9600"))
        self.baudSelector.setItemText(1, _translate("MainWindow", "12500"))
        self.flashButton.setText(_translate("MainWindow", "Flash"))
        self.menuFile.setTitle(_translate("MainWindow", "File"))
        self.menuOptions.setTitle(_translate("MainWindow", "Options"))
        self.actionOpen.setText(_translate("MainWindow", "Open"))
        self.actionExit.setText(_translate("MainWindow", "Exit"))
    



if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
