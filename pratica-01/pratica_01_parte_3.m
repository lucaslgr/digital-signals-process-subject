clear 
close all
clc

% calcAndPlotConfirmedCasesApplyingMovingAverage(7);
% calcAndPlotDeathsCasesApplyingMovingAverage(7);
% calcAndPlotConfirmedCasesApplyingMovingAverage(14);
% calcAndPlotDeathsCasesApplyingMovingAverage(14);

%Para comparação de desempenho com método não recursivo
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
    lg = legend("Confirmados", strcat("Confirmados [Média Móvel M = ", int2str(slidingWindowLength), "]"));
    lg.FontSize = 18;
    xlabel("Dias");
    ylabel("Número de casos diários");
    hold off
end

function [] = calcAndPlotDeathsCasesApplyingMovingAverage(slidingWindowLength)
    data = getDataIntegersFromText("obitos.txt", "\n");
    dataFiltered = applyMovingAverageFilterRecursively(data, slidingWindowLength);
    figure();
    hold on
    plot(data, "b", "linewidth", 2);
    plot(dataFiltered, "k", "linewidth", 3);
    lg = legend("Óbitos", strcat("Óbitos [Média Móvel M = ", int2str(slidingWindowLength), "]"));
    lg.FontSize = 18;
    xlabel("Dias");
    ylabel("Óbitos diários");
    hold off
end