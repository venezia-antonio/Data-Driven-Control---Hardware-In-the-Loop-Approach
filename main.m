clear all
clc
close all
%% Experimental Data and Results
Ts = 0.05;
N = 15000;
pathIn = 'C:\Users\anton\Documents\MEGA\TemperatureControl\Batch Data\Experimental Data\batch3Output.txt';
[Y,U] = readFromFile(N,pathIn);

%pathOut = 'C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\Results\ArduinoCaptureMix2.txt';
pathOut = 'C:\Users\anton\Documents\MEGA\TemperatureControl\Batch Data\Results\ArduinoCaptureMixPID.txt';
[temperature,setpoint,thrust] = readFromFileOutput(pathOut);
temperature = temperature(1:2500/0.05);
setpoint = setpoint(1:2500/0.05);
thrust = thrust(1:2500/0.05);
%% Load Data
% load NN_Temperature_Control
%% Plot Experimental Data and Results
figure('NumberTitle', 'off', 'Name','Experimental Data')
sgtitle('Experimental Data')
t = 0:Ts:((length(Y)-1)*Ts);
subplot(211)
grid minor,hold on
plot(t,Y);xlabel('Time [s]');ylabel('Temperature [°C]')
subplot(212)
grid minor,hold on
plot(t,U);xlabel('Time [s]');ylabel('Thrust [%]')


figure('NumberTitle', 'off', 'Name','Results')
sgtitle('Results')
t = 0:Ts:((length(temperature)-1)*Ts);
subplot(211)
grid minor,hold on
plot(t,temperature,t,setpoint);xlabel('Time [s]');ylabel('Temperature [°C]')
legend('Temperature','Setpoint')
subplot(212)
grid minor,hold on
plot(t,thrust);xlabel('Time [s]');ylabel('Thrust [%]')
ylim([0 120])

%% Functions
function [Y,U] = readFromFile(N,path)
fileID = fopen(path,'r');
formatSpec = '%f %f';
sizeA = [2 Inf];
vec = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
vec = vec(3:2*N+2);
Y = vec(1:2:end);
U = vec(2:2:end);
end
function [temperature,setpoint,thrust] = readFromFileOutput(path)
fileID = fopen(path,'r');
formatSpec = '%f %f %f';
sizeA = [3 Inf];
y = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
temperature = y(1,:);
setpoint = y(2,:);
thrust = y(3,:);
end
