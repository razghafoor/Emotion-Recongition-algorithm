function [ cbr ] = CBRinit( x, y )
%CBRINIT Initializes the CBR structure, i.e. a list of solved cases built
%using ConstructCase.
    cbr = [];
    n = size(x, 1);
    
    for i = 1:n
        au = find(x(i,:)); % au is vector of au indices
        label = y(i);
        
        % NEW CASE
        newCase = ConstructCase(au, label);
        % RETAIN
        cbr = Retain(cbr, newCase);
    end
end