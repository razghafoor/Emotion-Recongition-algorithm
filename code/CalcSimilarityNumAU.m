function [ similarity ] = CalcSimilarityNumAU( case1, case2 )
%CALCSIMILARITYNUMAU If two cases are described by a similar number of AUs
%(regardless of their value), their similarity is high.
    length1 = length(case1.description);
    length2 = length(case2.description);
    
    % normalise to [0 1]
    similarity = 1 - abs(length2 - length1) / 45;
end