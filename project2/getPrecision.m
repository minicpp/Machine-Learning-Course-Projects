function [ precision, s ] = getPrecision( target, predict )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
c = confusionmat(target,predict);
precision = trace(c)/length(predict(:));
s = diag(c) ./ (length(predict(:))/ length(diag(c)));

end

