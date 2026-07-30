% энергетический спектр сигнала
ef = 1/(N*fd) * (abs(fft(zd)).^2); 
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)],fftshift(ef),...
'Color',fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Энергетический спектр сигнала'});
xlabel('Частота,\it f\rm, Гц');
ylabel('Энергия,\it E(f)\rm, Дж');
