# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'MrBootloader.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(641, 758)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.sendButton = QtWidgets.QPushButton(self.centralwidget)
        self.sendButton.setGeometry(QtCore.QRect(30, 680, 111, 31))
        self.sendButton.setObjectName("sendButton")
        self.eraseButton = QtWidgets.QPushButton(self.centralwidget)
        self.eraseButton.setGeometry(QtCore.QRect(150, 490, 111, 31))
        self.eraseButton.setObjectName("eraseButton")
        self.progressBar = QtWidgets.QProgressBar(self.centralwidget)
        self.progressBar.setGeometry(QtCore.QRect(270, 490, 341, 31))
        self.progressBar.setProperty("value", 0)
        self.progressBar.setObjectName("progressBar")
        self.portSelector = QtWidgets.QComboBox(self.centralwidget)
        self.portSelector.setGeometry(QtCore.QRect(100, 20, 161, 30))
        self.portSelector.setObjectName("portSelector")
        self.portSelector.addItem("")
        self.portSelector.addItem("")
        self.portSelector.addItem("")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(30, 20, 71, 30))
        font = QtGui.QFont()
        font.setPointSize(13)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(270, 20, 111, 30))
        font = QtGui.QFont()
        font.setPointSize(13)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.baudSelector = QtWidgets.QComboBox(self.centralwidget)
        self.baudSelector.setGeometry(QtCore.QRect(350, 19, 121, 31))
        self.baudSelector.setObjectName("baudSelector")
        self.baudSelector.addItem("")
        self.baudSelector.addItem("")
        self.console2 = QtWidgets.QListWidget(self.centralwidget)
        self.console2.setGeometry(QtCore.QRect(30, 540, 581, 131))
        self.console2.setMovement(QtWidgets.QListView.Static)
        self.console2.setObjectName("console2")
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.console2.addItem(item)
        self.sendField = QtWidgets.QPlainTextEdit(self.centralwidget)
        self.sendField.setGeometry(QtCore.QRect(150, 680, 461, 31))
        self.sendField.setObjectName("sendField")
        self.flashButton = QtWidgets.QPushButton(self.centralwidget)
        self.flashButton.setGeometry(QtCore.QRect(30, 490, 111, 31))
        self.flashButton.setObjectName("flashButton")
        self.hexBox = QtWidgets.QListWidget(self.centralwidget)
        self.hexBox.setGeometry(QtCore.QRect(30, 60, 581, 411))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.hexBox.setFont(font)
        self.hexBox.setObjectName("hexBox")
        item = QtWidgets.QListWidgetItem()
        self.hexBox.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.hexBox.addItem(item)
        item = QtWidgets.QListWidgetItem()
        self.hexBox.addItem(item)
        self.flashButton_2 = QtWidgets.QPushButton(self.centralwidget)
        self.flashButton_2.setGeometry(QtCore.QRect(500, 20, 111, 31))
        self.flashButton_2.setObjectName("flashButton_2")
        self.baudSelector_2 = QtWidgets.QComboBox(self.centralwidget)
        self.baudSelector_2.setGeometry(QtCore.QRect(820, -440, 121, 20))
        self.baudSelector_2.setObjectName("baudSelector_2")
        self.baudSelector_2.addItem("")
        self.baudSelector_2.addItem("")
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

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.sendButton.setText(_translate("MainWindow", "Send"))
        self.eraseButton.setText(_translate("MainWindow", "Erase"))
        self.progressBar.setFormat(_translate("MainWindow", "%p%"))
        self.portSelector.setItemText(0, _translate("MainWindow", "Arduino"))
        self.portSelector.setItemText(1, _translate("MainWindow", "ESP32"))
        self.portSelector.setItemText(2, _translate("MainWindow", "PIC 16F887"))
        self.label.setText(_translate("MainWindow", "Puerto"))
        self.label_2.setText(_translate("MainWindow", "Velocidad"))
        self.baudSelector.setItemText(0, _translate("MainWindow", "9600"))
        self.baudSelector.setItemText(1, _translate("MainWindow", "12500"))
        __sortingEnabled = self.console2.isSortingEnabled()
        self.console2.setSortingEnabled(False)
        item = self.console2.item(0)
        item.setText(_translate("MainWindow", "hola"))
        item = self.console2.item(1)
        item.setText(_translate("MainWindow", "d"))
        item = self.console2.item(2)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(3)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(4)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(5)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(6)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(7)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(8)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(9)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(10)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(11)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(12)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(13)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(14)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(15)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(16)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(17)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(18)
        item.setText(_translate("MainWindow", "Nuevo elemento"))
        item = self.console2.item(19)
        item.setText(_translate("MainWindow", "sdmgf"))
        item = self.console2.item(20)
        item.setText(_translate("MainWindow", "sdfosdnfosdf"))
        self.console2.setSortingEnabled(__sortingEnabled)
        self.flashButton.setText(_translate("MainWindow", "Flash"))
        __sortingEnabled = self.hexBox.isSortingEnabled()
        self.hexBox.setSortingEnabled(False)
        item = self.hexBox.item(0)
        item.setText(_translate("MainWindow", "hola"))
        item = self.hexBox.item(1)
        item.setText(_translate("MainWindow", "sdmgf"))
        item = self.hexBox.item(2)
        item.setText(_translate("MainWindow", "sdfosdnfosdf"))
        self.hexBox.setSortingEnabled(__sortingEnabled)
        self.flashButton_2.setText(_translate("MainWindow", "Connect"))
        self.baudSelector_2.setItemText(0, _translate("MainWindow", "9600"))
        self.baudSelector_2.setItemText(1, _translate("MainWindow", "12500"))
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

