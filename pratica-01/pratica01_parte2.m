clear 
close all
clc

% calcAndPlotConfirmedCasesApplyingMovingAverage(7);
% calcAndPlotDeathsCasesApplyingMovingAverage(7);
% calcAndPlotConfirmedCasesApplyingMovingAverage(14);
% calcAndPlotDeathsCasesApplyingMovingAverage(14);

%Para compara��o de desempenho com m�todo recursivo
%calcAndPlotConfirmedCasesApplyingMovingAverage(50);


function [data] = getDataIntegersFromText(url, delimiter)
    data = textread(url, "%d", "delimiter", delimiter);
end

function [dataFiltered] = applyMovingAverageFilter(data, slidingWindowLength)
    tic
    M = slidingWindowLength;
    slidingWindow = zeros(1, M);

    N = length(data);
    dataFiltered = zeros(1, N);

    for i=1:N
        slidingWindow(M)  = data(i);
        dataFiltered(i) = mean(slidingWindow);
        slidingWindow(1:(M-1)) =  slidingWindow(2:M);
    end
    toc
end

function [] = calcAndPlotConfirmedCasesApplyingMovingAverage(slidingWindowLength)
    data = getDataIntegersFromText("casos_confirmados.txt", "\n");
    dataFiltered = applyMovingAverageFilter(data, slidingWindowLength);
    figure();
    hold on
    plot(data, "b", "linewidth", 2);
    plot(dataFiltered, "k", "linewidth", 3);
    lg = legend("Confirmados", strcat("Confirmados [M�dia M�vel M = ", int2str(slidingWindowLength), "]"));
    lg.FontSize = 18;
    xlabel("Dias");
    ylabel("N�mero de casos di�rios");
    hold off
end

function [] = calcAndPlotDeathsCasesApplyingMovingAverage(slidingWindowLength)
    data = getDataIntegersFromText("obitos.txt", "\n");
    dataFiltered = applyMovingAverageFilter(data, slidingWindowLength);
    figure();
    hold on
    plot(data, "b", "linewidth", 2);
    plot(dataFiltered, "k", "linewidth", 3);
    lg = legend("�bitos", strcat("�bitos [M�dia M�vel M = ", int2str(slidingWindowLength), "]"));
    lg.FontSize = 18;
    xlabel("Dias");
    ylabel("�bitos di�rios");
    hold off
end