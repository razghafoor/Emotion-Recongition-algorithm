function [ cbrCase ] = ConstructCase( au, varargin )
%CONSTRUCTCASE
% solution - classification associated with this case, 
% description - list of AU indices this case is associated with
% typicality - number of times case has showed up

    cbrCase = {};
    % construct a new case with or without solution depending on arguments
    if nargin > 1
        label = varargin{1};
        cbrCase.solution = label;
    else
        cbrCase.solution = -1;
    end 
    cbrCase.typicality = 0;
    cbrCase.description = au;

end

