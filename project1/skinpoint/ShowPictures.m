function [ X,X_rgb,X_yiq,X_hsv ] = ShowPictures( path, rgbModel, yiqModel, hsvModel, modelType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% non skin pupule skin white
[path,file,maskExt] = fileparts(char(path));
fileName = sprintf('%s%s',file,'.jpg');
picFile = fullfile(path,fileName);
[X,map] = imread(picFile);
X_rgb = double(X);
dsize = size(X);
X_rgb = X_rgb./255.0;

X_yiq = rgb2ntsc(X);
X_hsv = rgb2hsv(X);

arrayPixel_RGB = zeros(dsize(2),3);
arrayPixel_YIQ = zeros(dsize(2),3);
arrayPixel_HSV = zeros(dsize(2),3);

for ii=1:dsize(1)
    arrayPixel_RGB(:) = X_rgb(ii,:,:);
    arrayPixel_YIQ(:) = X_yiq(ii,:,:);
    arrayPixel_HSV(:) = X_hsv(ii,:,:);
    if modelType == 0
        vrgb = predict(rgbModel,arrayPixel_RGB);
        vyiq = predict(yiqModel,arrayPixel_YIQ);
        vhsv = predict(hsvModel,arrayPixel_HSV);
    else
        vrgb = predictCovBayes(rgbModel,arrayPixel_RGB);
        vyiq = predictCovBayes(yiqModel,arrayPixel_YIQ);
        vhsv = predictCovBayes(hsvModel,arrayPixel_HSV);
    end
    X_rgb(ii,:,:)=255;
    X_yiq(ii,:,:)=255;
    X_hsv(ii,:,:)=255;
    
    I = find(vrgb == 0);
    X_rgb(ii,I,2) = 0;
    
    I = find(vyiq == 0);
    X_yiq(ii,I,2)=0;
    
    I = find(vhsv == 0);
    X_hsv(ii,I,2) = 0;
end

fprintf('Done for %s\n',fileName);

