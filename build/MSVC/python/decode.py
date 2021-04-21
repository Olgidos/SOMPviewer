import json
import sys
import os



def decode(path, name):

  #if len(sys.argv) != 3:
    #sys.exit("Please provide one arg for the data path and one for the output file name!")

  #path = str(sys.argv[1])
  #name = str(sys.argv[2])

  #path = "data"
  #name = "out"

  #print("Python name:" + sys.argv[0])
  print("Python From:" + path)
  print("Python to:" + name)
  #print("Python name:" + sys.argv[3])
  #print("Python name:" + sys.argv[4])

  in_file = open(path + "/" + name, "rb") 
  #in_file = open("/data_3960537_2021-04-16T15-36-29", "rb") 
  #first 16 hex are for AX25 Origin / Destination 
  in_file.read(16)
  by = bytes(in_file.read()) # if you only wanted to read 512 bytes, do .read(512)
  in_file.close()

  #print(by)

  #print(by)
  bits = ''.join(format(byte, '08b') for byte in by)
  #print(bits)

  def getBytes(bits, a, i):
    a = bits[:i]
    bits = bits[i:]
    return a, bits

  #print(len(bits))

  if len(bits) != 608:
    print("Sat-Data length incorrect! Should be 74 bytes. Size of " + path + ": " + str(len(bits) / 8))

  if len(bits) == 608:
    data = {}

    #Battery voltage
    a = ""
    a, bits = getBytes(bits, a, 12)  
    i = int(a, 2) / 4096 * 3.3 * 3.133
    data['Battery Voltage [V]'] = i

    #Temperature OBC
    a, bits = getBytes(bits, a, 12)  
    i = (int(a, 2) - 2133) * 55/371 + 30
    data['Temperature OBC [degC]'] = i

    #Battery current
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 5.4311 + 4636.0085
    data['Battery current [A]'] = i

    #Reg.Bus 3V3 current
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 5.4311 + 4636.0085
    data['Reg.Bus 3V3 [A]'] = i

    #Reg.Bus 5V0 current
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 5.4311 + 4636.0085
    data['Reg.Bus 5V0 [A]'] = i

    #Temperature UHF
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2)
    data['Temperature UHF [degC]'] = i

    #OBC Mode
    a, bits = getBytes(bits, a, 4)  
    i = int(a, 2)
    data['OBC Mode [0 = initialisation, 1 = deployment, 2 = Phase 0, 3 = Phase 1, 4 = Phase 2, 5 = Low Power Mode, 6 = Phase 3, 7 = Phase 4, 8 = safe mode]'] = i

    #Reason for mode change
    a, bits = getBytes(bits, a, 3)  
    i = int(a, 2)
    data['Reason for mode change [0 = system reset, 1 = command, 2 = Timeout, 3 = Under-voltage, 4 = Accelerometer, 5 = IMU, 6 = GPS, 7 = Thermocouple]'] = i

    #OBC uptime
    a, bits = getBytes(bits, a, 32)  
    i = int(a, 2)
    data['OBC uptime [s]'] = i

    #OBC boot counter
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['OBC boot counter []'] = i

    #OBC packet counter (sent)
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2)
    data['OBC packet counter (sent) []'] = i

    #OBC TC received (correct frame)
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['OBC TC received (correct frame) []'] = i

    #OBC TC valid (correct command, executed)
    a, bits = getBytes(bits, a, 8)  
    i = int(a, 2)
    data['OBC TC valid (correct command, executed) []'] = i

    #Systems on
    # a, bits = getBytes(bits, a, 26)  
    # i = int(a, 2)
    # data['Systems on []'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Platform I2C [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Platform interfacing [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: UHF [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: GPS [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: ADCS [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: IMU [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Pressure sensor [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: UHF communications [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: GPS communications [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: XPL [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: AeroSDS 3.3V [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: AeroSDS 5V [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Iridium 3.3V [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Iridium 27V [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: UlG [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: EGSE [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: EGSE 1 communications [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: GSE 2 communications [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: XPL power good [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: AeroSDS 3.3V power good [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: AeroSDS 5V power good [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: UHF1 [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: IMU data ready [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Accelerometer data ready [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Iridium CTS [1 = on, 2 = off]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['System on: Iridium DCD [1 = on, 2 = off]'] = i

    #Deployable status
    # a, bits = getBytes(bits, a, 13)  
    # i = int(a, 2)
    # data['Deployable status []'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -Y antenna [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -X antenna [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +Y antenna [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +X antenna [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: deployment enable [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +X panel [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +Y panel [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -Y panel [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -X panel [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +X panel being released [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: +Y panel being released [1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -Y panel being released[1 = true, 2 = false]'] = i

    a, bits = getBytes(bits, a, 1)  
    i = int(a, 2)
    data['Deployable status: -X panel being released [1 = true, 2 = false]'] = i



    #Solar panel current +Xi
    a, bits = getBytes(bits, a, 10) 
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current +Xi [mA]'] = i

    #Solar panel current +Xo
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current +Xo [mA]'] = i

    #Solar panel current -Yi
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current -Yi [mA]'] = i

    #Solar panel current -Yo
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current -Yo [mA]'] = i

    #Solar panel current -Xi
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current -Xi [mA]'] = i

    #Solar panel current -Xo
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current -Xo [mA]'] = i

    #Solar panel current +Yi
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current +Yi [mA]'] = i

    #Solar panel current +Yo
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * 0.5431 + 528.5093
    data['Solar panel current +Yo [mA]'] = i

    #SolarPanel Voltage +X
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * -0.0148 + 22.7614
    data['SolarPanel Voltage +X [V]'] = i

    #SolarPanel Voltage -Y
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * -0.0148 + 22.7614
    data['SolarPanel Voltage -Y [V]'] = i

    #SolarPanel Voltage -X
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * -0.0148 + 22.7614
    data['SolarPanel Voltage -X [V]'] = i

    #SolarPanel Voltage +Y
    a, bits = getBytes(bits, a, 10)  
    i = int(a, 2) * -0.0148 + 22.7614
    data['SolarPanel Voltage +Y [V]'] = i

    #ADCS state
    a, bits = getBytes(bits, a, 2)  
    i = int(a, 2)
    data['ADCS state [0 = disabled, 1 = enabled, 2 = triggered]'] = i

    #Attitude Estimation Mode
    a, bits = getBytes(bits, a, 3)  
    i = int(a, 2)
    data['Attitude Estimation Mode [0 = no attitude estimation, 1 = MEMS rate sensing, 2 = Magnetometer rate filter, 3 = magnetometer rate filter with pitch estimation, 4 = full-state EKF, 5= magnetometer and fine sun TRIAD algorith]'] = i

    #Control Mode
    a, bits = getBytes(bits, a, 3)  
    i = int(a, 2)
    data['Control Mode [0 = no control, 2 = detumbling control, 3 = Y-momentum stabilized -Initial pitch acquisition, 4 = Y-momentum stabilized -steady state]'] = i

    #CubeControl 3V3 current
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) * 0.48828125
    data['CubeControl 3V3 current [mA]'] = i

    #CubeControl 5V current
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) * 0.48828125
    data['CubeControl 5V current [mA]'] = i

    #CubeControl Vbat current
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) * 0.48828125
    data['CubeControl Vbat current [mA]'] = i

    #Magnetorquer Current
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) * 0.1
    data['Magnetorquer Current [mA]'] = i

    #Momentum Wheel Current
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2) * 0.01
    data['Momentum Wheel Current [mA]'] = i

    #Magnetic Field X
    a, bits = getBytes(bits, a, 16) 
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 10 / 1000
    data['Magnetic Field X [nT]'] = i

    #Magnetic Field Y
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 10 / 1000
    data['Magnetic Field Y [nT]'] = i

    #Magnetic Field Z
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 10 / 1000
    data['Magnetic Field Z [nT]'] = i

    #Y Angular Rate
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Y Angular Rate [deg/s]'] = i

    #Y Wheel Speed
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) )
    data['Y Wheel Speed [rpm]'] = i

    #Estimated roll angle
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Roll angle [deg]'] = i

    #Estimated pitch angle
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Pitch angle [deg]'] = i

    #Estimated yaw angle
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Yaw angle [deg]'] = i

    #Estimated X angluar rate
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['X angluar rate [deg/s]'] = i

    #Estimated Y angluar rate
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Y angluar rate [deg/s]'] = i

    #Estimated Z angluar rate
    a, bits = getBytes(bits, a, 16)  
    i = ( (int(a, 2) + pow(2, 15)) % pow(2, 16) - pow(2, 15) ) * 0.01
    data['Z angluar rate [deg/s]'] = i

    #Temperature ADCS (ARM CPU)
    a, bits = getBytes(bits, a, 16)  
    i = int(a, 2)
    data['Temperature ADCS (ARM CPU) [degC]'] = i


    #print(bits)

    #print(data)

    print("Python: Decode finished: " + name)

    with open(path + "/decoded" + name.split("data")[1] + ".json", 'w') as f:
      json.dump(data, f, ensure_ascii=False, indent=2)



directory = r'download'

for filename in os.listdir(directory):
    if filename.startswith("data_"):
        decode(directory, filename)
    else:
        continue
