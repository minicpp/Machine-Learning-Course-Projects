function [ NN1eval, net6eval, net12eval, treeval ] = RunTestPCA( trainFile, testFile, bfigure)
setdemorandstream(391418381)

load(trainFile);
trainSet = res;
load(testFile);
testSet = res;

trainX = trainSet(:,1:35);
trainX = ConvertPCAFeatures(trainX);
trainY = trainSet(:,end);
trainVecY = ConvertToMatrix(trainY);

if bfigure
    figure;
    gscatter(trainX(:,1),trainX(:,2),trainY,[],'ox+*sdv^<>ph.');
    xlabel('dimension 1');
    ylabel('dimension 2');
    figure;
    gscatter(trainX(:,2),trainX(:,3),trainY,[],'ox+*sdv^<>ph.');
    xlabel('dimension 2');
    ylabel('dimension 3');
    figure;
    gscatter(trainX(:,1),trainX(:,3),trainY,[],'ox+*sdv^<>ph.');
    xlabel('dimension 1');
    ylabel('dimension 3');
end

testX = testSet(:,1:35);
testX = ConvertPCAFeatures(testX);
testY = testSet(:,end);
testVecY = ConvertToMatrix(testY);

NN1 = fitcknn(trainX,trainY,'NumNeighbors',1);
pdRes = predict(NN1,testX);
vecPdRes = ConvertToMatrix(pdRes);
if bfigure
    figure;
    plotconfusion(testVecY,vecPdRes);
    title('confusion matrix of 1-NN');
end
[NN1eval, s] = getPrecision(testY,pdRes);
if bfigure
    figure;
    bar(s);
    title('precision of each number in 1-NN');
end

tree = fitctree(trainX,trainY);
pdRes = predict(tree, testX);
vecPdRes = ConvertToMatrix(pdRes);
if bfigure
    figure;
    plotconfusion(testVecY,vecPdRes);
    title('confusion matrix of DTree');
end
[treeval, s] = getPrecision(testY,pdRes);
if bfigure
    figure;
    bar(s);
    title('precision of each number in DTree');
end
%view(tree);


net1 = patternnet(6);
%view(net)
net1.trainParam.showWindow=0;
[net1,tr] = train(net1, trainX',trainVecY);
%nntraintool;
pdRes = net1(testX');
if bfigure
    figure;
    plotconfusion(testVecY,pdRes);
    title('confusion matrix of BP-6');
end
[net6eval, s] = getPrecision(vec2ind(testVecY),vec2ind(pdRes));
if bfigure
    figure;
    bar(s);
    title('precision of each number in BP-6');
end
%view(net1)

net2 = patternnet(12);
%view(net)
net2.trainParam.showWindow=0;
[net2,tr] = train(net2, trainX',trainVecY);
%nntraintool;
pdRes = net2(testX');
if bfigure
    figure;
    plotconfusion(testVecY,pdRes);
    title('confusion matrix of BP-12');
end
[net12eval, s] = getPrecision(vec2ind(testVecY),vec2ind(pdRes));
if bfigure
    figure;
    bar(s);
    title('precision of each number in BP-12');
end
%view(net2)


end

