% Chenghao WANG
% ssycw12@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

a = arduino('COM3', 'Uno');

for i = 1:5
    writeDigitalPin(a,'D13',1); % LED on
    pause(0.5);
    writeDigitalPin(a,'D13',0); % LED off
    pause(0.5);
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

V0 = 0.5;   % Voltage at 0°C
Tc = 0.01;  % Temperature coefficient (V/°C)
duration = 600;
interval = 1;
temperatures = zeros(1,duration);
time = 0:interval:(duration - interval);

% Read temperature data
for i = 1:duration
    voltage = readVoltage(a,'A0'); 
    temperatures(i) = (voltages(i)-V0)/Tc; % Convert to temperature
    pause(interval)
end

% Calculate statistics
minTemp = min(temperatures);
maxTemp = max(temperatures);
avgTemp = mean(temperatures);

% Plot temperature data
plot(time / 60, temperatures);
xlabel('Time (min)');
ylabel('Temperature (°C)');
title('Temperature vs Time');

% Print data
date = datetime('now', 'Format', 'dd/MM/yyyy');
location = 'Ningbo';

sprintf('Data logging initiated - %s\n', date);
sprintf('Location - %s\n\n', location);

fid= fopen('cabin_temp.txt', 'w');
fprintf(fid, 'Data logging initiated - %s\n', date);
fprintf(fid, 'Location - %s\n\n', location);

for i = 1:duration/60
    sprintf('Minute\t\t%d\n', i-1);
    sprintf('Temperature \t%.2f C\n\n', temperatures(i*60));
    
    fprintf(fid, 'Minute\t\t%d\n', i-1);
    fprintf(fid, 'Temperature \t%.2f C\n\n', temperatures(i*60));
end

sprintf('Max temp\t%.2f C\n', maxTemp);
sprintf('Min temp\t%.2f C\n', minTemp);
sprintf('Average temp\t%.2f C\n', avgTemp);
sprintf('\nData logging terminated\n');


fprintf(fid, 'Max temp\t%.2f C\n', maxTemp);
fprintf(fid, 'Min temp\t%.2f C\n', minTemp);
fprintf(fid, 'Average temp\t%.2f C\n', avgTemp);
fprintf(fid, '\nData logging terminated\n');

fclose(fid);


%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a,duration)


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

temp_prediction(a,duration)


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% CHALLENGES: Implementing this temperature monitoring system presented several technical challenges.
% Synchronizing real-time data acquisition with LED control while maintaining precise 1-second intervals.
% Debugging the physical circuit connections, proved time-consuming but educational.
%
% STRENGTHS: The system's key strength lies in its modular design, separating core functionalities into distinct, well-documented functions.
% The implementation provides comprehensive real-time feedback through both visual (LEDs) and textual (command window) outputs.
% The live plot effectively visualizes temperature trends, while the log file creation provides persistent data storage.
%
% LIMITATIONS: Current limitations include the assumption of linear temperature changes for predictions, which may not hold true in all scenarios.
% The system lacks hysteresis in its alert thresholds, potentially causing rapid LED toggling near boundary conditions.
% The fixed 1-second sampling interval doesn't adapt to changing conditions. Sensor calibration drift over time isn't accounted for,
% and the system has no capability for automated temperature correction, only monitoring.
%
% FUTURE IMPROVEMENTS:
% Implementing PID control to actively regulate temperature rather than just monitor it.
% Adding audible alarms alongside visual indicators.
% Incorporating humidity sensing for more comprehensive comfort monitoring.
% Implementing adaptive sampling rates that increase during rapid temperature changes.
% Adding hysteresis to alert thresholds to prevent flickering.
% Including self-calibration routines to maintain sensor accuracy. 
%
% This project significantly enhanced my skills in real-time system design, hardware-software integration, and MATLAB programming.
% The experience of developing a complete functional prototype from sensor input to actionable outputs provided valuable insights into embedded systems development challenges and solutions.