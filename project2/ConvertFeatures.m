function [ newFeatures ] = ConvertFeatures( features )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fsize = size(features,1);
newFeatures = zeros(fsize, 12);
for i=1:fsize
    m=features(i,:);
    m=reshape(m,[7,5]);
    m1 = sum(m,1);
    m2 = sum(m,2);
    newFeatures(i,1:5)=m1(:);
    newFeatures(i,6:end)=m2(:);
end


end

