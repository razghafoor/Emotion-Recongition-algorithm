function [ precision ] = calcPrecision( confusionMat, class )
%CALCPRECISION Calculates the precision rate for a given confusion matrix
%and class.
    [truePositives, falsePositives, ~, ~] = confusionMatBreakdown(confusionMat, class);
    if truePositives == 0 && falsePositives == 0
        precision = 0;
    else
        precision = truePositives / (truePositives + falsePositives);
    end
end

