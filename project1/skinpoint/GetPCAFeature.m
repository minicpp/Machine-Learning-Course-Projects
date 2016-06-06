function [ score ] = GetPCAFeature( featureSet )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
matDataSet = zscore(featureSet);
[coeff, score, latent] = princomp(matDataSet);
score = score(:,1:3);
end

