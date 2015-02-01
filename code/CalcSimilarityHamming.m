function [ similarity ] = CalcSimilarityHamming( case1, case2 )
%CALCSIMILARITYHAMMING Normalised Hamming distance measure.
    au1 = zeros(45, 1);
    au2 = zeros(45, 1);
    
    au1(case1.description) = 1;
    au2(case2.description) = 1;
    
    similarity=1-sum(abs(au1-au2))/45;
end