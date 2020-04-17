# Siglent_SDS1202X-E_VISA_MATLAB
MATLAB functions for easy, data acquisition from the Siglent SDS1202X-E oscilloscope via USB or Ethernet.

### Supported models
- SDS1xxxCFL - series
- SDS1xxxA - series
- SDS1xxxCML+/CNL+/DL+/E+/F+ - series
- SDS2xxx/2xxxX - series
- SDS1xxxX/1xxxX+ - series
- SDS1xxxX-E/X-C - series

### Installation
There is no installation required. Just download the MATLAB-functions (from [Releases](https://github.com/dadul96/Siglent_SDS1202X-E_VISA_MATLAB/releases)) and move them into your work folder.

### Requirements
* [NI-VISA 19.5](https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html#329456)

### How to use
Following functions can be called:
* **[vDiv, tDiv, offs, sCount, sRate] = determineAcquisitionSettings(connStr, channel)**
    - **vDiv** - Volts/Devition
    - **tDiv** - Time/Devition
    - **offs** - Vertical offset
    - **sCount** - Number of samples
    - **sRate** - Sampling rate
    
    - **connStr** - Enter VISA USB resourcename (e.g. `'USB0::0xF4EC::0xEE38::0123456789::INSTR'`) or enter the IP address (e.g. `'10.0.0.12'`). If you don't enter anything or just `''` the IP address stored in the DEFAULT_IP-variable will be used.
    - **channel** - Enter the oscilloscope channel (e.g. `1`). If you don't enter anything or just `''` the channel stored in the DEFAULT_CHANNEL-variable will be used.
* **[timeOut, dataOut, sRate] = acquireOscilloscopeData(connStr, channel)** (uses `determineAcquisitionSettings`)
    - **timeOut** - Array containing the time axis
    - **dataOut** - Array containing the meassured data
    - **sRate** - Sampling rate
    
    - **connStr** - Enter VISA USB resourcename (e.g. `'USB0::0xF4EC::0xEE38::0123456789::INSTR'`) or enter the IP address (e.g. `'10.0.0.12'`). If you don't enter anything or just `''` the IP address stored in the DEFAULT_IP-variable will be used.
    - **channel** - Enter the oscilloscope channel (e.g. `1`). If you don't enter anything or just `''` the channel stored in the DEFAULT_CHANNEL-variable will be used.
* **acquireAndDisplay(connStr, channel)** (uses `acquireOscilloscopeData`)
    - Plots the acquired data into a new figure.
    - **connStr** - Enter VISA USB resourcename (e.g. `'USB0::0xF4EC::0xEE38::0123456789::INSTR'`) or enter the IP address (e.g. `'10.0.0.12'`). If you don't enter anything or just `''` the IP address stored in the DEFAULT_IP-variable will be used.
    - **channel** - Enter the oscilloscope channel (e.g. `1`). If you don't enter anything or just `''` the channel stored in the DEFAULT_CHANNEL-variable will be used.

### Author
**Daniel Duller** - [dadul96](https://github.com/dadul96)

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
