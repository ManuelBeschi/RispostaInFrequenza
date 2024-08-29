clear all;close all;clc;


st=1e-4;
%T=2;
%T=5;
%T=10;
T=20;
%T=50;
Tsim=20;

omega0=2*pi/T;


t=(0:st:(T+st ))';



u=square(t*omega0);
u=0.5*(u+1);

periods=3;
time=(0:st:Tsim)';
input=square(time*omega0);
input=0.5*(input+1);


n=(0:round(50/omega0))';
omega=omega0*n;
cu=fourierCoefficients(t,u,omega0,omega);
cu(abs(cu)<1e-5)=0;

n=n(abs(cu)>1e-5);
cu=cu(abs(cu)>1e-5);


plotTimeSpectrum(time,input,cu,omega0,n,sprintf('onda quadra periodo %d s',T),false,true)


