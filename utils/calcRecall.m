function [ recall ] = calcRecall( confusionMat, class )
%CALCRECALL Calculates the recall rate for a given confusion matrix and
%class.
    [truePositives, ~, ~, falseNegatives] = confusionMatBreakdown(confusionMat, class);
    if truePositives == 0 && falseNegatives == 0
        recall = 0;
    else
        recall = truePositives / (truePositives + falseNegatives);
    end
end

