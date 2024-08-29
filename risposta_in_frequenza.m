clc;close all;clear all;

st=1e-4;


Jm=2e-2;
Jc=10e-2;
k=1000;
h=0.3;
hm=.5;
model=ElasticSystemModel(Jm,Jc,k,h,hm);
sys=model(1,1);



T=0.4;
omega0=2*pi/T;

tt=[0 0.1 0.3 0.6 0.8 0.9 1.001]*T';
uu=[0 2   3   -3  0   -1  0]';

tt=[0 0.1 0.3 0.6 0.8 0.9 1.001]*T';
uu=[0 7   2   -3  -2   -1  0]';

t=(0:st:(T+st))';
u=interp1(tt,uu,t);%,'previous');
u=u-mean(u);


n=(1:500)';
omega=omega0*n;
cu=fourierCoefficients(t,u,omega0,omega);


periods=3;
time=(0:st:periods*(T+st))';
input=[u(1);repmat(u(2:end),periods,1)];

fr_sys=freqresp(sys,omega);
fr_sys=fr_sys(:);
cy=fr_sys.*cu;

output=lsim(model(:,1),input,time);
v0=mean(output(:,3:4));
output=zeros(length(time),1);
for idx=1:length(n)
    h=computeHarmonic(time,cy(idx),omega0,n(idx));
    output=output+h;
end
figure(1)

subplot(2,1,1)
plot(time,output)
xlabel('tempo')
ylabel('posizione')
grid on

hold on
for idx=1:periods
    plot([1 1]*idx*T,ylim,'--k')
end

subplot(2,1,2)
plot(time,input)
xlabel('tempo')
ylabel('coppia')
grid on


hold on
for idx=1:periods
    plot([1 1]*idx*T,ylim,'--k')
end

drawnow

%% Fourier ingresso
plotTimeSpectrum(time,input,cu,omega0,n,'coppia')

%return
%% Fourier uscita
plotTimeSpectrum(time,output,cy,omega0,n,'posizione')
%return

%% Risposta in frequenza
idxs=1:3;
plotFrequencyResponse(omega,cu,cy,fr_sys,idxs,"linear")

%% Risposta in frequenza
idxs=omega<500;
plotFrequencyResponse(omega,cu,cy,fr_sys,idxs,"linear")
%%
plotFrequencyResponse(omega,cu,cy,fr_sys,idxs,"log")
%%
plotFrequencyResponse(omega,cu,cy,fr_sys,idxs,"bode")
