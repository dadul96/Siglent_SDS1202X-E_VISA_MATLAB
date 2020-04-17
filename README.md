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
* **[timeOut, dataOut, sRate] = acquireOscilloscopeData(connStr, channel)**
* **acquireAndDisplay(connStr, channel)**


### Author
**Daniel Duller** - [dadul96](https://github.com/dadul96)

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
