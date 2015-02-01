function [ lia ] = ismemberCustom( a, b )
%ISMEMBERCUSTOM 
    lengtha = length(a);
    lengthb = length(b);
    lia = zeros(1,lengtha);
    for i=1:lengtha
        lia(i) = 0;
        for j=1:lengthb
            if a(i) == b(j)
                lia(i) = 1;
            end
        end
    end

end

