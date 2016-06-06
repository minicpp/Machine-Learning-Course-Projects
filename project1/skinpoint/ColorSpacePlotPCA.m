function [ output_args ] = ColorSpacePlotPCA( pixMat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%plot scatter
plotScatter(pixMat(:,4),pixMat(:,5),pixMat(:,end),'Dim-1','Dim-2');
plotScatter(pixMat(:,4),pixMat(:,6),pixMat(:,end),'Dim-1','Dim-3');
plotScatter(pixMat(:,5),pixMat(:,6),pixMat(:,end),'Dim-2','Dim-3');

skinIndex = find(pixMat(:,end)>0);
nonSkinIndex = find(pixMat(:,end)==0);
skinMat = pixMat(skinIndex,:);
nonSkinMat = pixMat(nonSkinIndex,:);

figure;
skinSize = length(skinIndex);
nonSkinSize = length(nonSkinIndex);
bar([skinSize, nonSkinSize],'FaceColor',[0    0.5059    0.8392],'EdgeColor',[0.2 0.2 0.2],'LineWidth',1.4)
x=xlim;
xlim([x(1),x(2)+0.2]);
y=ylim;
ylim([y(1),y(2)+nonSkinSize/10]);
text(1,skinSize,num2str(skinSize), 'HorizontalAlignment','center', ...
    'VerticalAlignment','bottom');
text(2,nonSkinSize,num2str(nonSkinSize),'HorizontalAlignment','center', ...
    'VerticalAlignment','bottom');
Labels = {'Skin','Non-skin'};
set(gca, 'XTick', [1,2], 'XTickLabel', Labels);
xlabel('Category') %
ylabel('The number of samples')%
title('The number of collected skin pixels and non-skin pixels')

plot9Features(pixMat)

%plot RGB
plot9Figures(skinMat(:,4:6),nonSkinMat(:,4:6),['Dim-1';'Dim-2';'Dim-3'])
plot9Figures(skinMat(:,7:9),nonSkinMat(:,7:9),['Dim-4';'Dim-5';'Dim-6'])

function plot9Features(dataSet)
figure;

subplot(3,3,1)
[n,xout] = hist(dataSet(:,4),256);
bar(xout,n,'FaceColor',[0.0824    0.4392    0.6510],'EdgeColor',[0.0824    0.4392    0.6510],'LineWidth',0.001)
xlabel('Dimension-1') %
ylabel('Sample size')%

subplot(3,3,2)
[n,xout] = hist(dataSet(:,5),256);
bar(xout,n,'FaceColor',[0.0824    0.4392    0.6510],'EdgeColor',[0.0824    0.4392    0.6510],'LineWidth',0.001)
xlabel('Dimension-2') %
ylabel('Sample size')%

subplot(3,3,3)
[n,xout] = hist(dataSet(:,6),256);
bar(xout,n,'FaceColor',[0.0824    0.4392    0.6510],'EdgeColor',[0.0824    0.4392    0.6510],'LineWidth',0.001)
xlabel('Dimension-3') %
ylabel('Sample size')%


subplot(3,3,4)
[n,xout] = hist(dataSet(:,7),256);
bar(xout,n,'FaceColor',[0.5529    0.2471    0.5333],'EdgeColor',[0.5529    0.2471    0.5333],'LineWidth',0.001)
xlabel('Dimension-4') %
ylabel('Sample size')%

subplot(3,3,5)
[n,xout] = hist(dataSet(:,8),256);
bar(xout,n,'FaceColor',[0.5529    0.2471    0.5333],'EdgeColor',[0.5529    0.2471    0.5333],'LineWidth',0.001)
xlabel('Dimension-5') %
ylabel('Sample size')%

subplot(3,3,6)
[n,xout] = hist(dataSet(:,9),256);
bar(xout,n,'FaceColor',[0.5529    0.2471    0.5333],'EdgeColor',[0.5529    0.2471    0.5333],'LineWidth',0.001)
xlabel('Dimension-6') %
ylabel('Sample size')%

subplot(3,3,7)
[n,xout] = hist(dataSet(:,10),256);
bar(xout,n,'FaceColor',[0.8392    0.3020    0.1608],'EdgeColor',[0.8392    0.3020    0.1608],'LineWidth',0.001)
xlabel('Dimension-7') %
ylabel('Sample size')%

subplot(3,3,8)
[n,xout] = hist(dataSet(:,11),256);
bar(xout,n,'FaceColor',[0.8392    0.3020    0.1608],'EdgeColor',[0.8392    0.3020    0.1608],'LineWidth',0.001)
xlabel('Dimension-8') %
ylabel('Sample size')%

subplot(3,3,9)
[n,xout] = hist(dataSet(:,12),256);
bar(xout,n,'FaceColor',[0.8392    0.3020    0.1608],'EdgeColor',[0.8392    0.3020    0.1608],'LineWidth',0.001)
xlabel('Dimension-9') %
ylabel('Sample size')%

function plot9Figures(skin, nonskin, labelstr)
figure;
lowX = min([skin;nonskin]);
highX = max([skin;nonskin]);

subplot(3,3,1)
h=histfit(skin(:,1));
set(h(1),'EdgeColor',[0.8706    0.6039    0.5647]);
set(h(2),'color',[0.8588    0.2745    0.1922]);
title('Skin samples');
xlabel(strcat(char(labelstr(1)), ' in skin samples'))
ylabel('Counts')


subplot(3,3,2)
h=histfit(nonskin(:,1));
set(h(1),'EdgeColor',[0.8706    0.6039    0.5647]);
set(h(2),'color',[0.8588    0.2745    0.1922]);
title('Non-skin samples');
xlabel(strcat(char(labelstr(1)), ' in non-skin samples'))
ylabel('Counts')

subplot(3,3,3)
pdS = fitdist(skin(:,1),'Normal');
pdN = fitdist(nonskin(:,1),'Normal');
X = [lowX(1):(highX(1)-lowX(1))/99 :highX(1)];
YS=pdf(pdS,X);
YN=pdf(pdN,X);
plot(X,YS,'r',X,YN,'b','LineWidth',1.5);
title('Distributions');
xlabel( sprintf('Value of %s',char(labelstr(1))) )
ylabel('Probability')
legend('Skin','Nonskin');

subplot(3,3,4)
h = histfit(skin(:,2));
set(h(1),'EdgeColor',[0.6000    0.8588    0.7451]);
set(h(2),'color',[0    0.6471    0.3647]);
xlabel(strcat(char(labelstr(2)), ' in skin samples'))
ylabel('Counts')

subplot(3,3,5)
h = histfit(nonskin(:,2));
set(h(1),'EdgeColor',[0.6000    0.8588    0.7451]);
set(h(2),'color',[0    0.6471    0.3647]);
xlabel(strcat(char(labelstr(2)), ' in non-skin samples'))
ylabel('Counts')

subplot(3,3,6)
pdS = fitdist(skin(:,2),'Normal');
pdN = fitdist(nonskin(:,2),'Normal');
X = [lowX(2):(highX(2)-lowX(2))/99:highX(2)];
YS=pdf(pdS,X);
YN=pdf(pdN,X);
plot(X,YS,'r',X,YN,'b','LineWidth',1.5);
title('Distributions');
xlabel( sprintf('Value of %s',char(labelstr(2))) )
ylabel('Probability')

subplot(3,3,7)
h = histfit(skin(:,3));
set(h(1),'EdgeColor',[.8 .8 1]);
set(h(2),'color','b');
xlabel(strcat(char(labelstr(3)), ' in skin samples'))
ylabel('Counts')

subplot(3,3,8)
h = histfit(nonskin(:,3));
set(h(1),'EdgeColor',[.8 .8 1]);
set(h(2),'color','b');
xlabel(strcat(char(labelstr(2)), ' in non-skin samples'))
ylabel('Counts')

subplot(3,3,9)
pdS = fitdist(skin(:,3),'Normal');
pdN = fitdist(nonskin(:,3),'Normal');
X = [lowX(3): (highX(3)-lowX(3))/99  :highX(3)];
YS=pdf(pdS,X);
YN=pdf(pdN,X);
plot(X,YS,'r',X,YN,'b','LineWidth',1.5);
xlabel( sprintf('Value of %s',char(labelstr(3))) )
ylabel('Probability')

function plotScatter(s1, s2, skin, a1, a2)
index = randperm(length(s1), 5000);
s1=s1(index);
s2=s2(index);
skin=skin(index);

[B,I] = sort(skin);
skin = B;
s1=s1(I);
s2=s2(I);

cmap = hsv(2);
colorDraw = zeros(length(skin),3);
nS = find(skin==0)
colorDraw(nS,3) = 1;
sS = find(skin==1)
colorDraw(sS,1) = 1;
figure;
%scatter(s1, s2, 10, colorDraw,'filled');
gscatter(s1,s2,skin,'br','xo')
legend('non-skin','skin');
xlabel(a1);
ylabel(a2);

