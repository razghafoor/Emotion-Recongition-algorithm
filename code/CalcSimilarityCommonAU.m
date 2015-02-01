function [ similarity ] = CalcSimilarityCommonAU( case1, case2 )
%CALCSIMILARITYCOMMONAU If two cases share a high number of common AUs,
%their similarity is likewise high.
    length1 = length(case1.description);
    length2 = length(case2.description);
    % counts the number of common AUs to both cases
    % use the longer one first in ismember to take into account
    % extra AUs - which will decrease similarity
    % ex: [1 2] and [1 2] are more similiar than [1 2 3] and [1 2] 
    if length1 <= length2
        similarity = ismemberCustom(case2.description,case1.description);
    else
        similarity = ismemberCustom(case1.description,case2.description);
    end
    % normalise to [0 1]
    similarity = sum(similarity) / length(similarity);
end