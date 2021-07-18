clear 
close all
clc

% calcAndPlotConfirmedCasesApplyingMovingAverage(7);
% calcAndPlotDeathsCasesApplyingMovingAverage(7);
% calcAndPlotConfirmedCasesApplyingMovingAverage(14);
% calcAndPlotDeathsCasesApplyingMovingAverage(14);

%Para compara��o de desempenho com m�todo n�o recursivo
calcAndPlotConfirmedCasesApplyingMovingAverage(50);
calcAndPlotConfirmedCasesApplyingMovingAverage(50);


function [data] = getDataIntegersFromText(url, delimiter)
    data = textread(url, "%d", "delimiter", delimiter);
end

function [dataFiltered] = applyMovingAverageFilterRecursively(data, slidingWindowLength)
    tic
    M = slidingWindowLength;

    N = length(data);
    dataFiltered = zeros(1, N);
    
    yLast = 0;
    xLast = 0;

    for i=1:N
        dataFiltered(i) = yLast + (data(i) - xLast)*(1/M);
        
        if (i > M)
            xLast = data(i - M);
        end
        
        yLast = dataFiltered(i);
    end
    toc
end

function [] = calcAndPlotConfirmedCasesApplyingMovingAverage(slidingWindowLength)
    data = getDataIntegersFromText("casos_confirmados.txt", "\n");
    dataFiltered = applyMovingAverageFilterRecursively(data, slidingWindowLength);
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
    dataFiltered = applyMovingAverageFilterRecursively(data, slidingWindowLength);
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