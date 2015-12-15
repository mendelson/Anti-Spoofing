function [ ] = compileCMEXFiles( )

global parameter;

for i = 1:size(parameter.MEXFilesList, 1)
    srcFileName = strcat(parameter.MEXFilesList(i, :), '.cpp');
    mexFileName = strcat(parameter.MEXFilesList(i, :), '.mexw64');
    lastSrcModificationDate = dir(srcFileName{1, 1});
    lastSrcModificationDate = lastSrcModificationDate.date;
    lastSrcModificationDateFile = parameter.MEXFilesList(i, :);
    lastSrcModificationDateFile = strcat(lastSrcModificationDateFile{1, 1}, '.mat');
    
    if exist(lastSrcModificationDateFile, 'file') == 0 || exist(mexFileName{1, 1}, 'file') ~= 3
        save(lastSrcModificationDateFile, 'lastSrcModificationDate');
        mex(srcFileName{1, 1})
%         mex ('-g', srcFileName{1, 1) % use this one for debugging purposes
        fprintf('\n');
    else
        storedSrcModificationDate = load(lastSrcModificationDateFile, 'lastSrcModificationDate');
        
        if strcmp(storedSrcModificationDate.lastSrcModificationDate, lastSrcModificationDate) ~= 1
            save(lastSrcModificationDateFile, 'lastSrcModificationDate');
            mex(srcFileName{1, 1})
%             mex ('-g', srcFileName{1, 1) % use this one for debugging purposes
            fprintf('\n');
        end
    end
end

% file = strcat(file, '.cpp');
% mex (file)
% mex ('-g', file) % use this one for debugging purposes
% clc
% a = [1 2 3 4 5 6 7 8 9];
% profile on
% for i = 1:1000000
%     cpp = getILBPBinaryWord_(a, 9);
% end
% 
% profile on
% for i = 1:1000000
%     cpp = getILBPBinaryWord(a, 9);
% end
% profile off
% profile viewer
% cpp


end

