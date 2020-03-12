import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils
import threading
import sys

class SerialManager:

    def __init__(self, console, ui, app):
        self.utils = Utils()
        self.ui = ui
        self.app = app
        self.portSelector = ui.portSelector
        self.connectButton = ui.connectButton
        self.consoleManager = console
        self.ports = []
        self.current_port = None
        self.serial_connect = serial.Serial
        self.port_flag = False
        self.connection = None
        self.connected = False
    
    def get_port_list(self):
        ports = [{'name': i[1], 'port':i[0]} for i in  list(port_list.comports())]
        return ports

    def port_events(self):
        self.disconnect()
        self.consoleManager.pub('Starting port Events Manager\n')
        while 1:
            list_ports = [i for i in self.get_port_list()]
            if (list_ports != self.ports):
                consoleMsg = self.utils.portObserver(list_ports,self.ports)
                self.ports = list_ports
                self.portSelector.clear()
                for idx, val in enumerate(list_ports):
                    self.portSelector.addItem("")
                    self.portSelector.setItemText(idx, self.consoleManager.translate("MainWindow", str(val['name'] + ' - ' + val['port'])))
                self.consoleManager.pub(consoleMsg)
                self.port_flag = True
                self.portSelector.setCurrentIndex(0)
                self.disconnect()

    def port_selector_observer(self): 
        while 1:
            if self.port_flag: 
                self.current_port = self.ports[self.portSelector.currentIndex()]['port'] 
                self.port_flag = False
                self.consoleManager.pub('Changing port to {}\n'.format(self.current_port))
            delay(1)

    def change_port(self):
        self.port_flag = True
            
    def connect(self):
        if(self.connected):
            self.disconnect()
        else:
            baudios = int(self.ui.baudSelector.currentText())
            self.connection = self.serial_connect(self.current_port, baudios, rtscts=True)
            self.connected = True
            self.consoleManager.pub('Connection successfully to {}\n'.format(self.current_port))
            self.connectButton.setText(self.ui.translate("MainWindow", 'Disconnect'))
            # read_port = threading.Thread(target=self.read_port)
            # read_port.start()
            # sys.exit(self.app.exec_())

    def disconnect(self):
        self.connected = False
        if(self.connection):
            self.connection.close()
            self.consoleManager.pub('Serial disconnected\n')
            self.connectButton.setText(self.ui.translate("MainWindow", 'Connect'))


    def read_port(self):
        while 1:
            if self.connected:
                # self.connection.flushInput()
                read = self.connection.read()
                msg = str(read.hex())
                # print('{}-{}-{}'.format(str(read),read.hex(),int.from_bytes(read,sys.byteorder)))
                print('{}-{}'.format(str(read), read.hex()))
                self.consoleManager.pub(msg)
                
    def write_port(self):
        msg = self.ui.sendField.toPlainText()
        print('Enviando Datos', self.connected, msg)
        if(self.connected):
            self.connection.write(msg.encode())
    
    def write_port_byte(self, msg):
        print('Enviando Datos', self.connected, msg)
        if(self.connected):
            self.connection.write(msg.encode())

           
    def list_ports (self):
        return self.get_port_list()
    
