function [ cbrCase ] = ConstructCaseCluster( au, varargin )
%CONSTRUCTCASE
% solution - classification associated with this case, 
% length - number of AUs this case is associated with
% list - list of AU indices this case is associated with
% typicality - number of times case has showed up
    cbrCase=struct('solution',[],'length',[],'description',[],'typicality',[]);
    % construct a new case with or without solution depending on arguments
    if nargin > 1
        label = varargin{1};
        cbrCase.solution = label;
    else
        cbrCase.solution = -1;
    end 
    cbrCase.typicality = 0;
    cbrCase.length = length(au);
    cbrCase.description = au;

end