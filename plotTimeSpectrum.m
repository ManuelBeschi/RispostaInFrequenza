function plotTimeSpectrum(time,signal,c,omega0,n,name,paused,video)


mean_signal=mean(signal);
if nargin<7
    paused=true;
end
if nargin<8
    video=false;
end
if video
    writerObj = VideoWriter(sprintf('%s.avi',name));
    writerObj.FrameRate=10;
    open(writerObj);
end

armonica=[];
fourier_series=[];
spettro_amp=[];
spettro_pha=[];
omega=omega0*n;

fig=figure('Position',[1 1 1600 1200]);
drawnow
for idx=1:6
    hpl(idx)=subplot(3,2,idx);
end
linkaxes(hpl([1 2]),'x')
linkaxes(hpl([4 6]),'x')
delete(hpl([2 5]))

subplot(3,2,1);
plot(time,signal);

xlabel('tempo')
ylabel(name)
grid on

hold on
if paused;pause;end
if video
    F = getframe(gcf) ;           %// Capture the frame
    for idx=1:20
        writeVideo(writerObj,F)  %// add the frame to the movie
    end
end

sf=zeros(length(time),1);
for idx=1:length(n)
    h=computeHarmonic(time,c(idx),omega0,n(idx));
    sf=sf+h;

    subplot(3,2,3)
    if not(isempty(armonica))
        armonica.Color=[0.4 0.4 0.4];
        armonica.LineWidth=1;
    end
    armonica=plot(time,h,'k','LineWidth',2);

    hold on
    xlabel('tempo')
    ylabel('armonica')
    grid on

    subplot(3,2,1)
    if (isempty(fourier_series))
        fourier_series=plot(time,sf,'k');
    else
        fourier_series.YData=sf;
    end

    if (idx==1)
        if paused;pause;end
    end

    if video && idx<10
        F = getframe(gcf) ;           %// Capture the frame
        for iframe=1:20
            writeVideo(writerObj,F)  %// add the frame to the movie
        end
    end

    subplot(3,2,4)
    if not(isempty(spettro_amp))
        spettro_amp.Color=[0.4 0.4 0.4];
        spettro_amp.LineWidth=1;
    end
    spettro_amp=stem(omega(idx),2*abs(c(idx)),'k','k','LineWidth',2);
    hold on

    xlabel('pulsazione (rad/s)')
    ylabel(['ampiezza armonica ',name])
    grid on

    linkaxes(hpl([3 4]),'y')

    if (idx==1)
        if paused;pause;end
    end

    if video && idx<10
        F = getframe(gcf) ;           %// Capture the frame
        for iframe=1:20
            writeVideo(writerObj,F)  %// add the frame to the movie
        end
    end

    subplot(3,2,6)
    if not(isempty(spettro_pha))
        spettro_pha.Color=[0.4 0.4 0.4];
        spettro_pha.LineWidth=1;
    end
    angolo=rad2deg(angle(c(idx)));
    if angolo>0
        angolo=angolo-360;
    end
    spettro_pha=stem(omega(idx),angolo,'k','k','LineWidth',2);
    hold on
    subplot(3,2,6);
    xlabel('pulsazione (rad/s)')
    ylabel(['fase armonica ',name])
    grid on

    if (abs(c(idx))<1e-3 && idx>10)
        continue;
    elseif (idx<10)
        if paused;pause;end
    elseif (idx<100)
        if paused;pause(0.1);end
    else
        %drawnow
    end
    drawnow
    if video
        F = getframe(gcf) ;           %// Capture the frame
        writeVideo(writerObj,F)  %// add the frame to the movie
    end
end
drawnow
if video

    F = getframe(gcf) ;           %// Capture the frame
    for iframe=1:40
        writeVideo(writerObj,F)  %// add the frame to the movie
    end
    close(writerObj);
end
