%% Load Training Data
dataMat = BatchCSV('dataset\training');
X_RGB=dataMat(:,3:5);
X_YIQ=dataMat(:,6:8);
X_HSV=dataMat(:,9:11);
X_PCA = GetPCAFeature(dataMat(:,3:11));
Y=dataMat(:,end);
tabulate(Y);

%% Load Testing Data
[testMat,testFileList] = BatchCSV('dataset\test');
tX_RGB=testMat(:,3:5);
tX_YIQ=testMat(:,6:8);
tX_HSV=testMat(:,9:11);
tX_PCA = GetPCAFeature(testMat(:,3:11));
tY=testMat(:,end);
tabulate(tY);

%% Train Naive Bayes for three spaces
NBModel_RGB = fitNaiveBayes(X_RGB,Y);
NBModel_YIQ = fitNaiveBayes(X_YIQ,Y);
NBModel_HSV = fitNaiveBayes(X_HSV,Y);
NBModel_PCA = fitNaiveBayes(X_PCA,Y);

%% Test Naive Bayes
predictNB_RGB = predict(NBModel_RGB,tX_RGB);
predictNB_YIQ = predict(NBModel_YIQ,tX_YIQ);
predictNB_HSV = predict(NBModel_HSV,tX_HSV);
predictNB_PCA = predict(NBModel_PCA,tX_PCA);

%%
%plotconfusion([1 0 0 1],[0 1 0 1])

%, 'RGB', tY, predictNB_YIQ,'YIQ', ...
%    tY, predictNB_RGB,'HSV', tY, predictNB_PCA, 'PCA');


%% Train Covariate Bayes for three spaces
COVModel_RGB = fitCovBayes(X_RGB,Y);
COVModel_YIQ = fitCovBayes(X_YIQ,Y);
COVModel_HSV = fitCovBayes(X_HSV,Y);
COVModel_PCA = fitCovBayes(X_PCA,Y);

%% Test Covariate Bayes
predictCOV_RGB = predictCovBayes(COVModel_RGB,tX_RGB);
predictCOV_YIQ = predictCovBayes(COVModel_YIQ,tX_YIQ);

predictCOV_HSV = predictCovBayes(COVModel_HSV,tX_HSV);
predictCOV_PCA = predictCovBayes(COVModel_PCA,tX_PCA);
% 
% figure;
% plotconfusion(tY',predictNB_RGB','Naive Bayes in RGB space',tY',predictNB_YIQ','Naive Bayes in YIQ space', ...
%     tY',predictNB_HSV','Naive Bayes in HSV space',tY',predictNB_PCA','Naive Bayes in PCA space');
% 
% 
% figure;
% plotconfusion(tY',predictCOV_RGB','Bayesian decision in RGB space', ...
%     tY',predictCOV_YIQ','Bayesian decision in YIQ space', ...
%     tY',predictCOV_HSV','Bayesian decision in HSV space', ...
%     tY',predictCOV_PCA','Bayesian decision in PCA space')

% plotconfusion(tY',predictNB_YIQ','Naive Bayes in YIQ space');
%     tY',predictNB_YIQ','Naive Bayes in YIQ space', ...
%     tY',predictNB_HSV','Naive Bayes in HSV space', ...
%     tY',predictNB_PCA','Naive Bayes in PCA space', ...

%predictRes = predictCovBayes(CovModel, X_RGB);



%%
 testFileList={'dataset\ChicagoBulls.jpg','dataset\Girl.jpg','dataset\Girl2.jpg', ...
     'dataset\Trophy.jpg'}
% testFileList = {'dataset\test\t0.jpg','dataset\test\t1.jpg','dataset\test\t2.jpg','dataset\test\t3.jpg', ...
%     'dataset\test\t4.jpg','dataset\test\t5.jpg','dataset\test\t6.jpg','dataset\test\t7.jpg'};

for ii=testFileList
    
    figure;
[X,X_rgb,X_yiq,X_hsv] = ShowPictures(ii,NBModel_RGB,NBModel_YIQ,NBModel_HSV,0);

p = subplot(2,4,1), subimage(X)
set( get(p,'XLabel'), 'String', 'Original image' );
p = subplot(2,4,2), subimage(X_rgb)
set( get(p,'XLabel'), 'String', 'RGB (Naive Bayes)' );
p = subplot(2,4,3), subimage(X_yiq)
set( get(p,'XLabel'), 'String', 'YIQ (Naive Bayes)' );
p = subplot(2,4,4), subimage(X_hsv)
set( get(p,'XLabel'), 'String', 'HSV (Naive Bayes)' );

[X,X_rgb,X_yiq,X_hsv] = ShowPictures(ii,COVModel_RGB,COVModel_YIQ,COVModel_HSV,1);

p=subplot(2,4,5), subimage(X)
set( get(p,'XLabel'), 'String', 'Original image' );
p=subplot(2,4,6), subimage(X_rgb)
set( get(p,'XLabel'), 'String', 'RGB (Bayesian decision)' );
p=subplot(2,4,7), subimage(X_yiq)
set( get(p,'XLabel'), 'String', 'YIQ (Bayesian decision)' );
p=subplot(2,4,8), subimage(X_hsv)
set( get(p,'XLabel'), 'String', 'HSV (Bayesian decision)' );
pause();

end



