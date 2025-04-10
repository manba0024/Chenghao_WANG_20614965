function temp_prediction(a,duration)
% TEMP_PREDICTION Predicts temperature trends and alerts for rapid changes
%   temp_prediction(a, duration) monitors temperature using Arduino(a) for 'duration' seconds, 
%   predicting future temperature and alerting for rapid changes (>4°C/min).
%   LED Configuration:
%   - Green: Stable temperature in comfort range
%   - Red: Temperature increasing too rapidly (>4°C/min)
%   - Yellow: Temperature decreasing too rapidly (<-4°C/min)

% Configure pins
sensorPin = 'A0';
greenPin = 'D9';
yellowPin = 'D10';
redPin = 'D11';
V0 = 0.5;   % Voltage at 0°C
Tc = 0.01;  % Temperature coefficient (V/°C)

% Initialize data storage
timeLog = zeros(1, duration);
tempLog = zeros(1, duration);

for i = 1:duration
    timeLog(i) = i;

    % Read temperature
    voltage = readVoltage(a, sensorPin);
    temp = (voltage-V0)/Tc;
    tempLog(i) = temp;

    if i >= 2
        rate = (tempLog(i) - tempLog(i-1)) * 60; % Convert to °C/min
    else
        rate = 0; % No rate for the first reading
    end

    temp_pred = temp + rate*5;
    fprintf('Current temp: %.2f°C, Rate: %.2f°C/min, ', temp, rate);
    fprintf('Predicted in 5 min: %.2f°C\n', temp_pred);

% Control LEDs
    if abs(rate) <= 4/60 && temp >= 18 && temp <= 24
        % Stable and in comfort range, green LED
        writeDigitalPin(a, greenPin, 1);
        writeDigitalPin(a, redPin, 0);
        writeDigitalPin(a, yellowPin, 0);
    elseif rate > 4/60
        % Increasing too fast, red LED
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, redPin, 1);
        writeDigitalPin(a, yellowPin, 0);
    elseif rate < -4/60
        % Decreasing too fast, yellow LED
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, redPin, 0);
        writeDigitalPin(a, yellowPin, 1);
    else
        % Outside comfort range but stable rate
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, redPin, 0);
        writeDigitalPin(a, yellowPin, 0);
    end
    
    pause(1); % 1 second cycle
end

% Turn off all LEDs when done
writeDigitalPin(a, greenPin, 0);
writeDigitalPin(a, redPin, 0);
writeDigitalPin(a, yellowPin, 0);
end