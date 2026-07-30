% функция спектральной мощности сигнала
[pf,ff]=periodogram(zd,rectwin(length(zd)),...
length(zd),fd,'psd');
figure; plot(ff,pf, 'Color', fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Функция спектральной плотности мощности'});
xlabel('Частота,\it f\rm, Гц');
ylabel('Плотность мощности,\it S(f)\rm, Вт/Гц');