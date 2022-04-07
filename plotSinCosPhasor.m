clear all;close all;clc;


w=1;

dt=1e-3;

T=2*pi/w;


t=(-T:dt:3*T)';


u1=cos(w*t);


figure

for idx=1:4
hpl(idx)=subplot(2,2,idx);
end

subplot(2,2,1)
plot(t,u1,'k')
hold on
grid on
xlabel('tempo')
ylabel('sinusoidi')
ylim([-3 3])
xlim(t([1 end]))

subplot(2,2,2) 
stem(w,1,'k')
hold on
grid on
xlabel('pulsazione')
ylabel('ampiezza')
ylim([-3 3])


subplot(2,2,4)
stem(w,0,'k')
hold on
grid on
xlabel('pulsazione')
ylabel('fase')
ylim([-360 360])


subplot(2,2,3)
hold on
grid on
xlabel('Re')
ylabel('Im')
xlim([-2 2])
ylim([-2 2])
hq=quiver(0,0,1,0,'k');
set(hq,'MaxHeadSize',1e2,'AutoScaleFactor',1);
axis equal
axis manual


pause
pha=deg2rad(0);
amp=1;

u2=amp*cos(w*t+pha);

subplot(2,2,1)
h1=plot(t,u2,'r');
h5=plot([0,pha/w],[2.5 2.5],'--b');
h6=plot([0,0],[1 2.5],'--b');
h7=plot([pha/w,pha/w],[amp 2.5],'--b');
    
subplot(2,2,2)
h2=stem(w,amp,'r');
subplot(2,2,4)
h3=stem(w,rad2deg(pha),'r');
subplot(2,2,3)
h4=quiver(0,0,amp*cos(pha),amp*sin(pha),'r');
set(h4,'MaxHeadSize',1e2,'AutoScaleFactor',1);

for angolo=0:5:360
    pha=deg2rad(angolo);
    amp=1;

    u2=amp*cos(w*t+pha);

    h5.XData=[0 -pha/w];
    h7.XData=[-pha/w -pha/w];
    h7.YData=[amp 2.5];
    
    h1.YData=u2;
    h2.YData=amp;
    h3.YData=angolo;
    h4.UData=amp*cos(pha);
    h4.VData=amp*sin(pha);
    pause(0.1)
    if angolo==45 
        pause
    end
end


for angolo=360:-5:-75
    pha=deg2rad(angolo);
    amp=1;

    u2=amp*cos(w*t+pha);
    
    h1.YData=u2;
    h2.YData=amp;
    h3.YData=angolo;
    h4.UData=amp*cos(pha);
    h4.VData=amp*sin(pha);
    h5.XData=[0 -pha/w];
    h7.XData=[-pha/w -pha/w];
    h7.YData=[amp 2.5];
    pause(0.1)
end

%%
for ampiezza=1:0.02:2
    pha=deg2rad(angolo);
    amp=ampiezza;

    u2=amp*cos(w*t+pha);

    h1.YData=u2;
    h2.YData=amp;
    h3.YData=angolo;
    h4.UData=amp*cos(pha);
    h4.VData=amp*sin(pha);
    h7.XData=[-pha/w -pha/w];
    h7.YData=[amp 2.5];
    
    pause(0.1)
end


for ampiezza=2:-0.02:0.1
    pha=deg2rad(angolo);
    amp=ampiezza;

    u2=amp*cos(w*t+pha);

    h1.YData=u2;
    h2.YData=amp;
    h3.YData=angolo;
    h4.UData=amp*cos(pha);
    h4.VData=amp*sin(pha);
    h7.XData=[-pha/w -pha/w];
    h7.YData=[amp 2.5];
    pause(0.1)
end