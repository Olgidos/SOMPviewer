# SOMPviewer

Developed for the TU Dresden Nanosat SOMP2b Norad ID: 47445

![plot](./image1.png)

Features:
 - Receive transmission data from the SatNOGS network (Rest API), decode and represent
 - Satellite orbit visualization of position and attitude
 - Predict passes and satellite eclipse times
 - Model backend based on NAIF CSPICE
 - The Software can easily be used for different satellites. Therefore a custom transmission decoding script is required similar to "./python/decode.py". It decodes the binary data into .json files. The name convention must be kept similar.
 - All downloaded RAW and Metadata as well as the decoded .json files are saved under "./download". 
    - To use the attitude visualization the data must contain:
    - "q_ib_w [deg]" (Quaternion scalar ECI to Satellite Frame)
    - "q_ib_i [deg]" (Quaternion X ECI to Satellite Frame)
    - "q_ib_j [deg]" (Quaternion Y ECI to Satellite Frame)
    - "q_ib_k [deg]" (Quaternion Z ECI to Satellite Frame)
    - "angular_rate_x [deg/s]"
    - "angular_rate_y [deg/s]"
    - "angular_rate_z [deg/s]"

![plot](./image2.png)
![plot](./image3.png)

Build:
MSVC2019 64 bit
Recommended build folder: "./build/"
Build requirements (all already provided in the recommended build folder):
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
