%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IF YOU DON'T WANT TO USE FUNCTIONS WRITEN IN C++, PLEASE, COMENT THE
% CALL TO FUNCTIONS TERMINATED WITH AND UNDERSCORE ("_") AND UNCOMENT
% THE CALL FOR MATLAB FUNCTIONS (THEY SHOULD BE ON THE LINE ABOVE).
% ALSO, CHANGE THE VALUE OF 'Parameters.useMEXFiles' to 'false'.
%
% CURRENTLY, THEY ARE CALLED FROM: getILBPCode.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

%% Loading parameters into global workspace
loadParameters;

global parameter;

%% Compiling CPP files
for i = 1:size(parameter.MEXFilesList, 1)
    file = strcat(parameter.MEXFilesList(i, :), '.mexw64');
    if exist(file{1, 1}, 'file') ~= 3
        if parameter.useMEXFiles
            compileCMEXFile(parameter.MEXFilesList{i, 1});
            fprintf('\n');
        end
    end
end

%% Enabling parallel processing
setupNumberOfThreadsToBeUsed;

%% Desabling image size warning
warning ('off', 'images:initSize:adjustingMag');

%% Opening input image
input = getInputImage;

if parameter.showOriginalImage
    figure, imshow(input);
    title('Original image');
end

%% Getting AOI mask
aoiMask = getAOIMask(input);

%% Getting image's texture
textureDescriptor = getTexture(input, aoiMask);
% fprintf('\nSaving texture descriptor...\n');
% save(strcat('textureDescriptors/', inputFolder, inputFile, '.mat'), 'textureDescriptor');
% load(strcat('textureDescriptors/', inputFolder, inputFile, '.mat'), 'textureDescriptor');

%% Exiting
fprintf('\nDONE!\n');