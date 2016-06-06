function [ res ] = CreateDataset( correctSize,errorSize, p, filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

totalSize = correctSize*10+errorSize*10;
res=zeros(totalSize, 37);
index = 1;
for i=0:9
    for j=1:correctSize
        m = GetNumberMatrix(i);
        res(index,:)=[m(:)',1,i];
        index = index + 1;
    end
    for j=1:errorSize
        m = GetNumberMatrix(i,p, true);
        res(index,:)=[m(:)',0,i];
        index = index + 1;
    end     
end
save(filename,'res');
end

