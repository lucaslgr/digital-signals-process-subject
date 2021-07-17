clear 
close all
clc

% Defini��o dos par�metros de simula��o

fs = 3840; %Freq. de amostragem em Hertz (s-sampling)
Ts = 1/fs; %Per�odo ou intervalo de amostragem
t = 0:Ts:20; %Vetor de tempo para a simula��o
N = length(t); %N�mero de pontos simulados entre 0 e 20seg.
y = zeros(1, N); %Inicializa��o do sinal de sa�da do filtro

% Defini��o do sinal analisado
i1 = 1.0*sin(2*pi*60*t); %Componente de freq. fundamental 60Hz
i3 = 0.3*sin(2*pi*180*t+(pi/180)*22.5); %3� harm�nico
i5 = 0.1*sin(2*pi*300*t+(pi/180)*(-18)); %5� harm�nico
i7 = 0.05*sin(2*pi*420*t); %7� harm�nico
i = i1 + i3 + i5 + i7; %Sinal de corrente completo (como se fosse medido por um sensor de PAC)
ih = i3 + i5 + i7; %Conte�do harm�nico do sinal de corrente

% Defini��o dos coeficientes do filtro
wnotch = 2*pi*60*Ts; %Frequ�ncia de amostragem em rad
Alfa = 0.9; %Par�metro de controle de largura da faixa de rejei��o
Beta = cos(wnotch); %Par�metro beta do filtro que controla a posi��o da frequ�ncia eliminada
a1 = - Beta * (1 + Alfa);
a2 = Alfa;
b0 = (1 + Alfa)/2;
b1 = -Beta*(1 + Alfa);
b2 = (1 + Alfa) / 2;

% Processo de filtragem
for n = 1:N 
   if(n > 2)
       y(n) = -a1*y(n-1) - a2*y(n-2) + b0*i(n) + b1*i(n-1) + b2*i(n-2); %Calculo da sa�da
   elseif (n == 2)
       y(n) = -a1*y(n-1) - a2*0 + b0*i(n) + b1*i(n-1) + b2*0; %Calculo da sa�da
   else
       y(n) = -a1*0 - a2*0 + b0*i(n) + b1*0 + b2*0; %Calculo da sa�da
   end
end

%Plotando as figuras
figure(1)
subplot(211)
plot(t,i,'k','linewidth',2)
hold on
plot(t,y,'b','linewidth',2)
legend('Sinal de corrente','Corrente harm�nica estimada')
ylabel('Amplitude')
xlabel('Tempo (s)')
title('Estimativa da corrente harm�nica do sinal de corrente')
hold off
subplot(212)
plot(t,ih,'k','linewidth',2)
hold on
plot(t,y,'b','linewidth',2)
legend('Conte�do harm�nico real','Corrente harm�nica estimada')
ylabel('Amplitude')
xlabel('Tempo (s)')
title('Compara��o da corrente harm�nica real com a estimativa')
hold off