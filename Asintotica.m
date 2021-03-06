clear all
clc
close all
load NN_Temperature_Control
%% Experimental Data
data = (iddata(Y',U',Ts));
num = 1000;
dati1  =data(1:num);
dati2  =data(1:2*num);
dati3  =data(1:3*num);
dati4  =data(1:4*num);
dati5  =data(1:5*num);
dati6  =data(1:6*num);
dati7  =data(1:7*num);
datiInf = data(1:10*num);
valid = data(10*num:end);

%% ARX asintotico
na = 6;
arx1 = arx(dati1,[na na 1]);fit1 = arx1.Report.Fit.FitPercent;fpe1 = arx1.Report.Fit.FPE;mse1 = arx1.Report.Fit.MSE;
arx2 = arx(dati2,[na na 1]);fit2 = arx2.Report.Fit.FitPercent;fpe2 = arx2.Report.Fit.FPE;mse2 = arx2.Report.Fit.MSE;
arx3 = arx(dati3,[na na 1]);fit3 = arx3.Report.Fit.FitPercent;fpe3 = arx3.Report.Fit.FPE;mse3 = arx3.Report.Fit.MSE;
arx4 = arx(dati4,[na na 1]);fit4 = arx4.Report.Fit.FitPercent;fpe4 = arx4.Report.Fit.FPE;mse4 = arx4.Report.Fit.MSE;
arx5 = arx(dati5,[na na 1]);fit5 = arx5.Report.Fit.FitPercent;fpe5 = arx5.Report.Fit.FPE;mse5 = arx5.Report.Fit.MSE;
arx6 = arx(dati6,[na na 1]);fit6 = arx6.Report.Fit.FitPercent;fpe6 = arx6.Report.Fit.FPE;mse6 = arx6.Report.Fit.MSE;
arx7 = arx(dati7,[na na 1]);fit7 = arx7.Report.Fit.FitPercent;fpe7 = arx7.Report.Fit.FPE;mse7 = arx7.Report.Fit.MSE;
arxInf = arx(datiInf,[na na 1]);fitInf = arxInf.Report.Fit.FitPercent;fpeInf = arxInf.Report.Fit.FPE;mseInf = arxInf.Report.Fit.MSE;
FIT = [fit1 fit2 fit3 fit4 fit5 fit6 fit7 fitInf];
FPE = [fpe1 fpe2 fpe3 fpe4 fpe5 fpe6 fpe7 fpeInf];
MSE = [mse1 mse2 mse3 mse4 mse5 mse6 mse7 mseInf];
numData = [1000 2000 3000 4000 5000 6000 7000 10000];
figure(1),hold on,grid minor
plot(numData,FIT),legend('FIT')
figure(2),hold on,grid minor
plot(numData,FPE,numData,MSE)
legend('FPE','MSE')
compare(valid,arx1,arx2,arx3,arx4,arx5,arx6,arx7,arxInf)
%% BJ asintotico
nb = 6; 
na = 8;
nc = 6;
nd = 6;
nk = 1;
bj1 = bj(dati1,[nb nc nd na nk]);fit1 = bj1.Report.Fit.FitPercent;fpe1 = bj1.Report.Fit.FPE;mse1 = bj1.Report.Fit.MSE;
bj2 = bj(dati2,[nb nc nd na nk]);fit2 = bj2.Report.Fit.FitPercent;fpe2 = bj2.Report.Fit.FPE;mse2 = bj2.Report.Fit.MSE;
bj3 = bj(dati3,[nb nc nd na nk]);fit3 = bj3.Report.Fit.FitPercent;fpe3 = bj3.Report.Fit.FPE;mse3 = bj3.Report.Fit.MSE;
bj4 = bj(dati4,[nb nc nd na nk]);fit4 = bj4.Report.Fit.FitPercent;fpe4 = bj4.Report.Fit.FPE;mse4 = bj4.Report.Fit.MSE;
bj5 = bj(dati5,[nb nc nd na nk]);fit5 = bj5.Report.Fit.FitPercent;fpe5 = bj5.Report.Fit.FPE;mse5 = bj5.Report.Fit.MSE;
bj6 = bj(dati6,[nb nc nd na nk]);fit6 = bj6.Report.Fit.FitPercent;fpe6 = bj6.Report.Fit.FPE;mse6 = bj6.Report.Fit.MSE;
bj7 = bj(dati7,[nb nc nd na nk]);fit7 = bj7.Report.Fit.FitPercent;fpe7 = bj7.Report.Fit.FPE;mse7 = bj7.Report.Fit.MSE;
bjInf = bj(datiInf,[nb nc nd na nk]);fitInf = bjInf.Report.Fit.FitPercent;fpeInf = bjInf.Report.Fit.FPE;mseInf = bjInf.Report.Fit.MSE;
FIT = [fit1 fit2 fit3 fit4 fit5 fit6 fit7 fitInf];
FPE = [fpe1 fpe2 fpe3 fpe4 fpe5 fpe6 fpe7 fpeInf];
MSE = [mse1 mse2 mse3 mse4 mse5 mse6 mse7 mseInf];
numData = [1000 2000 3000 4000 5000 6000 7000 10000];
figure(1),hold on,grid minor
plot(numData,FIT),legend('FIT')
figure(2),hold on,grid minor
plot(numData,FPE,numData,MSE)
legend('FPE','MSE')
compare(valid,bj1,bj2,bj3,bj4,bj5,bj6,bj7,bjInf)