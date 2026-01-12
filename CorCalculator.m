function [maxC,bestLag] = CorCalculator(x,y)
    [c, lags] = xcorr(x,y,'normalized');
    [maxC, bestLagIndex] = max(c);
    bestLag = lags(bestLagIndex);
end