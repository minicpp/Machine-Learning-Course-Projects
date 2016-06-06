function [ output_args ] = CreateDatasetRand( sizeEach, p, filename )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
totalSize = sizeEach*10;
res=zeros(totalSize, 37);
index = 1;
for i=0:9
    for j=1:sizeEach
        m1 = GetNumberMatrix(i);
        m = GetNumberMatrix(i,p, false);
        result = m1==m;
        if result
            res(index,:)=[m(:)', 1, i];
        else
            res(index,:)=[m(:)', 0, i];
        end
        index = index + 1;
    end
end
save(filename,'res');

end

