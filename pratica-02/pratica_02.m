clear 
close all
clc

% Definição dos parâmetros de simulação

fs = 3840; %Freq. de amostragem em Hertz (s-sampling)
Ts = 1/fs; %Período ou intervalo de amostragem
t = 0:Ts:20; %Vetor de tempo para a simulação
N = length(t); %Número de pontos simulados entre 0 e 20seg.
y = zeros(1, N); %Inicialização do sinal de saída do filtro

% Definição do sinal analisado
i1 = 1.0*sin(2*pi*60*t); %Componente de freq. fundamental 60Hz
i3 = 0.3*sin(2*pi*180*t+(pi/180)*22.5); %3º harmônico
i5 = 0.1*sin(2*pi*300*t+(pi/180)*(-18)); %5º harmônico
i7 = 0.05*sin(2*pi*420*t); %7º harmônico
i = i1 + i3 + i5 + i7; %Sinal de corrente completo (como se fosse medido por um sensor de PAC)
ih = i3 + i5 + i7; %Conteúdo harmônico do sinal de corrente

% Definição dos coeficientes do filtro
wnotch = 2*pi*60*Ts; %Frequência de amostragem em rad
Alfa = 0.9; %Parâmetro de controle de largura da faixa de rejeição
Beta = cos(wnotch); %Parâmetro beta do filtro que controla a posição da frequência eliminada
a1 = - Beta * (1 + Alfa);
a2 = Alfa;
b0 = (1 + Alfa)/2;
b1 = -Beta*(1 + Alfa);
b2 = (1 + Alfa) / 2;

% Processo de filtragem
for n = 1:N 
   if(n > 2)
       y(n) = -a1*y(n-1) - a2*y(n-2) + b0*i(n) + b1*i(n-1) + b2*i(n-2); %Calculo da saída
   elseif (n == 2)
       y(n) = -a1*y(n-1) - a2*0 + b0*i(n) + b1*i(n-1) + b2*0; %Calculo da saída
   else
       y(n) = -a1*0 - a2*0 + b0*i(n) + b1*0 + b2*0; %Calculo da saída
   end
end

%Plotando as figuras
figure(1)
subplot(211)
plot(t,i,'k','linewidth',2)
hold on
plot(t,y,'b','linewidth',2)
legend('Sinal de corrente','Corrente harmônica estimada')
ylabel('Amplitude')
xlabel('Tempo (s)')
title('Estimativa da corrente harmônica do sinal de corrente')
hold off
subplot(212)
plot(t,ih,'k','linewidth',2)
hold on
plot(t,y,'b','linewidth',2)
legend('Conteúdo harmônico real','Corrente harmônica estimada')
ylabel('Amplitude')
xlabel('Tempo (s)')
title('Comparação da corrente harmônica real com a estimativa')
hold off