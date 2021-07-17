% Resposta em Frequ�ncia do Filtro de Notch
%Defini��o das vari�veis
w = 0 : (pi/1000) : pi; %Vetor frequ�ncia discreta no intervalo 0 a 2pi (rad/amostra)
Nw = length(w); %N�mero de frequ�ncias avaliadas no intervalo de 0 a 2pi
fs = 3840; %Frequ�ncia de amostragem
Ts = 1/fs; %Per�odo de amostragem
f = ((fs / 2) / pi) * w; %Vetor de frequ�ncia em Hertz

%Defini��o dos coeficientes do filtro
wnotch = 2 * pi * 60 * Ts; %Frequ�ncia de amostragem em rad/amostra
Alfa = 0.9; %Par�metro de controle da largura da faixa de rejei��o
Beta = cos(wnotch); %Par�metro beta do filtro que controla a posi��o da frequencia eliminada

Num = ( (1+Alfa)/2) * [1 -2*Beta 1]; %Coeficiente do polin�mio do numerador da f� de transfer�ncia
Den = [1 -Beta*(1+Alfa) Alfa]; %Coeficientes do polin�mio do denominador da f� de transferencia

%C�lculo da resposta em frequ�ncia, ap�s subst. na G(z) acima, z =
%e^(jw)para analisar a resposta em freq.
Hejw = (Num(1) + Num(2)*exp(-1i*w) + Num(3)*exp(-1i*2*w)) ./(Den(1) + Den(2)*exp(-1i*w) + Den(3)*exp(-1i*2*w));
Hmodulo = abs(Hejw); %C�lculo da resposta em m�dulo
%Hfase = (180/pi)*atan(imag(Hejw), real(Hejw)); %C�lculo da resposta em fase
Hfase = (180/pi)*atan(real(Hejw) + imag(Hejw)); %C�lculo da resposta em fase
 
% EXIBI��O DOS RESULTADOS (ser� utilizada a frequ�ncia em Hz nos resultados)
figure();
subplot(211)
plot(f,Hmodulo,'k','linewidth',3) % Resposta em m�dulo no gr�fico superior
hold on
xlabel('Frequ�ncia (Hz)')
ylabel('Resp. em Ganho')
title('Resposta em frequ�ncia do filtro Notch')
subplot(212)
hold on
plot(f,Hfase,'k','linewidth',3) % Resposta em fase no gr�fico inferior
hold on
xlabel('Frequ�ncia (Hz)')
ylabel('Resp. em Fase')
hold off