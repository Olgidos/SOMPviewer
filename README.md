# SOMPviewer

Developed for the TU Dresden Nanosat SOMP2b Norad ID: 47445

![plot](./image1.jpg)

Features:
 - Receive transmission data from the SatNOGS network (Rest API), decode and represent it
 - Satellite orbit visualization of position and attitude
 - Predict passes and satellite eclipse times
 - Model backend based on NAIF CSPICE
 - The Software can easily be used for different satellites. Therefore a custom transmission decoding script is required similar to "./python/decode.py". It decodes the binary data into .json files. The name convention must be kept similar.
 - All downloaded RAW and Metadata as well as the decoded .json files are saved under "./download". 
    - To use the attitude visualization the data must contain:
    - "Roll angle [deg]"
    - "Pitch angle [deg]"
    - "Yaw angle [deg]"
    - "X angluar rate [deg/s]"
    - "Y angluar rate [deg/s]"
    - "Z angluar rate [deg/s]"

![plot](./image2.jpg)
![plot](./image3.jpg)

Build:
MSVC2019 64 bit
Recommended build pass: "./build/MSVC"
Build requirements (all provided in the recommended build pass):
 - Installed python
 - OpenSSL extensions
    - "./libcrypto-1_1-x64.dll"
    - "./libssl-1_1-x64.dll"
 - Python extension
    - "./python3.dll"
    - "./python39.dll"
 - Kernel data provided and linked in meta kernel and NAIF "brief.exe"
    - "./kernels/meta.ker"
    - "./kernels/brief.exe"
 - An output and download path 
    - "./output"
    - "./download"
 - A python decoder fitting to the satellite data coding
    - "./python/decode.py"