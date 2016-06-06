function [ CS ] = weightsqure( I, rotdegree )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

osz=size(I);
ms=max(osz);

% ---- First create a square of size max(width,height)
% ---- and put the original image into the center
sqim=zeros(ms);
y=floor((ms-osz(1))/2);
x=floor((ms-osz(2))/2);
sqim(1+y:y+osz(1),1+x:x+osz(2))=I;

smallersize = ms;
OPTSIZE = max(size(sqim))*2;
offset=floor((OPTSIZE-smallersize)/2);
CS=zeros(OPTSIZE+1,OPTSIZE+1);
range=1+offset:offset+smallersize;
CS(range,range)=sqim;
CS=imrotate(CS,rotdegree,'nearest','crop');

orgx = floor((OPTSIZE+1)/2) + 1;
orgy = orgx;

m00= sum(sum(CS));
t10= sum(CS,1);
m10 = sum( (1: (OPTSIZE+1)).*t10);
t01 = sum(CS,2);
m01 = sum( (1:(OPTSIZE+1))'.*t01);
px = m10/m00;
py = m01/m00;
offsetX = orgx-round(px);
offsetY = orgy-round(py);
se = translate(strel(1), [offsetY offsetX]);
CS=imdilate(CS,se);
end

