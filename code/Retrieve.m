function [ bestMatchCase ] = Retrieve(cbr, newCase, k)
%Retrieve returns the best matching case for newcase
%using weighted voting of the k nearest neighbors.

    n = size(cbr,2);
    sim = zeros(n,1);
    % calculate similiraties to newcase for every case
    for i=1:n
        sim(i) = CalcSimilarityEuclidean(newCase,cbr(i));
    end
    
    % sort these similiraties to retrieve the k nearest neighbors 
    [sim, simIndex] = sort(sim, 'descend');
    nearestKSol = zeros(6,1);
    for i = 1:6
        % store the unweighted vote for each class: (1+typicality) per case belonging to it
        unweightedVotes = (1 + [cbr(simIndex(1:k)).typicality]).*([cbr(simIndex(1:k)).solution] == i);
        % weight the votes by the case similarities
        nearestKSol(i) = sum(unweightedVotes*sim(1:k));
    end
    
    % get the "elected" class as the maximum vote
    [maxVal, bestClass] = max(nearestKSol);
    % set the nearest neighbor of the best class as the matching case
    neighbors = [cbr(simIndex(1:k))];
    for i = 1:k
        if neighbors(i).solution == bestClass
             bestMatchCase = neighbors(i);
             break
        end
    end
    
    % if we reach k threshold, terminate
    if k >= 10
        return
    end
    
    % recurse if there is a tie for best matching class
    % using k+1 neighbors
    numMax = length(find(nearestKSol >= maxVal));
    if numMax > 1
        bestMatchCase = Retrieve(cbr, newCase, k+1);
    end
end

