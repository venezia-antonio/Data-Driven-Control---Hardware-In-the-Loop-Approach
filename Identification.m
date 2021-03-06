clear all
clc
close all
load NN_Temperature_Control
%% Experimental Data
data = iddata(Y',U',Ts);
figure,plot(data);
advice(data)
%% Training and Validation Data
n = length(Y)/2;
train = detrend(data(1:n),0);
valid = detrend(data(n+1:end),0);

% Detrending the data improve the fit massively
%% Delay evaluation
% impulse(train,'sd',3,'fill');
% no delay -> nk = 1
%% ARX Model
kmax = 20;
maxOrd(kmax,data,train,valid,'arx')
% kmax = 20;
% maxFit(kmax,train,valid)
na = 6;
nb = na;
nk = 1;
ARX = arx(train,[na nb nk]);
figure,compare(valid,ARX);
advice(ARX,valid)
figure,resid(ARX,valid);

Uf = filter(1,ARX.A,U); % input filtered
Yf = filter(1,ARX.A,Y); % output filtered
dataf = iddata(Yf',Uf',Ts);
n = length(Yf)/2;
trainf = detrend(dataf(1:n));
validf = detrend(dataf(n+1:end));
ARXf = arx(trainf,[na nb nk]);
compare(validf,ARXf)
% Fit 70%
%% Box Jenkins
kmax = 20;
maxOrd(kmax,data,train,valid,'bj')
nb = 6; 
na = 8;
nc = 6;
nd = 6;
nk = 1;
BJ = bj(train,[nb nc nd na nk]);
figure,compare(valid,BJ),title('Box Jenkins - [na,nb,nc,nd,nk] = [8,6,6,6,1]')
advice(BJ,valid)
figure,resid(BJ,valid);
% Prefiltering on Box Jenkins
% Let choose for filtering L(z) = W(z) = C(z)/D(z)(z) and filter only the input U
Uf = filter(BJ.C,BJ.D,U); % input filtered
Yf = filter(BJ.C,BJ.D,Y); % output filtered
dataf = iddata(Yf',Uf');
n = length(Yf)/2;
trainf = detrend(dataf(1:n));
validf = detrend(dataf(n+1:end));
nb = 6; 
na = 8;
nc = 6;
nd = 6;
nk = 1;
BJf = bj(trainf,[nb nc nd na nk]);
figure,compare(validf,BJf)
figure, step(BJ,BJf),legend('stima senza pref.','stima con pref.')
% Fit of 85%
%% OE
kmax = 20;
maxOrd(kmax,data,train,valid,'oe')
na = 6;
nb = na;
nk = 1;
OE = oe(train,[na nb nk]);
figure,compare(valid,OE);
advice(OE,valid)
figure,resid(OE,valid);
% Fit 50%
%% ARMAX
kmax = 20;
maxOrd(kmax,data,train,valid,'armax')
na = 8;
nb = na;
nc = 5;
nk = 1;
ARMAX = armax(train,[na nb nc nk]);
figure,compare(valid,ARMAX);
advice(ARMAX,valid)
figure,resid(ARMAX,valid);
% Fit 66%
%% NLARX
kmax = 20;
maxOrd(kmax,data,train,valid,'nlarx')
NLARX = nlarx(train,[5 5 1],'sigmoidnet');
figure,resid(valid,NLARX)
% NLARX = nlarx(train,[5 5 1],'linear');
compare(valid,NLARX)
% Whitness analysis not passed
%% Hammerstein-Weiner Model
HW = nlhw(train,[9 9 1],saturation('LinearInterval',[0,100]),[]);
figure,compare(valid,HW)
figure,resid(valid,HW)
% Fit 71%
% Whitness analysis not passed
%% Compare
 load modelComparison
figure,compare(valid,ARX,ARMAX,BJ,OE,NLARX,HW)
% As can be seen, a Box Jenkins Model could be the best one
%% Neural Network
% clear all
% load  NN_Temperature_Control
% net = newff(U,Y,[2 2 2 2 2 2]);
% Ynet = sim(net,U);
% figure(),plot(U,Ynet,'ok',U,Y,'or')

% train
% net.trainParam.epochs = 200;
% net = train(net,U,Y);
% Ynet = sim(net,U);
% figure(),plot(U,Ynet,'ok',U,Y,'or')

function [] = maxFit(kmax,train,valid)
for k = 1:kmax
    m = nlhw(train,[k k 1],saturation('LinearInterval',[0,100]),[]);
    [~,fit,~] = compare(valid,m);
    Fit(k) = fit;
  end
figure,plot(1:kmax,Fit)
end

function [] = maxOrd(kmax,data,train,valid,model)
N1 = length(train.U);
N = length(data.U);
for k = 1:kmax
    switch(model)
        case 'arx'
            m = arx(train,[k k 1]);
        case 'bj'
            m = bj(train,[k k k k 1]);
        case 'armax'
            m  = armax(train,[k k k 1]);
        case 'oe'
            m = oe(train,[k k 1]);
        case 'nlarx'
           m = nlarx(train,[k k 1],'sigmoidnet');
    end
    ept = pe(m,train);
    epv = pe(m,valid);
    Jt(k) = cov(ept.Outputdata);
    Jv(k) = cov(epv.Outputdata);
   Jfpe(k) = fpe(m);
   %  FPE = Akaikes Final Predition Error = JPT*(N+n)/(N-n)
   Jaic(k) = aic(m);
   %  AIC = Akaikes Information Criterion log(JPT) + 2n/N  
   n=2*k;
   Jmdl(k) = log(N1)*n/N1 + log(Jt(k));
end
x=1:kmax;
figure('NumberTitle', 'off', 'Name',model), plot(x,Jt,'b',x,Jv,'r'),xlabel('model order'),ylabel('J_{PRED}')
           legend('training','validation')
           

% figure(), subplot(311),plot(x,Jfpe),xlabel('model order'),ylabel('FPE')
%            subplot(312),plot(x,Jaic),xlabel('model order'),ylabel('AIC')
%            subplot(313),plot(x,Jmdl),xlabel('model order'),ylabel('MDL')
end










