function [ predictions ] = testCBR(cbr, x2)
%testCBR takes a trained cbr system and produces a vector of label predictions

    % hardcoded initial k value, used for k-NN in Retrieve
    k = 3;

    sz = size(x2, 1);
    predictions = zeros(sz,1);
    for i=1:sz
        % NEW CASE (unsolved)
        newCase = ConstructCase(find(x2(i,:)));
        % RETRIEVE
        [bestMatchCase] = Retrieve(cbr, newCase, k);
        % REUSE
        solvedCase = Reuse(bestMatchCase, newCase);
        predictions(i) = solvedCase.solution;
        % RETAIN
        cbr = Retain(cbr, solvedCase);
    end
end