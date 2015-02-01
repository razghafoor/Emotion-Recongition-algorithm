function [ similarity ] = CalcSimilarityEuclidean( case1, case2 )
%CALCSIMILARITYEUCLIDEAN Normalised Euclidean distance measure.
    au1 = zeros(45, 1);
    au2 = zeros(45, 1);
    
    au1(case1.description) = 1;
    au2(case2.description) = 1;
    
    similarity=1-sqrt(sum((au1-au2).^2)/45);
end