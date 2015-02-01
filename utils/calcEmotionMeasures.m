function [ precisions, recalls, f1measures ] = calcEmotionMeasures( confMat )
%CALCEMOTIONMEASURES Calculates a list of measures given a confusion mat,
%one per emotion (class).
    colSum = sum(confMat,1);
    tp = [];
    for i=1:6
      tp = [tp,confMat(i,i)];
    end
    % TODO: add fscore
    precisions = tp ./ colSum;

    rowSum = sum(confMat,2)';
    recalls = tp ./ rowSum;
    
    f1measures = 2 .* (precisions .* recalls) ./ (precisions + recalls);
end