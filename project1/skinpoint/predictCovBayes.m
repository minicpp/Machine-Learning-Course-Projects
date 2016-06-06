function [ res ] = predictCovBayes( covModel, X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
g0 = getG(covModel.u0, covModel.is0, covModel.ds0, covModel.p0, X);
g1 = getG(covModel.u1, covModel.is1, covModel.ds1, covModel.p1, X);
res=g0<g1;
res=+res;
function g = getG(u,is,ds,p,X)
x_u = bsxfun(@minus,X,u);
term1 = -0.5.*x_u*is;
x_u_t = x_u';
lenX = size(X,1);
g = zeros(lenX,1);
term2 = -log(2*pi)-0.5.*log(ds)+log(p);
for ii=1:lenX
    g(ii) = term1(ii,:)*x_u_t(:,ii);
    g(ii) = g(ii) + term2;
end


