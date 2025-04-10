% Chenghao WANG
% ssycw12@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

a = arduino('COM3', 'Uno');

for i = 1:5
    writeDigitalPin(a,'D13',1); % LED on
    pause(1);
    writeDigitalPin(a,'D13',0); % LED off
    pause(1);
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

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here