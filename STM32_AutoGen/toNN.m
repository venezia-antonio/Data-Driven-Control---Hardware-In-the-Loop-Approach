%% Write APRBS on .txt
fid = fopen('C:\Users\anton\Documents\MEGA\TemperatureControl\Batch\batch2.txt', 'w' );
fprintf(fid, '%g\n', round(batch2.U));
fclose(fid);
Ts = 0.05;
t = 0:Ts:((length(batch1.U)-1)*Ts);
plot(t,batch2.U)

%%
%% read from .txt - Batch1
N = 15000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch2Output.txt','r');
formatSpec = '%f %d';
sizeA = [2 Inf];
batch1Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch1Output = batch1Output(3:2*N+2);
Y1 = batch1Output(1:2:end);
U1 = batch1Output(2:2:end);
% Batch1 - Results
t = 0:Ts:((length(batch1.U)-2)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y1);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U1,t,batch1.U(1:N));
title('Duty')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% read from .txt - Batch2 - --- da rifare
N = 15000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch2Output.txt','r');
formatSpec = '%f %d';
sizeA = [2 Inf];
batch2Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch2Output = batch2Output(3:2*N+2);
Y2 = batch2Output(1:2:end);
U2 = batch2Output(2:2:end);
% Batch2 - Results
t = 0:Ts:((length(batch2.U)-2)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y2);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U2,t,batch2.U(1:N));
title('Duty')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% read from .txt - Batch3 
N = 15000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch3Output.txt','r');
formatSpec = '%f %d';
sizeA = [2 Inf];
batch3Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch3Output = batch3Output(3:2*N+2);
Y3 = batch3Output(1:2:end);
U3 = batch3Output(2:2:end);
% Batch3 - Results
t = 0:Ts:((length(batch3.U)-2)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y3);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U3,t,batch3.U(1:N));
title('Duty')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% read from .txt - Batch4 
N = 15000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch4Output.txt','r');
formatSpec = '%f %d';
sizeA = [2 Inf];
batch4Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch4Output = batch4Output(3:2*N+2);
Y4 = batch4Output(1:2:end);
U4 = batch4Output(2:2:end);
% Batch4 - Results
Ts = 0.2;
t = 0:Ts:((length(batch4.U)-1)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y4);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U4,t,batch4.U(1:N));
title('Duty')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% read from .txt - Batch5 
% Ts = 0.5;
% t = 0:0.01:125;
% U = (50*sin(0.05*t))+50;
% plot(t,U)
% batch5.U = U;
% batch5.Ts = 0.01;
N = 12500;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch5Output.txt','r');
formatSpec = '%f %f';
sizeA = [2 Inf];
batch5Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch5Output = batch5Output(:,3:N);
Y5 = batch5Output(1,:);
U5 = batch5Output(2,:);
% Batch5 - Results
Ts = 0.01;
t = 0:Ts:((length(Y5)-1)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y5);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U5,t,batch5.U(1:length(U5)));
title('Duty')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% read from .txt - Batch6 
% Ts = 0.5;
% t = 0:0.01:125;
% U = (50*sin(0.05*t))+50;
% plot(t,U)
% batch5.U = U;
% batch5.Ts = 0.01;
N = 40000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch6Output.txt','r');
formatSpec = '%f %f';
sizeA = [2 Inf];
batch6Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch6Output = batch6Output(:,3:N);
Y6 = batch6Output(1,:);
U6 = batch6Output(2,:);
% Batch6 - Results
Ts = 0.01;
t = 0:Ts:((length(Y6)-1)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y6);
title('Distance')
subplot(212)
grid on,hold on
%plot(t,U6,t,batch6.U(1:length(U6)));
plot(t,U6);
title('Duty')
%% read from .txt - Batch3_2 (con cifre decimali)
N = 15000;
fileID = fopen('C:\Users\anton\Documents\MEGA\Poliba\CodeGeneration\CodeGeneration\batch3_2.txt','r');
formatSpec = '%f %f';
sizeA = [2 Inf];
batch3_2Output = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
batch3_2Output = batch3_2Output(3:2*N+2);
Y3_2 = batch3_2Output(1:2:end);
U3_2 = batch3_2Output(2:2:end);
% Batch3 - Results
t = 0:Ts:((length(batch3.U)-2)*Ts);
figure(1)
subplot(211)
grid on,hold on
plot(t,Y3_2);
title('Distance')
subplot(212)
grid on,hold on
plot(t,U3_2,t,batch3.U(1:N));
title('Duty')