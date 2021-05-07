import json
import sys
import os
import math 
import io
import re

sys.path.append(sys.argv[0])
from somp2b import *

directory = 'download'
kaitai_def = 'python/ksy_somp2b.ksy'


def getDocName(name):
  with open(kaitai_def) as f:
      searchlines = f.readlines()

  string = ""

  for i, line in enumerate(searchlines):
      if "id: " + name + "\n"  in line: 
          string = searchlines[i+2].replace('\t', ' ')
  
  if "doc:" in string:
    string_list = re.findall(r"'([^']*)'", string)
    if len(string_list) == 1:
      return string_list[0]

  return name + " [ ]"

      


def decode(path, name):
  file = os.path.join(directory, filename)
  file_stats = os.stat(file)

  if file_stats.st_size > 50:
    target = Somp2b.from_file(file)
    beacon_flag2 = target.ax25_frame.payload.ax25_info.beacon_header.beacon_header_flags2

    if (beacon_flag2 == 48) or (beacon_flag2 == 49):
      payload = target.ax25_frame.payload.ax25_info.beacon_payload
      
      data = {}
      members = [attr for attr in dir(payload) if not callable(getattr(payload, attr)) and not attr.startswith("__") and not attr.startswith("_")]
      for m in members:
        attribute = getattr(payload, m)
        data[getDocName(m)] = attribute

      with open(path + "/decoded" + name.split("data")[1] + ".json", 'w') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
      print("Python: Decode finished short: " + path + "/" + name)

    else:
      print("Beacon is not matching Kaitai Struct!")
  else:
    print("File is too short to contain AX.25 frame!")


for filename in os.listdir(directory):
    if filename.startswith("data_"):
        decode(directory, filename)
