function [ output_args ] = ShowPictures( path, rgbModel, yiqModel, hsvModel, modelType)
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
pixel_RGB = zeros(1,3);
pixel_YIQ = zeros(1,3);
pixel_HSV = zeros(1,3);
for ii=1:dsize(1)
    for jj=1:dsize(2)
        pixel_RGB(:) = X_rgb(ii,jj,:);
        pixel_YIQ(:) = X_yiq(ii,jj,:);
        pixel_HSV(:) = X_hsv(ii,jj,:);
        vrgb=[];
        vyiq=[];
        vhsv=[];
        if modelType == 0
            vrgb = predict(rgbModel,pixel_RGB);
            vyiq = predict(yiqModel,pixel_YIQ);
            vhsv = predict(hsvModel,pixel_HSV);
        else
            vrgb = predictCovBayes(rgbModel,pixel_RGB);
            vyiq = predictCovBayes(yiqModel,pixel_YIQ);
            vhsv = predictCovBayes(hsvModel,pixel_HSV);
        end
        if vrgb == 0
            X_rgb(ii,jj,:) = [255,0,255];
        else
            X_rgb(ii,jj,:) = [255,255,255];
        end
        if vyiq == 0
            X_yiq(ii,jj,:) = [255,0,255];
        else
            X_yiq(ii,jj,:) = [255,255,255];
        end
        if vhsv == 0
            X_hsv(ii,jj,:) = [255,0,255];
        else
            X_hsv(ii,jj,:) = [255,255,255];
        end        
    end
end

figure;
subplot(1,4,1), subimage(X)
subplot(1,4,2), subimage(X_rgb)
subplot(1,4,3), subimage(X_yiq)
subplot(1,4,4), subimage(X_hsv)

fprintf('Done for %s\n',char(path));

