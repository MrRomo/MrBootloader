import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils
import threading
from PyQt5 import QtCore
import sys

class SerialManager:

    def __init__(self, console, ui, app):
        self.utils = Utils()
        self.ui = ui
        self.app = app
        self.connectButton = ui.connectButton
        self.consoleManager = console
        self.portSelector = self.ui.portSelector
        self.ports = []
        self.current_port = None
        self.serial_connect = serial.Serial
        self.port_flag = False
        self.connection = None
        self.connected = False
        self.translate = QtCore.QCoreApplication.translate
        self.port_selector = self.ui.port_selector_thread
    
    def get_port_list(self):
        ports = [{'name': i[1], 'port':i[0]} for i in  list(port_list.comports())]
        return ports

    def port_events(self):
        self.disconnect()
        self.consoleManager.pub('Starting port Events Manager\n')
        while 1:
            delay(1)
            list_ports = [i for i in self.get_port_list()]
            if (list_ports != self.ports):
                consoleMsg = self.utils.portObserver(list_ports,self.ports)
                self.ports = list_ports
                self.port_selector.queue.append(self.ports)                
                self.consoleManager.pub(consoleMsg)
                self.port_flag = True
                self.disconnect()

    def port_selector_observer(self): 
        self.current_port = self.ports[self.portSelector.currentIndex()]['port'] 
        self.consoleManager.pub('Changing port to {}\n'.format(self.current_port))

    def change_port(self):
        threading.Thread(target=self.port_selector_observer).start()
            
    def connect(self):
        if(self.connected):
            self.disconnect()
        else:
            baudios = int(self.ui.baudSelector.currentText())
            self.connection = self.serial_connect(self.current_port, baudios, rtscts=True)
            self.connected = True
            self.consoleManager.pub('Connection successfully to {}\n'.format(self.current_port))
            self.connectButton.setText(self.ui.translate("MainWindow", 'Disconnect'))
            threading.Thread(target=self.read_port, daemon=True).start()

    def disconnect(self):
        self.connected = False
        if(self.connection):
            self.connection.close()
            self.consoleManager.pub('Serial disconnected\n')
            self.connectButton.setText(self.ui.translate("MainWindow", 'Connect'))

    def read_port(self):
        while 1:
            if self.connected:
                try:
                    read = self.connection.read()
                    msg = str(read.hex())
                    self.consoleManager.pub(msg)
                except serial.serialutil.SerialException as SerialException:
                    self.disconnect()
                    print(SerialException)
            else:
                break
                
    def send_write(self):
        msg = self.ui.sendField.toPlainText()
        self.consoleManager.pub('\n')
        print(msg, len(msg), type(msg))
        threading.Thread(target=self.write_port_byte,  kwargs={'msg':msg},).start()
    
    def write_port_byte(self, msg):
        print('Enviando Datos', self.connected, msg)
        if not(self.connected):
            self.connect()
        for i in list(msg):
            self.connection.write(i.encode())

    def list_ports (self):
        return self.get_port_list()
    
