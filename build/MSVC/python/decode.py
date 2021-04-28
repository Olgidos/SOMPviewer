import json
import sys
import os
import math 


def decode(path, name):

  #if len(sys.argv) != 3:
    #sys.exit("Please provide one arg for the data path and one for the output file name!")

  #path = str(sys.argv[1])
  #name = str(sys.argv[2])

  #path = "."
  #name = "data_big"

  #print("Python name:" + sys.argv[0])
  #print("Python name:" + sys.argv[3])
  #print("Python name:" + sys.argv[4])

  in_file = open(path + "/" + name, "rb") 
  #in_file = open("/data_3960537_2021-04-16T15-36-29", "rb") 
  #first 16 hex are for AX25 Origin / Destination 
  in_file.read(16)
  by = bytes(in_file.read()) # if you only wanted to read 512 bytes, do .read(512)
  in_file.close()


  #print(by)
  bits = ''.join(format(byte, '08b') for byte in by)
  #print(bits)

  def getBytes(bits, a, i):
    a = bits[:i]
    bits = bits[i:]
    return a, bits

  #print(len(bits))

  #Standard Beacon 0x30 every 60s 608 bits / 76 bytes
  #Standard Beacon 0x31 every 180s 800 bits / 100 bytes

  if (len(bits) != 608 and len(bits) != 800):
    print("Sat-Data length incorrect! Should be 76 or 100 bytes. Size of " + path + "/" + name + ": " + str(len(bits) / 8))

  if len(bits) == 800: #long beacon
    data = {}
    
    #Message Type
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Message Type []'] = i

    #Telemetry ID
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Telemetry ID []'] = i
    

    #Antenna 1 deployed? (0 - No)
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Antenna 1 deployed? [0-No]'] = i

    #Antenna 2 deployed? (0 - No)
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Antenna 2 deployed? [0-No]'] = i








































    #print(len(bits))
    #print(bits)

    #print(data)

    print("Python: Decode finished long: " + path + "/" + name)

    with open(path + "/decoded" + name.split("data")[1] + ".json", 'w') as f:
      json.dump(data, f, ensure_ascii=False, indent=2)



  if len(bits) == 608: #small beacon
    data = {}

    #Message Type
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Message Type []'] = i

    #Telemetry ID
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Telemetry ID []'] = i

    #OBC Time Stamp
    a = ""
    a, bits = getBytes(bits, a, 32)  
    i = int(a, 2)
    data['OBC Time Stamp [s]'] = i

    #Uptime since last reboot
    a = ""
    a, bits = getBytes(bits, a, 32)  
    i = int(a, 2)
    data['Uptime since last reboot [s]'] = i




    #Battery1 – Voltage
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2.0 + 2500.0
    data['Battery1 - Voltage [mV]'] = i

    #Battery1 – Charge current
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 0.5 - 4094.0
    data['Battery1 - Charge current [mA]'] = i

    #Battery1 – Battery Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['Battery1 - Battery Temperature [0.1 degC]'] = i

    #Battery1 – State of Charge
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Battery1 - State of Charge [%]'] = i





    #Battery2 – Voltage
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2.0 + 2500.0
    data['Battery2 - Voltage [mV]'] = i

    #Battery2 – Charge current
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 0.5 - 4094.0
    data['Battery2 - Charge current [mA]'] = i

    #Battery2 – Battery Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['Battery2 - Battery Temperature [0.1 degC]'] = i

    #Battery2 – State of Charge
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['Battery2 - State of Charge [%]'] = i





    #Y- Panel – Current from SCs to Battery
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.5 - 0.0
    data['Y- Panel - Current from SCs to Battery [mA]'] = i

    #X- Panel – Current from SCs to Battery
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.5 - 0.0
    data['X- Panel - Current from SCs to Battery [mA]'] = i

    #Y+ Panel – Current from SCs to Battery
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.5 - 0.0
    data['Y+ Panel - Current from SCs to Battery [mA]'] = i

    #X+ Panel – Current from SCs to Battery
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.5 - 0.0
    data['X+ Panel - Current from SCs to Battery [mA]'] = i

    #Z+ Panel – Current from SCs to Battery
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.5 - 0.0
    data['Z+ Panel - Current from SCs to Battery [mA]'] = i





    #Y- Panel –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['Y- Panel - Temperature [0.1 degC]'] = i

    #X- Panel –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['X- Panel - Temperature [0.1 degC]'] = i

    #Y+ Panel –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['Y+ Panel - Temperature [0.1 degC]'] = i

    #X+ Panel –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['X+ Panel - Temperature [0.1 degC]'] = i

    #Z+ Panel –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['Z+ Panel - Temperature [0.1 degC]'] = i





    #3V3 Bus –Voltage
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 1.0 + 2789.0
    data['3V3 Bus - Voltage [mV]'] = i

    #3V3 Bus – Current Total
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 1.0 + 0.0
    data['3V3 Bus - Current Total [mA]'] = i

    #3V3 Bus – Current Converter 1
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 1.0 + 0.0
    data['3V3 Bus - Current Converter 1 [mA]'] = i

    #3V3 3V3 Bus – Current Converter 2
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 1.0 + 0.0
    data['3V3 Bus - Current Converter 2 [mA]'] = i





    #CS Module –Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['CS Module - Temperature [0.1 degC]'] = i

    #CS Module – Antenna Deployment 1
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Antenna Deployment 1 [bool]'] = i

    #CS Module – Antenna Deployment 2
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Antenna Deployment 2 [bool]'] = i

    #CS Module – Active System 1
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 1 [bool]'] = i

    #CS Module – Active System 2
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 2 [bool]'] = i

    #CS Module – Active System 3
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 3 [bool]'] = i

    #CS Module – Active System 4
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 4 [bool]'] = i

    #CS Module – Active System 5
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 5 [bool]'] = i

    #CS Module – Active System 6
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['CS Module - Active System 6 [bool]'] = i





    #CS Beacon Interval
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2) 
    data['CS Beacon Interval [s]'] = i

    #OBC Reset Counter
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2)
    data['OBC Reset Counter []'] = i

    #OBC Telemetry Packet ID
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2)
    data['OBC Telemetry Packet ID []'] = i

    #OBC Temperature
    a = ""
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) / 0.7 - 400.0
    data['OBC Temperature [0.1 degC]'] = i

    #OBC CPU Load
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2) 
    data['OBC CPU Load [%]'] = i

    #OBC Last Reboot Reason
    a = ""
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2) 
    data['OBC Last Reboot Reason []'] = i





    #ADCS Eclipsed
    a = ""
    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2) 
    data['ADCS Eclipsed [bool]'] = i

    #ADCS Mode
    a = ""
    a, bits = getBytes(bits, a, 3)  
    i = int(a, 2) 
    data['ADCS Mode [0-off;1-ADS;2-ADCS;3-Detumbling]'] = i

    #OBC Mode
    a = ""
    a, bits = getBytes(bits, a, 4)  
    i = int(a, 2) 
    data['OBC Mode []'] = i




    #ADCS Magnetic Field X (normalised)
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2.0 - 1023.0
    data['ADCS Magnetic Field X (normalised) []'] = i

    #ADCS Magnetic Field Y (normalised)
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2.0 - 1023.0
    data['ADCS Magnetic Field Y (normalised) []'] = i

    #ADCS Magnetic Field Z (normalised)
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2.0 - 1023.0
    data['ADCS Magnetic Field Z (normalised) []'] = i

    #ADCS SunVector X
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2047.0 - 1.0
    data['ADCS Sun Vector X []'] = i

    #ADCS SunVector Y
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2047.0 - 1.0
    data['ADCS Sun Vector Y []'] = i

    #ADCS SunVector Z
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 2047.0 - 1.0
    data['ADCS Sun Vector Z []'] = i


    #ADCS Estimated Attitude q_w
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) / 32767.0 - 1.0
    data['ADCS q_w []'] = i

    #ADCS Estimated Attitude q_x
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) / 32767.0 - 1.0
    data['ADCS q_x []'] = i

    #ADCS Estimated Attitude q_y
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) / 32767.0 - 1.0
    data['ADCS q_y []'] = i

    #ADCS Estimated Attitude q_z
    a = ""
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) / 32767.0 - 1.0
    data['ADCS q_z []'] = i

    #ADCS Estimated Angular Rate X
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = (int(a, 2) / 59.0 - 35.0) / math.pi * 180
    data['ADCS X angluar rate [deg/s]'] = i

    #ADCS Estimated Angular Rate Y
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = (int(a, 2) / 59.0 - 35.0) / math.pi * 180
    data['ADCS Y angluar rate [deg/s]'] = i

    #ADCS Estimated Angular Rate Z
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = (int(a, 2) / 59.0 - 35.0) / math.pi * 180
    data['ADCS Z angluar rate [deg/s]'] = i

    #print(len(bits))
    #print(bits)

    #print(data)

    print("Python: Decode finished short: " + path + "/" + name)

    with open(path + "/decoded" + name.split("data")[1] + ".json", 'w') as f:
      json.dump(data, f, ensure_ascii=False, indent=2)



directory = 'download'

for filename in os.listdir(directory):
    if filename.startswith("data_"):
        decode(directory, filename)
    else:
        continue
