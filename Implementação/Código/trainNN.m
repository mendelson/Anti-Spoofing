%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU HAVE SETUP THE ENVIRONMENT PROPERLY.%
% RUNNING 'setupInputImages.m' and 'generateTextureDescriptors.m' SHOULD BE     %
% ENOUGH.                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

textureDescriptorsFolderRoot = 'textureDescriptors/';
foldersWithRealFingers = [1];

realFingers = struct([]);

for i = 1:size(foldersWithRealFingers, 2)
    textureDescriptorsFiles = dir(strcat(textureDescriptorsFolderRoot, num2str(i), '/*.mat'));
    
    for j = 1:size(textureDescriptorsFiles, 1)
        realFingers(end + 1) = struct('name', textureDescriptorsFiles(j).name);
    end
end