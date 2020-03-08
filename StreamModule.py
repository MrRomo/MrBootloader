
from collections import deque as dq 
from PyQt5 import QtCore
from ConsoleManager import ConsoleManager

class StreamModule():
    
    def __init__(self, consoleText, portBox):
        self.console_manager = ConsoleManager(consoleText)
        self.portBox = portBox
        self.consoleText = consoleText
        self.head = """<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n 
            <html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n
            "p, li { white-space: pre-wrap; }\n"
            </style></head><body style=\" font-family:\'Sans Serif\'; font-size:9pt; font-weight:400; font-style:normal;\">\n"""
        self.foot = "</body></html>"
    

    
    def stream_ports(self, port_list):
        ports = []
        for i in port_list:
            ports.append(self.set_item_console(i))
        self.console_manager.refresh_console(ports)

    def set_item_console(self, message):
        item = "<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">{}</p>\n".format(message)
        return self.head+item+self.foot


