function [ output_args ] = BatchProcessMat( path, maskPath, numPoint,saveMatFile,testPath )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

bTest = 0;
if numel(testPath) > 0
    bTest = 1;
end
fileList = getAllFiles(path);
[orgList, maskList]=getAllOrgAndMaskPairFiles(path, maskPath, fileList);
tic
mat=[];
for ii=[1:length(orgList)]
    disp(['Processing ', int2str(ii),'/',int2str(length(orgList))])
    matp = collectPoint(char(orgList(ii)), char(maskList(ii)), numPoint, bTest,testPath);
    mat=[mat;matp];
    toc
end
size(mat)
output_args = [];
save(saveMatFile,'mat');

function fileList = getAllFiles(dirName)
dirData = dir(dirName);
dirIndex = [dirData.isdir];
fileList = {dirData(~dirIndex).name}';
if ~isempty(fileList)
    fileList=cellfun(@(x) fullfile(dirName,x), ...
        fileList, 'UniformOutput',false);
end

function [outOrgFileList, outMaskFileList] = getAllOrgAndMaskPairFiles(orgPath,maskPath, fileList)

outOrgFileList={};
outMaskFileList={};

for ii=[1:length(fileList)]
    f = char(fileList(ii));
    [pathstr,name,ext] = fileparts(f);
    bmp=fullfile(maskPath, [name,'.bmp']);
    png=fullfile(maskPath, [name,'.png']);
    if exist(bmp,'file') == 2
        outOrgFileList{end+1} = f;
        outMaskFileList{end+1} = bmp;
    elseif exist(png,'file') == 2
        outOrgFileList{end+1} = f;
        outMaskFileList{end+1} = png;
    else
        disp(['The file ', name, ' does not have mask file']);
    end
end
outOrgFileList = outOrgFileList';
outMaskFileList = outMaskFileList';
disp([int2str(length(outOrgFileList)), ' samples are selected.']);

% for each row of matPoints: [index, x,y, rgb,yiq,hsv]
function [matPoints] = collectPoint(org,mask,numPoint, btest,testPath)
A = imread(org);
Amask = imread(mask);
bBmp = 0;
[path,file,maskExt] = fileparts(mask);
if strcmpi(maskExt,'.bmp')
    bBmp = 1;
end
s=size(A);
smask = size(Amask);
matPoints = [];
if ~isequal(s,smask)
    disp('The original file and mask file are not same');
    disp(org);
    return;
end
h=s(1);
w=s(2);
rgbi=zeros(1,3);
rgbiSkin=zeros(1,3);
if numPoint >= h*w %select all pixels
    matPoints = zeros(h*w,13);
    matPoints(:,1) = 1:h*w;
    disp('The selected number is greater than the number of image pixels');
    disp([int2str(h*w), '/', int2str(numPoint),' selected']);
    disp(org);
    for ii=1:h %row index
        for jj=1:w %column index
            index = jj + (ii-1)*w;
            rgbi(:) = A(ii,jj,:);
            rgbf = double(rgbi)/255.0;
            yiq = rgb2ntsc(rgbf);
            hsv = rgb2hsv(rgbf);
            rgbiSkin(:) = Amask(ii,jj,:);
            bSkin = checkSkin(rgbiSkin,bBmp);
            matPoints(index,2:end)=[jj, ii, rgbf, yiq, hsv, bSkin];
        end
    end
else
    v = randperm(h*w, numPoint);
    matPoints = zeros(numPoint,13);
    matPoints(:,1)=1:numPoint;
    count = 1;
    for index=v
        ii = 1+floor((index-1)/w);
        jj = mod(index-1,w)+1;
        rgbi(:) = A(ii,jj,:);
        rgbf = double(rgbi)/255.0;
        yiq = rgb2ntsc(rgbf);
        hsv = rgb2hsv(rgbf);
        rgbiSkin(:) = Amask(ii,jj,:);
        bSkin = checkSkin(rgbiSkin,bBmp);
        matPoints(count,2:end)=[jj, ii, rgbf, yiq, hsv, bSkin];
        count = count + 1;
    end
end

%Save a test file for debug use
if btest == 1
    TestA = A;
    TestB = uint8(zeros(size(TestA)));
    matPointsSize = size(matPoints);
    for ii=1:matPointsSize(1)
        info = matPoints(ii,:);
        if info(end) == 1
            TestA(info(3),info(2),:) = uint8([0, 255, 0]);            
        else
            TestA(info(3),info(2),:)=uint8([255,0,255]);
        end
        TestB(info(3),info(2),:) = uint8(hsv2rgb(info(10:12)).*255);
    end
    TestAFile = fullfile(testPath,strcat(file,'.png'));
    TestBFile = fullfile(testPath,strcat(file,'_p.png'));
    imwrite(TestA,TestAFile);
    imwrite(TestB,TestBFile);
end

%% Get Skin status
function bskin = checkSkin(rgbi,bBmp)
if bBmp == 1
    if isequal(uint8(rgbi),uint8([255,255,255]))
        bskin = 0;
    else
        bskin = 1;
    end
else
    if isequal(uint8(rgbi),uint8([255,255,255]))
        bskin = 1;
    else
        bskin = 0;
    end
end

%impixel

