function [ NN1eval, net6eval, net12eval, treeval ] = RunTest( trainFile, testFile, bfigure )
setdemorandstream(391418381)

load(trainFile);
trainSet = res;
load(testFile);
testSet = res;

trainX = trainSet(:,1:35);
trainY = trainSet(:,end);
trainVecY = ConvertToMatrix(trainY);

testX = testSet(:,1:35);
testY = testSet(:,end);
testVecY = ConvertToMatrix(testY);

NN1 = fitcknn(trainX,trainY,'NumNeighbors',1);
pdRes = predict(NN1,testX);
vecPdRes = ConvertToMatrix(pdRes);
if bfigure
    figure;
    plotconfusion(testVecY,vecPdRes);
end
NN1eval = getPrecision(testY,pdRes);

net1 = patternnet(6);
%view(net)
net1.trainParam.showWindow=0;
[net1,tr] = train(net1, trainX',trainVecY);
%nntraintool;
pdRes = net1(testX');
if bfigure
    figure;
    plotconfusion(testVecY,pdRes);
end
net6eval = getPrecision(vec2ind(testVecY),vec2ind(pdRes));
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
end
net12eval = getPrecision(vec2ind(testVecY),vec2ind(pdRes));
%view(net2)

tree = fitctree(trainX,trainY);
pdRes = predict(tree, testX);
vecPdRes = ConvertToMatrix(pdRes);
if bfigure
    figure;
    plotconfusion(testVecY,vecPdRes);
end
treeval = getPrecision(testY,pdRes);
%view(tree);
end

