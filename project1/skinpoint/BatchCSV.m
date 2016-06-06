function [ dataMat, csvList ] = BatchCSV( path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileList = getAllFiles(path);
csvList = getCSVFiles(fileList);
dataMat = [];
for ii=csvList
    fileMat = importPointCSV(char(ii(1)));
    dataMat = [dataMat;fileMat];
end



function fileList = getAllFiles(dirName)
dirData = dir(dirName);
dirIndex = [dirData.isdir];
fileList = {dirData(~dirIndex).name}';
if ~isempty(fileList)
    fileList=cellfun(@(x) fullfile(dirName,x), ...
        fileList, 'UniformOutput',false);
end

function csvList = getCSVFiles(fileList)
csvList = {};
for ii=fileList'
    [path,file,maskExt] = fileparts(char(ii));
    if strcmpi('.csv', maskExt) == 1
        fprintf('%s\n',char(ii));
        csvList{end+1} = char(ii);
    end
    
end

