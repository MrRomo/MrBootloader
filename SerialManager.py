import serial 
import serial.tools.list_ports as port_list
from time import sleep as delay
from Utils import Utils

class SerialManager:

    def __init__(self, console, ui):
        self.utils = Utils()
        self.ui = ui
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
        self.consoleManager.push2console('Starting port Events Manager')
        while 1:
            list_ports = [i for i in self.get_port_list()]
            if (list_ports != self.ports):
                consoleMsg = self.utils.portObserver(list_ports,self.ports)
                self.ports = list_ports
                self.portSelector.clear()
                for idx, val in enumerate(list_ports):
                    print(idx)
                    self.portSelector.addItem("")
                    self.portSelector.setItemText(idx, self.consoleManager.translate("MainWindow", str(val['name'] + ' - ' + val['port'])))
                self.consoleManager.push2console(consoleMsg)
                self.port_flag = True
                self.disconnect()
            delay(1)
    def port_selector_observer(self): 
        while 1:
            if self.port_flag: 
                self.current_port = self.ports[self.portSelector.currentIndex()]['port'] 
                self.port_flag = False
                self.consoleManager.push2console('Changing port to {}'.format(self.current_port))
            delay(1)

    def change_port(self):
        self.port_flag = True
            
    def connect(self):
        if(self.connected):
            self.disconnect()
        else:
            baudios = int(self.ui.baudSelector.currentText())
            self.connection = self.serial_connect(self.current_port, baudios)
            self.connected = True
            self.consoleManager.push2console('Connection successfully to {}'.format(self.current_port))
            self.connectButton.setText(self.ui.translate("MainWindow", 'Disconnect'))

    def disconnect(self):
        self.connected = False
        if(self.connection):
            self.connection.close()
            self.consoleManager.push2console('Serial disconnected')
            self.connectButton.setText(self.ui.translate("MainWindow", 'Connect'))


    def read_port(self):
        while 1:
            if self.connected:
                msg = self.connection.read()
                self.consoleManager.push2console(msg)

    def wrtie_port(self, port):
        pass
    def list_ports (self):
        return self.get_port_list()
    
