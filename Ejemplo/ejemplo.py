import serial
import sys

with open('Tester_clean.hex', 'r') as f:
    archivo = f.read().split('\n')

archivo.pop()
print(archivo)
print(type(archivo))
# puerto = serial.Serial('COM4', 9600,  rtscts = True) # rtscts = False PARA PROTEUS !!!!!!!!!!!
puerto = serial.Serial('COM1', 9600,  rtscts = False) # rtscts = False PARA PROTEUS !!!!!!!!!!!

for linea in archivo:
    while 1:
        puerto.write(linea.encode())

        respuesta = puerto.readline().decode()

        if(respuesta == 'OK\n'):
            print('Linea enviada correctamente...')
            break
        
        elif(respuesta == 'BAD\n'):
            print('Checksum invalido, reenviando...')
        
print('Grabado finalizado...')
        

