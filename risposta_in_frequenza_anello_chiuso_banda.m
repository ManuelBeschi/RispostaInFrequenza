clc;close all;clear all;


scale=1;
st=1e-4;


Jm=2e-2;
Jc=10e-2;
k=10000;
h=2.8;
hm=.5;
model=ElasticSystemModel(Jm,Jc,k,h,hm);
P=minreal(model(3,1));
s=tf('s');

wc=100;
C=(s+wc/10)/s/(s+wc*2);

K=1/abs(freqresp(C*P,wc));
C=K*C;
%%
figure(1)
margin(C*P)
hold on
F=P*C/(1+P*C);
bode(F)
legend('open loop C*P','closed loop C*P/(1+C*P)')
xlim([0.001 100]*wc)
grid on
hold off
%%


T=4;

tt=[0 0.1 0.3 0.6 0.8 0.9 1.001]*T';
rr=[0 3   3   -3  -3  -3  0]';


t=(0:st:(T+st))';
sp=interp1(tt,rr,t);%,'previous');
sp=sp-mean(sp);


omega0=2*pi/T*scale;

n=(1:500)';
omega=omega0*n;
cr=fourierCoefficients(t/scale,sp,omega0,omega);

omega1=omega(abs(cr)>max(abs(cr))*0.005);

frL=freqresp(F,omega1);
frL=frL(:);


%plotTimeSpectrum(time,reference,cr,omega0,n,'setpoint')

%%
figure(2)
hf=gcf;

plotoptions = bodeoptions;
plotoptions.MagUnits='db';
bode(P*C/(1+P*C),plotoptions);
legend('closed loop C*P/(1+C*P)')
xlim([0.001 100]*wc)
grid on
hf.Children(4)
hold(hf.Children(4),'on')
for im=1:length(omega1)
    plot(hf.Children(4),omega1(im),20*log10(abs(frL(im))),'ok','MarkerSize',max(0.0001,8+2*log10(abs(cr(im)))))
end

hold(hf.Children(3),'on')
for im=1:length(omega1)
    hl=plot(hf.Children(3),omega1(im),rad2deg(angle(frL(im))),'ok','MarkerSize',max(0.0001,8+2*log10(abs(cr(im)))));

    hl.Annotation.LegendInformation.IconDisplayStyle = 'off';

end

%%
figure(3)
hf=gcf;

plotoptions = bodeoptions;
plotoptions.MagUnits='abs';
bode(P*C/(1+P*C),plotoptions);
legend('closed loop C*P/(1+C*P)')
xlim([0.001 100]*wc)
grid on
hf.Children(4)
hold(hf.Children(4),'on')
for im=1:length(omega1)
    plot(hf.Children(4),omega1(im),abs(frL(im)),'ok','MarkerSize',max(0.0001,8+2*log10(abs(cr(im)))))
end

hold(hf.Children(3),'on')
for im=1:length(omega1)
    hl=plot(hf.Children(3),omega1(im),rad2deg(angle(frL(im))),'ok','MarkerSize',max(0.0001,8+2*log10(abs(cr(im)))));

    hl.Annotation.LegendInformation.IconDisplayStyle = 'off';

end
%%
periods=5;

time=(0:st:periods*(T+st))'/scale;
reference=[sp(1);repmat(sp(2:end),periods,1)];

F=C*P/(1+C*P);
y=lsim(F,reference,time);
cy=fourierCoefficients(time,y,omega0,omega);



figure(4)

plot(time,y,time,reference,'--k')
xlabel('tempo')
ylabel('velocità')
grid on

hold on

legend('y','r')
drawnow


%% Fourier ingresso
%plotTimeSpectrum(time,reference,cr,omega0,n,'sepoint',false)

