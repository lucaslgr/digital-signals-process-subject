% Resposta em Frequência do Filtro de Notch
%Definição das variáveis
w = 0 : (pi/1000) : pi; %Vetor frequência discreta no intervalo 0 a 2pi (rad/amostra)
Nw = length(w); %Número de frequências avaliadas no intervalo de 0 a 2pi
fs = 3840; %Frequência de amostragem
Ts = 1/fs; %Período de amostragem
f = ((fs / 2) / pi) * w; %Vetor de frequência em Hertz

%Definição dos coeficientes do filtro
wnotch = 2 * pi * 60 * Ts; %Frequência de amostragem em rad/amostra
Alfa = 0.9; %Parâmetro de controle da largura da faixa de rejeição
Beta = cos(wnotch); %Parâmetro beta do filtro que controla a posição da frequencia eliminada

Num = ( (1+Alfa)/2) * [1 -2*Beta 1]; %Coeficiente do polinômio do numerador da fç de transferência
Den = [1 -Beta*(1+Alfa) Alfa]; %Coeficientes do polinômio do denominador da fç de transferencia

%Cálculo da resposta em frequência, após subst. na G(z) acima, z =
%e^(jw)para analisar a resposta em freq.
Hejw = (Num(1) + Num(2)*exp(-1i*w) + Num(3)*exp(-1i*2*w)) ./(Den(1) + Den(2)*exp(-1i*w) + Den(3)*exp(-1i*2*w));
Hmodulo = abs(Hejw); %Cálculo da resposta em módulo
%Hfase = (180/pi)*atan(imag(Hejw), real(Hejw)); %Cálculo da resposta em fase
Hfase = (180/pi)*atan(real(Hejw) + imag(Hejw)); %Cálculo da resposta em fase
 
% EXIBIÇÃO DOS RESULTADOS (será utilizada a frequência em Hz nos resultados)
figure();
subplot(211)
plot(f,Hmodulo,'k','linewidth',3) % Resposta em módulo no gráfico superior
hold on
xlabel('Frequência (Hz)')
ylabel('Resp. em Ganho')
title('Resposta em frequência do filtro Notch')
subplot(212)
hold on
plot(f,Hfase,'k','linewidth',3) % Resposta em fase no gráfico inferior
hold on
xlabel('Frequência (Hz)')
ylabel('Resp. em Fase')
hold off