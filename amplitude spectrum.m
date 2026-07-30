% амплитудный спектр сигнала
f=0:fd/N:fd-fd/N; 
af = abs(fft(zd)/N);
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)],fftshift(af),...
'Color', fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10); 
title({'\rm Амплитудный спектр сигнала'}); 
xlabel('Частота,\it f\rm, Гц'); 
ylabel('Амплитуда,\it A(f)\rm, В');