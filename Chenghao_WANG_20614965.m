% Chenghao WANG
% ssycw12@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

a = arduino('COM3', 'Uno');

for i = 1:5
    writeDigitalPin(a, 'D13', 1);  % 点亮LED
    pause(1);
    writeDigitalPin(a, 'D13', 0);  % 熄灭LED
    pause(1);
end
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here