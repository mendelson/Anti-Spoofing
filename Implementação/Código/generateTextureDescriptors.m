close all;
clear all;
clc;

%% Loading parameters into global workspace
loadParameters;

global parameter;

%% Compiling CPP files
if parameter.useMEXFiles
    compileCMEXFiles;
end

%% Enabling parallel processing
setupNumberOfThreadsToBeUsed;

%% Generating textures
inputFolderRoot = 'input/';

textureDescriptorsFolderRoot = 'textureDescriptors/';

folderExists = 1;
initialFolderNumber = 1;
currentFolderNumber = initialFolderNumber - 1;
counter = 0;

while folderExists == 1
    clc;
    currentFolderNumber = currentFolderNumber + 1;
    
    if exist(strcat(inputFolderRoot, num2str(currentFolderNumber)), 'dir') ~= 7
        folderExists = 0;
    else
        cd(strcat(inputFolderRoot, num2str(currentFolderNumber)));
        listing = dir('*.pgm');
        cd('../../');
        
        for i = 1:size(listing)
            filePath = strcat(inputFolderRoot, num2str(currentFolderNumber), '/', listing(i).name);
            fprintf('\n\n====================================================================================================\n');
            fprintf(strcat('Evaluating image: \0', filePath, '      Currently at-', num2str(i), '/', num2str(size(listing, 1)), ' image(s) on this folder.'));
            fprintf('\n====================================================================================================\n');
            
            %% Opening input image
            input = imread(filePath);

            %% Getting AOI mask
            aoiMask = getAOIMask(input);

            %% Getting image's texture
            textureDescriptor = getTexture(input, aoiMask);
            
            %% Saving image's texture
            if exist(strcat(textureDescriptorsFolderRoot, num2str(currentFolderNumber), '/'), 'dir') ~= 7
                mkdir(strcat(textureDescriptorsFolderRoot, num2str(currentFolderNumber), '/'));
            end
            save(strcat(textureDescriptorsFolderRoot, num2str(currentFolderNumber), '/', strrep(listing(i).name, '.pgm', '.mat')), 'textureDescriptor');
            
        end
        
        counter = counter + size(listing, 1);
    end
end

fprintf('\n%d texture descriptor(s) generated!\n\nDone!\n', counter);