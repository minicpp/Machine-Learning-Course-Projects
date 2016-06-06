function [ covModel ] = fitCovBayes( X,Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
covModel = struct('u0',{},'u1',{},'s0',{},'s1',{},'is0',{},'is1',{}, ...
    'ds0',{},'ds1',{},'p0',{},'p1',{});
I0=find(Y==0);
I1=find(Y==1);
X0 = X(I0,:);
X1 = X(I1,:);
covModel(1).u0 = mean(X0);
covModel(1).u1 = mean(X1);
covModel(1).s0 = cov(X0);
covModel(1).s1 = cov(X1);
covModel(1).is0 = inv(cov(X0));
covModel(1).is1 = inv(cov(X1));
covModel(1).ds0 = det(cov(X0));
covModel(1).ds1 = det(cov(X1));
covModel(1).p0 = numel(I0)/numel(Y);
covModel(1).p1 = numel(I1)/numel(Y);
end

