close all;
clear all;
clc;

samplesFolderRoot = '../Samples/';

inputFolderRoot = 'input/';

folderExists = 1;
initialFolderNumber = 1;
currentFolderNumber = initialFolderNumber - 1;
counter = 0;

while folderExists == 1
    currentFolderNumber = currentFolderNumber + 1;
    
    if exist(strcat(samplesFolderRoot, num2str(currentFolderNumber)), 'dir') ~= 7
        folderExists = 0;
    else
        fprintf(strcat('Copying images from folder: \0', samplesFolderRoot, num2str(currentFolderNumber), '/raw/\n'));
        cd(strcat(samplesFolderRoot, num2str(currentFolderNumber), '/raw/'));
        
        listing0 = dir('*_0.pgm');
        listing1 = dir('*_1.pgm');
        listing2 = dir('*_2.pgm');
        
        if (size(listing0) ~= size(listing1)) | (size(listing0) ~= size(listing2))
            error('Inconsistent data!');
        end
        
        cd ../../../Código/;
        
        if exist(strcat(inputFolderRoot, num2str(currentFolderNumber), '/'), 'dir') ~= 7
            mkdir(strcat(inputFolderRoot, num2str(currentFolderNumber), '/'));
        end
        
        for i = 1:size(listing0)
            copyfile(strcat(samplesFolderRoot, num2str(currentFolderNumber), '/raw/', listing0(i).name), strcat(inputFolderRoot, num2str(currentFolderNumber), '/', listing0(i).name));
            copyfile(strcat(samplesFolderRoot, num2str(currentFolderNumber), '/raw/', listing1(i).name), strcat(inputFolderRoot, num2str(currentFolderNumber), '/', listing1(i).name));
            copyfile(strcat(samplesFolderRoot, num2str(currentFolderNumber), '/raw/', listing2(i).name), strcat(inputFolderRoot, num2str(currentFolderNumber), '/', listing2(i).name));
        end
        
        counter = counter + size(listing0, 1) + size(listing1, 1) + size(listing2, 1);
    end
end

fprintf('\n%d images acquired!\n\nDone!\n', counter);