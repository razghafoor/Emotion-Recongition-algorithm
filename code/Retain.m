function [ cbr ] = Retain(cbr, solvedCase)
%Retain returns an updated CBR system by storing solvedCase
    for i = 1:length(cbr)
        if isequal(cbr(i).description, solvedCase.description)
            if cbr(i).solution == solvedCase.solution
                % only increment typicality if same solution, too
                cbr(i).typicality = cbr(i).typicality + 1;
                return % don't add duplicate to CBR case base
            end
        end
    end
    cbr = [cbr solvedCase]; % unique case, add it to CBR case base
end