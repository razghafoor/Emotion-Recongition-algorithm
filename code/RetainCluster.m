function [ cbr ] = RetainCluster(cbr, solvedCase)
%Retain returns an updated cbr system by storing solvedcase
    clusterNum = solvedCase.solution;
%     solvedCase = rmfield(solvedCase,'solution');
    flag = 0; % flag to check if new case have been added to the cbr
    
    % If the cbr cluster is empty, just append new case to list
    if isempty(cbr(clusterNum).cases)
        flag =1;
        cbr(clusterNum).cases = [cbr(clusterNum).cases;solvedCase];
        cbr(clusterNum).index = [cbr(clusterNum).index;{solvedCase.description}];
    else
    % If the cbr cluster is not empty:
    
    test=ones(1,solvedCase.length); % test condition to check if new case is
                                    % a strict sub set
    for i= 1:length(cbr(clusterNum).cases)
        
        % If new case is  a strict sub set of case(i):
        if (test == ismemberCustom(solvedCase.description, cbr(clusterNum).cases(i).description))
            flag =1;
            
            % If new case is a strict sub set of case(i) and have same length
            %(i.e. new case == case(i)), just increase typicality:
            if  solvedCase.length == cbr(clusterNum).cases(i).length
                cbr(clusterNum).cases(i).typicality=cbr(clusterNum).cases(i).typicality+1;
                break;
            else
            % If new case is just a strict sub set of case(i):
                % -Append new case to case list for the emotion cluster:
                cbr(clusterNum).cases = [cbr(clusterNum).cases;solvedCase];
                % -Replace case(i) in list with the new case:
                [cbr(clusterNum).index]=indexmod(cbr(clusterNum).index, solvedCase.description, cbr(clusterNum).cases(i).description);
                break;
            end
        end
    end
    end
    
    % if case has not been added, (i.e. new case is not a sub set of any
    % previous case.
    if flag ==0 
        flagidx=0;
        % -Append new case to case list for the emotion cluster:
        cbr(clusterNum).cases = [cbr(clusterNum).cases;solvedCase];
        
        % -Check if any existing case in the index is a subset of the new
        % case, if no, add new case to the index:
        for i=1:length(cbr(clusterNum).index)
            len=length(cbr(clusterNum).index{i});
            if len< solvedCase.length
                test = ones(1,len);
                if test == ismemberCustom(cbr(clusterNum).index{i},solvedCase.description)
                   flagidx=1;
                   break;
                end
            end
        end
        if flagidx == 0
        	cbr(clusterNum).index = [cbr(clusterNum).index;{solvedCase.description}];
        end
    end
    
    [~,I]=sort([cbr(clusterNum).cases.length],2,'ascend');
    cbr(clusterNum).cases=cbr(clusterNum).cases(I);

end
function [index]=indexmod(index,add,remove)
% function to replace case 'remove' with case 'add' in the index: 
	for i = 1:length(index)
    	if length(index{i})==length(remove)
        	if sum(index{i}-remove)==0
            	index{i} = add;
            	break;
            end
        end
        
    end
        
end