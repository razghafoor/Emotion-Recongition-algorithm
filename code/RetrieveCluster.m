function [ solutions ] = RetrieveCluster(cbr, newcase)
%Retrieve returns the best matching case for newcase
    clusters=[];
    cases_list=[];
    best_cases=[];
    solutions=[];
    
    %step 2:
    
    AUs_list=newcase.description;
    for cluster=1:6 %cycle through emotion clusters
        for j=2:length(cbr(cluster).index) % Cycle through index vectors in
                                           % the emotion cluster
            indexVectorLength=length(cbr(cluster).index{j});
            if indexVectorLength <= length(AUs_list)
                %Check if indexvector is a subset of AUs_list
                test = ismemberCustom(cbr(cluster).index{j},AUs_list);
                if test == ones(1,indexVectorLength)
                   %Remove matching AUs:
                    for k = 1:indexVectorLength
                        AUs_list=AUs_list(AUs_list~=cbr(cluster).index{j}(k));
                    end
                    if sum(clusters(clusters==cluster))==0
                        clusters = [clusters;cluster];
                        cases_list=[cases_list;cbr(cluster).cases];
                    end
                end
            end
            if isempty(AUs_list)
                break;
            end
        end
        if isempty(AUs_list)
        	break;
        end
    end
    assignin('base','cases_list',cases_list); 

    %step 3:
    AUs_list=newcase.description;
    for i=1:length(cases_list)
        AUlength = length(cases_list(i).description);
        if AUlength <= length(AUs_list)
        	test = ismemberCustom(cases_list(i).description,AUs_list);
            if test == ones(1,AUlength)
                best_cases = [best_cases; cases_list(i)];
            end
        end
    end
    
    % step 4:
    % sort by length 
    assignin('base','best_cases',best_cases); 
    if ~isempty(best_cases)
    maxlength=max([best_cases.length]);
    solutions = best_cases([best_cases.length]==maxlength);
    
    % then sort by typicality:
    maxtypical=max([solutions.typicality]);
    solutions=solutions([solutions.typicality]==maxtypical);
    else
        %todo use k-NN
    end
    
end
