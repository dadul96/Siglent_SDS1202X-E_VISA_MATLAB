function acquireAndDisplay(connStr, channel)
%Acquires data from the Siglent SDS1202X-E oscilloscope and plots it.
%
%Dependencies :  - "acquireOscilloscopeData.m"
%                - "determineAcquisitionSettings.m"
%
%acquireAndDisplay(connStr, channel)
%connStr  :  enter VISA USB resourcename 
%            (e.g. 'USB0::0xF4EC::0xEE38::0123456789::INSTR') 
%            or enter the IP address (e.g. '10.0.0.12')
%channel  :  enter 1 for 1st or 2 for 2nd channel
%            or enter 12 for both channels
%
%Version: 1.0.0  |  Date: 14.04.2020  |  Daniel Duller

% define constants:
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

% acquire data:
[timeOut, dataOut, ~] = acquireOscilloscopeData(connStr, channel);

% calculate the plot x-limits:
dataLength = length(dataOut);
xMin = timeOut(1);
xMax = timeOut(dataLength);

% calculate the plot y-limits:
borderDist = peak2peak(dataOut)/10;
yMin = min(dataOut) - borderDist;
yMax = max(dataOut) + borderDist;

% plot the acquired data:
figure('Name', 'Acquired Scope Data');
plot(timeOut, dataOut);
xlim([xMin, xMax]);
ylim([yMin, yMax]);
title('Signal in Time Domain');
xlabel('Time [s]');
ylabel('Amplitude [V]');
grid on;

% display signal properties:
rmsValue = rms(dataOut);
arvValue = (1/dataLength) * sum(abs(dataOut));
pTotal = (1/dataLength) * sum(dataOut.^2);

fprintf("Minimum:     % f [V] \n", min(dataOut));
fprintf("Maximum:     % f [V] \n", max(dataOut));
fprintf("Peak-Peak:   % f [V] \n", peak2peak(dataOut));
fprintf("Average:     % f [V] \n", mean(dataOut));
fprintf("RMS:         % f [V] \n", rmsValue);
fprintf("ARV:         % f [V] \n", arvValue);
fprintf("F:           % f     \n", rmsValue/arvValue);
fprintf("C:           % f     \n", abs(max(dataOut))/rmsValue);
fprintf("Total Power: % f [W] \n", pTotal);

end

