function [ newFeatures ] = ConvertPCAFeatures( features )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fsize = size(features,1);
%features = ConvertFeatures(features);
A = features;
%A = zscore(features);
[COEFF SCORE LATENT] = princomp(A);
newFeatures = zeros(fsize, 10);
newFeatures(:,1:10) = SCORE(:,1:10);

end

