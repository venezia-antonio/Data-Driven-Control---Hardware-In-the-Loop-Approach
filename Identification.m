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
impulse(train);
% no delay -> nk = 1
%% ARX Model
% kmax = 50
% maxOrd(kmax,data,train)
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
na = 6;
nb = na;
nk = 1;
OE = oe(train,[na nb nk]);
figure,compare(valid,OE);
advice(OE,valid)
figure,resid(OE,valid);
% Fit 50%
%% ARMAX
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
% load modelComparison
figure,compare(valid,ARX,ARMAX,BJ,OE,NLARX,HW)
% As can be seen, a Box Jenkins Model could be the best one
%% Neural Network
% clear all
% load  NN_Temperature_Control
% net = newff(U,Y,[2 2 2 2]);
% Ynet = sim(net,U);
% figure(),plot(U,Ynet,'ok')
% 
% % train
% net.trainParam.epochs = 200;
% net = train(net,U,Y);
% Ynet = sim(net,U);
% figure(),plot(U,Y,'o-g')

function [] = maxFit(kmax,train,valid)
for k = 1:kmax
    m = nlhw(train,[k k 1],saturation('LinearInterval',[0,100]),[]);
    [~,fit,~] = compare(valid,m);
    Fit(k) = fit;
  end
figure,plot(1:kmax,Fit)
end

function [] = maxOrd(kmax,data,train)
N1 = length(train.U);
N = length(data.U);
for k = 1:kmax
    m = arx(train,[k k 1]);
    y = data.Y;
    ysim = sim(m,data.U);
    es = y-ysim;
    errp=pe(m,data);
    ep=errp.OutputData;
    JPT(k) = cov(ep(1:N1)); % indice di aderenza ai dati di training errore di pred
   JPV(k) =cov(ep(N1+1:N));% aderenza dati validazione

   JST(k) = cov(es(1:N1)); % aderenza dati training errore di simulazione
   JSV(k) = cov(es(N1+1:N)); % errore di simulazione dati validazione

   Jfpe(k) = fpe(m);
   %  FPE = Akaikes Final Predition Error = JPT*(N+n)/(N-n)
   Jaic(k) = aic(m);
   %  AIC = Akaikes Information Criterion log(JPT) + 2n/N  
   n=2*k;
   Jmdl(k) = log(N1)*n/N1 + log(JPT(k));
end
x=1:kmax;
figure(), subplot(211),plot(x,JPT,'r',x,JPV,'b'),xlabel('model order'),ylabel('J_{PRED}')
           legend('training','validation')
           subplot(212),plot(x,JST,'r',x,JSV,'b'),xlabel('model order'),ylabel('J_{SIM}')
           legend('training','validation')

figure(), subplot(311),plot(x,Jfpe),xlabel('model order'),ylabel('FPE')
           subplot(312),plot(x,Jaic),xlabel('model order'),ylabel('AIC')
           subplot(313),plot(x,Jmdl),xlabel('model order'),ylabel('MDL')
end










