function [timeOut, dataOut, sRate] = acquireOscilloscopeData(connStr, channel)
%Acquires data from the Siglent SDS1202X-E oscilloscope.
%
%Dependencies :  - "determineAcquisitionSettings.m"
%
%[timeOut, dataOut] = acquireOscilloscopeData(connStr, channel)
%connStr  :  enter VISA USB resourcename 
%            (e.g. 'USB0::0xF4EC::0xEE38::0123456789::INSTR') 
%            or enter the IP address (e.g. '10.0.0.12')
%channel  :  enter 1 for 1st or 2 for 2nd channel
%
%timeOut  :  measured time values
%dataOut  :  measured data values
%sRate    :  sample rate
%
%Version: 1.0.1  |  Date: 18.04.2020  |  Daniel Duller

% define constants:
TIMEOUT = 5;                % seconds
DATA_HEADER_LENGTH = 16;    % bytes
DATA_END_LENGTH = 2;        % bytes
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

% determine acquisition settings:
[vDiv, tDiv, offs, sCount, sRate] = determineAcquisitionSettings(connStr, channel);

% generate VISA object depending on the connection type:
if contains(connStr,'USB')
    visaObj = visa('ni',connStr);
else
    visaObj = visa('ni',['TCPIP0::',connStr,'::INSTR']);
end

% VISA object settings:
visaObj.InputBufferSize = sCount + DATA_HEADER_LENGTH + DATA_END_LENGTH;
visaObj.Timeout = TIMEOUT;

% open VISA object:
fopen(visaObj);

% set response header to OFF:
fwrite(visaObj, 'CHDR OFF');
flushoutput(visaObj);

% acquire raw data:
if channel == 1
    fwrite(visaObj, 'C1:WF? DAT2');
else
    fwrite(visaObj, 'C2:WF? DAT2');
end
flushoutput(visaObj);
rawData = fread(visaObj);
flushinput(visaObj);

% close VISA object
fclose(visaObj);
delete(visaObj);
clear visaObj;

% extract measurement data:
data = rawData((DATA_HEADER_LENGTH+1):(end-DATA_END_LENGTH));

% determine output array size:
outputSize = size(data);

% decode time:
timeOut = zeros(outputSize);
for i = 1:1:outputSize
    timeOut(i) = -(tDiv*14/2) + ((i-1)*(1/sRate));
end

% decode raw data:
dataOut = zeros(outputSize);
for i = 1:1:outputSize
    if data(i) > 127
        data(i) = data(i) - 255;
    end
    dataOut(i) = data(i)*(vDiv/25)-offs;
end

end

