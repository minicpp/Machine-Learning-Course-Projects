function [ output_args ] = BatchProcess( path, maskPath, numPoint  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fileList = getAllFiles(path);
[orgList, maskList]=getAllOrgAndMaskPairFiles(path, maskPath, fileList);
tic
for ii=[1:length(orgList)]
    disp(['Processing ', int2str(ii),'/',int2str(length(orgList))])
    collectPoint(char(orgList(ii)), char(maskList(ii)), numPoint);
    toc
end

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


    function [points] = collectPoint(org,mask,numPoint)
        A = imread(org);
        Amask = imread(mask);
        bBmp = 0;
        [path,file,maskExt] = fileparts(mask);
        if strcmpi(maskExt,'.bmp')
            bBmp = 1;
        end
        s=size(A);
        smask = size(Amask);
        points = struct('index',{},'xy',{},'rgb',{},'yiq',{},'hsv',{},'skin',{});
        if ~isequal(s,smask)
            disp('The original file and mask file are not same');
            disp(org);
            return;
        end
        h=s(1);
        w=s(2);
        randIndex = [];
        rgbi=zeros(1,3);
        rgbiSkin=zeros(1,3);
        if numPoint >= h*w %select all pixels
            disp('The selected number is greater than the number of image pixels');
            disp([int2str(h*w), '/', int2str(numPoint),' selected']);
            disp(org);
            for ii=[1:h] %row index
                for jj=[1:w] %column index
                    index = jj + (ii-1)*w;
                    rgbi(:) = A(ii,jj,:);
                    rgbf = double(rgbi)/255.0;
                    yiq = rgb2ntsc(rgbf);
                    hsv = rgb2hsv(rgbf);
                    points(end+1).index = index;
                    points(end).xy=[jj,ii];
                    points(end).rgb=rgbf;
                    points(end).yiq=yiq;
                    points(end).hsv=hsv;
                    rgbiSkin(:) = Amask(ii,jj,:);
                    points(end).skin = checkSkin(rgbiSkin, bBmp);
                end
            end
        else
            v = randperm(h*w, numPoint);
            for index=v
                ii = 1+floor((index-1)/w);
                jj = mod(index-1,w)+1;
                rgbi(:) = A(ii,jj,:);
                rgbf = double(rgbi)/255.0;
                yiq = rgb2ntsc(rgbf);
                hsv = rgb2hsv(rgbf);
                points(end+1).index = index;
                points(end).xy=[jj,ii];
                points(end).rgb=rgbf;
                points(end).yiq=yiq;
                points(end).hsv=hsv;
                rgbiSkin(:) = Amask(ii,jj,:);
                points(end).skin = checkSkin(rgbiSkin, bBmp);
            end
        end

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
    
