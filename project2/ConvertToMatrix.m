function [ m ] = ConvertToMatrix( vec )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
len = length(vec);
m = zeros(10, len);
for i=1:len
    v = vec(i);
    if v == 0
        v = 10;
    end
    m(v, i) = 1;
end

end

