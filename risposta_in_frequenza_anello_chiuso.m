clc;close all;clear all;

st=1e-4;


Jm=2e-2;
Jc=10e-2;
k=1000;
h=0.3;
hm=.5;
model=ElasticSystemModel(Jm,Jc,k,h,hm);
P=model(1,1);
s=tf('s');
C=200*((s^2+10*s+100)/(s*(0.001*s+1)));


T=0.4;
omega0=2*pi/T;

tt=[0 0.1 0.3 0.6 0.8 0.9 1.001]*T';
rr=[0 3   3   -3  -3  -3  0]';

t=(0:st:(T+st))';
u=interp1(tt,rr,t);%,'previous');
u=u-mean(u);


n=(1:500)';
omega=omega0*n;
cr=fourierCoefficients(t,u,omega0,omega);


periods=3;
time=(0:st:periods*(T+st))';
reference=[u(1);repmat(u(2:end),periods,1)];

fr_P=freqresp(P,omega);
fr_P=fr_P(:);

fr_C=freqresp(C,omega);
fr_C=fr_C(:);

fr_L=fr_C.*fr_P;
fr_F_y_r=fr_L./(1+fr_L);
fr_F_u_r=fr_C./(1+fr_L);

cy=fr_F_y_r.*cr;
cu=fr_F_u_r.*cr;

output=computeOutputFromHarmonics(time,cy,omega0,n);
u=computeOutputFromHarmonics(time,cu,omega0,n);


figure(1)

subplot(2,1,1)
plot(time,output,time,reference,'--k')
xlabel('tempo')
ylabel('posizione')
grid on

hold on
for idx=1:periods
    plot([1 1]*idx*T,ylim,'--k')
end

subplot(2,1,2)
plot(time,u)
xlabel('tempo')
ylabel('coppia')
grid on


hold on
for idx=1:periods
    plot([1 1]*idx*T,ylim,'--k')
end

drawnow

%% Fourier ingresso
plotTimeSpectrum(time,reference,cr,omega0,n,'sepoint',false)

%return
%% Fourier uscita
plotTimeSpectrum(time,output,cy,omega0,n,'posizione',false)
%return

%% Risposta in frequenza
idxs=1:3;
plotFrequencyResponse(omega,cr,cy,fr_F_y_r,idxs,"linear")

%% Risposta in frequenza
idxs=omega<500;
plotFrequencyResponse(omega,cr,cy,fr_F_y_r,idxs,"linear")
%%
plotFrequencyResponse(omega,cr,cy,fr_F_y_r,idxs,"log")
%%
plotFrequencyResponse(omega,cr,cy,fr_F_y_r,idxs,"bode")
