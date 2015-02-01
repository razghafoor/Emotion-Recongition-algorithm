function [ fa ] = calcFmeasure( precision, recall, a )
%CALCFMEASURE Calculates F_a, which combines precision and recall rates in
%a single expression. a defines the weighting; for even weights, a = 1.
    if precision == 0 && recall == 0
        fa = 0;
    else
        fa = (1 + a) * (precision * recall) / (a * precision + recall);
    end
end