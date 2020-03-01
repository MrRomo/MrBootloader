import serial 
import serial.tools.list_ports as port_list

class SerialCommunication:

    def __init__(self):
        self.ports = port_list
        self.serial_connect = serial.Serial
    
    def get_port_list(self):
        ports = list(self.ports.comports())
        return ports

    def connect(self, port):
        ser = self.serial_connect(port, 9600)
        return ser

