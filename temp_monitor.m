function temp_monitor(a)
% TEMP_MONITOR Monitors temperature and controls LEDs
%   temp_monitor(a) monitors temperature using Arduino(a) for 600 seconds
%   LED Configuration:
%   - Green: Constant on when temperature is 18-24°C
%   - Yellow: Blinking (0.5s) when below 18°C
%   - Red: Blinking (0.25s) when above 24°C
%   The function also plots live temperature data.

% Configure pins
sensorPin = 'A0';
greenPin = 'D9';
yellowPin = 'D10';
redPin = 'D11';
duration = 600;
V0 = 0.5;   % Voltage at 0°C
Tc = 0.01;  % Temperature coefficient (V/°C)

% Initialize figure
figure;
h = plot(0,0);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Live Temperature Monitoring');
grid on;
hold on;

% Initialize data
timeData = 0:duration-1;
tempData = zeros(1, duration);

% Read temperature
for i = 1:duration
    voltage = readVoltage(a, sensorPin);
    temp = (voltage-V0)/Tc;
    tempData(i) = temp;

% Update plot
    set(h, 'XData', timeData(1:i)/60, 'YData', tempData(1:i));
    xlim([0 duration/60]);
    ylim([min(tempData(1:i))-1 max(tempData(1:i))+1]);
    drawnow;

% Control LEDs
    if temp >= 18 && temp <= 24 % green LED on
        writeDigitalPin(a, greenPin, 1);
        writeDigitalPin(a, yellowPin, 0);
        writeDigitalPin(a, redPin, 0);
        pause(1);
    elseif temp < 18 % yellow LED blinking
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, redPin, 0);
        writeDigitalPin(a, yellowPin, 1);
        pause(0.5);
        writeDigitalPin(a, yellowPin, 0);
        pause(0.5);
    elseif temp > 24 % red LED blinking
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, yellowPin, 0);
        writeDigitalPin(a, redPin, 1);
        pause(0.25);
        writeDigitalPin(a, redPin, 0);
        pause(0.25);
    end
 end
