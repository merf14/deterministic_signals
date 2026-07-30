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

total_time = Ni*T;
t_total = 0:1/fs:total_time-1/fs;

d = (0:Ni-1)*T;  

zd = pulstran(t_total, d', gauss_pulse, fs);

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
