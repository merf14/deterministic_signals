% спектр мощности сигнала
pf = ef/dt;
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)],fftshift(pf),...
'Color', fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Cпектр мощности сигнала'});
xlabel('Частота,\it f\rm, Гц');
ylabel('Мощность,\it P(f)\rm, Вт');

[pf,ff]=periodogram(zd,rectwin(length(zd)),...
length(zd),fd,'power');
figure;plot(ff,pf, 'Color',fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize',10);
title({'\rmСпектр мощности сигнала',...
'(для положительных значений частоты)'});
xlabel('Частота,\itf\rm, Гц');
ylabel('Мощность,\itP(f)\rm,Вт');