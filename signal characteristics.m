clear all; 
close all; 
clc;
tColor='b';
fColor=[1 0.4 0];
A0=2; % Постоянная составляющая сигнала
A=3; % Амплитуда сигнала
fmin=91; fmax=728; f0=15; % Частота сигнала, Гц
fd=1500; % Частота дискретизации, Гц
tmin=-1; tmax=3; dt=tmax-tmin; % Интервал определения функции
N = dt*fd; % Количество отсчетов

% Моделирование импульса функции Гаусса
xd = linspace(tmin,tmax,N);
zd = A*gaussmf(xd,[0.085 0]);

figure;plot(xd, zd, 'Color', tColor,'LineWidth',2);
axis([tmin tmax -1 A]);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10); 
title({'\rm Сигнал в виде импульса функции Гаусса'});
xlabel('Время,\it nT_д\rm, с'); 
ylabel('Сигнал,\it x(nT_д )\rm, В'); 

% Параметры сигнала
Ni = 600;               % Количество импульсов
T = 12.2;              % Период следования
pulse_duration = 0.4;  % Длительность импульса
fs = 100;             % Частота дискретизации
A = 1;                 % Амплитуда импульсов

total_time = Ni*T;
t_total = 0:1/fs:total_time-1/fs;

d = (0:Ni-1)*T;  

% Гауссов импульс
t_pulse = -pulse_duration*2 : 1/fs : pulse_duration*2;  % Временная ось для шаблона
mu = 0;                                                 % Центр импульса
sigma = pulse_duration/(2*sqrt(2*log(2)));              % Ширина
gauss_pulse = A * exp(-(t_pulse - mu).^2 / (2*sigma^2));

zd = pulstran(t_total, d', gauss_pulse, fs);

t_total_min = t_total / 60; % секунды → минуты

figure;
plot(t_total_min, zd);
xlabel('Время (минуты)');
ylabel('Амплитуда');
title('Последовательность из 600 гауссовых импульсов (T = 12.2 с)');
grid on;

xlim([0, total_time/60]);

figure;
plot(t_total, zd, 'b', 'LineWidth', 1.5);
xlim([0, 5*T]); 
xlabel('Время, с');
ylabel('Амплитуда, В');
title('Приближенное изображение периодической последовательности импульсов функции Гаусса (N=600, T=12.2 с)');
grid on;

tmin0 = tmin+1;
tmax0 = tmax+1;
xd0 = linspace(tmin0,tmax0,N);
zd = A*chirp(xd0,fmin,tmax0,fmax,"linear"); 

figure;
plot(xd, zd, 'Color', tColor,'LineWidth',1);
axis([tmin tmax -A A]); 
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Сигнал с линейной частотной модуляцией'});
xlabel('Время,\it nT_д\rm, c');
ylabel('Сигнал,\it x(nT_д )\rm, В');

% энергия и средней мощность сигнала во временной области
Et = 1/fd * sum(zd.^2);
Pt = Et/dt;
% энергия и средней мощность сигнала в частотной области
X = fft(zd,N);
Ew = 1/(fd*N) * sum(abs(X).^2);
% Вывод результата
fprintf('Энергия сигнала во временной области: %f \n', Et);
fprintf('Энергия сигнала в частотной области: %f \n', Ew);
fprintf('Средняя мощность сигнала во временной области: %f \n', Pt);

% амплитудный спектр сигнала
f=0:fd/N:fd-fd/N; 
af = abs(fft(zd)/N);
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)],fftshift(af),...
'Color', fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10); 
title({'\rm Амплитудный спектр сигнала'}); 
xlabel('Частота,\it f\rm, Гц'); 
ylabel('Амплитуда,\it A(f)\rm, В');

% энергетический спектр сигнала
ef = 1/(N*fd) * (abs(fft(zd)).^2); 
figure; plot([-fliplr(f(1:end/2)) f(1:end/2)],fftshift(ef),...
'Color',fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Энергетический спектр сигнала'});
xlabel('Частота,\it f\rm, Гц');
ylabel('Энергия,\it E(f)\rm, Дж');

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

% функция спектральной мощности сигнала
[pf,ff]=periodogram(zd,rectwin(length(zd)),...
length(zd),fd,'psd');
figure; plot(ff,pf, 'Color', fColor,'LineWidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', 10);
title({'\rm Функция спектральной плотности мощности'});
xlabel('Частота,\it f\rm, Гц');
ylabel('Плотность мощности,\it S(f)\rm, Вт/Гц');