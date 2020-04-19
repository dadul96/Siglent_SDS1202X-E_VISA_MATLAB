function [vDiv, tDiv, offs, sCount, sRate] = determineAcquisitionSettings(connStr, channel)
%Returns the acquisition settings of the Siglent SDS1202X-E oscilloscope.
%
%[vDiv, tDiv, offs, sCount, sRate] = determineAcquisitionSettings(connStr, channel)
%connStr  :  enter VISA USB resourcename 
%            (e.g. 'USB0::0xF4EC::0xEE38::0123456789::INSTR') 
%            or enter the IP address (e.g. '10.0.0.12')
%channel  :  enter 1 for 1st or 2 for 2nd channel
%
%vDiv     :  voltage per devision
%tDiv     :  time    per devision
%offs     :  signal offset
%sCount   :  sample count
%sRate    :  sample rate
%
%Version: 1.0.1  |  Date: 18.04.2020  |  Daniel Duller

% define constants:
INPUT_BUFFER_SIZE = 2^9;   % 512 bytes
TIMEOUT = 2;               % seconds
DEFAULT_IP = '10.0.0.12';
DEFAULT_CHANNEL = 1;

% handle function attributes:
try 
    if isempty(connStr)
        connStr = DEFAULT_IP;
    end
catch
    connStr = DEFAULT_IP;
end
try 
    if isempty(channel)
        channel = DEFAULT_CHANNEL;
    end
catch
    channel = DEFAULT_CHANNEL;
end

% generate VISA object depending on the connection type:
if contains(connStr,'USB')
    visaObj = visa('ni',connStr);
else
    visaObj = visa('ni',['TCPIP0::',connStr,'::INSTR']);
end

% VISA object settings:
visaObj.InputBufferSize = INPUT_BUFFER_SIZE;
visaObj.Timeout = TIMEOUT;

% open VISA object:
fopen(visaObj);

% set response header to OFF:
fwrite(visaObj, 'CHDR OFF');
flushoutput(visaObj);

% get acquisition settings:
if channel == 1
    vDiv = str2double(query(visaObj, 'C1:VDIV?'));
    offs = str2double(query(visaObj, 'C1:OFST?'));
    sCount = str2double(query(visaObj, 'SANU? C1'));
else
    vDiv = str2double(query(visaObj, 'C2:VDIV?'));
    offs = str2double(query(visaObj, 'C2:OFST?'));
    sCount = str2double(query(visaObj, 'SANU? C2'));
end
tDiv = str2double(query(visaObj, 'TDIV?'));
sRate = str2double(query(visaObj, 'SARA?'));
flushinput(visaObj);

% close VISA object
fclose(visaObj);
delete(visaObj);
clear visaObj;

end

