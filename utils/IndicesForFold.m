function [ trainInd, testInd ] = IndicesForFold(y, foldIndex)
%IndicesForFold returns the training indices and the test indices for
% a given fold based on its index based. These are the same indices as used in
% Assignement 1.

    i = foldIndex;
    %fold length (rounded down)
    foldLength = floor(length(y)/10);
    %indices for part above fold
    indicesAfter = (i*foldLength+1):length(y);
    %indices for part below fold
    indicesBefore = 1:((i-1)*foldLength);
    %indices for fold part
    testInd = ((i-1)*foldLength+1):(i*foldLength);
    
    trainInd = cat(2, indicesBefore, indicesAfter);
end