function plotFrequencyResponse(omega,cu,cy,fr_sys,idxs,mode)

figure
fr=cy./cu;

for idx=1:6
    hpl(idx)=subplot(2,3,idx);
end
linkaxes(hpl,'x')

subplot(2,3,1)
guadagno=2*abs(cu(idxs));
if (mode=="bode")
    guadagno=20*log10(guadagno);
end
stem(omega(idxs),guadagno,'k','LineWidth',2);
hold on

xlabel('pulsazione (rad/s)')
ylabel('ampiezza armonica coppia')
grid on

subplot(2,3,2)
guadagno=2*abs(cy(idxs));
if (mode=="bode")
    guadagno=20*log10(guadagno);
end
stem(omega(idxs),guadagno,'k','LineWidth',2);
hold on

xlabel('pulsazione (rad/s)')
ylabel('ampiezza armonica posizione')
grid on

subplot(2,3,3)
guadagno=abs(fr(idxs));
guadagno_sys=abs(fr(idxs));
if (mode=="bode")
    guadagno=20*log10(guadagno);
    guadagno_sys=20*log10(guadagno_sys);
end
plot(omega(idxs),guadagno,'ok','LineWidth',2);
hold on
plot(omega(idxs),guadagno_sys,'--k')
xlabel('pulsazione (rad/s)')
ylabel('ampiezza funzione di risposta armonica')
grid on
hold off

subplot(2,3,4)
angolo=rad2deg(angle(cu(idxs)));
angolo(angolo>0)=angolo(angolo>0)-360;
spettro_pha=stem(omega(idxs),angolo,'k','LineWidth',2);
hold on
xlabel('pulsazione (rad/s)')
ylabel('fase armonica coppia')
grid on
hold off
subplot(2,3,5)
angolo=rad2deg(angle(cy(idxs)));
angolo(angolo>0)=angolo(angolo>0)-360;
spettro_pha=stem(omega(idxs),angolo,'k','LineWidth',2);
hold on
xlabel('pulsazione (rad/s)')
ylabel('fase armonica posizione')
grid on

subplot(2,3,6)


angolo=rad2deg(unwrap(angle(fr(idxs))));
%angolo(angolo>0)=angolo(angolo>0)-360;
plot(omega(idxs),angolo,'ok','LineWidth',2);
hold on
plot(omega(idxs),rad2deg(unwrap(angle(fr_sys(idxs)))),'--k')
hold off

xlabel('pulsazione (rad/s)')
ylabel('fase funzione di risposta armonica')
grid on

if or(mode=="bode",mode=="log")

    for idx=1:6
        hpl(idx).XScale='log';
    end
end

drawnow

