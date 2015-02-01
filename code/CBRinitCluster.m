function [ cbr ] = CBRinitCluster( x, y )
%CBRINIT Initializes the CBR structure.
% TODO use better structure
% TODO find similar cases as building?

    cluster=struct('label',[],'cases',[],'index',[]);
    cbr = repmat(cluster,6,1);

    for i=1:6 % 6 clusters, 1 for each emotion
        cbr(i).label = i;
    end
    
    n = size(x, 1);
    for i = 1:n
        au = find(x(i,:)); % au is vector of au indices
        label = y(i);
        
        % NEW CASE
        newCase = ConstructCaseCluster(au, label);
        % RETAIN
        cbr = RetainCluster(cbr, newCase);
        assignin('base', 'cbr', cbr);

    end
    
end
