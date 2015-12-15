function [ input ] = getInputImage( inputPath )

input = imread(inputPath);

% inputFolderRoot = 'input/';
% inputFolder = '1/';
% inputFile = 'SI-2_g16_3_7_0';
% inputFileExtension = '.pgm';
% 
% input = imread(strcat(inputFolderRoot, inputFolder, inputFile, inputFileExtension));
% % input = imread('6/SI-6_g20_2_3_2.pgm');
% % input = imread('13/SI-13_g12_2_3_0.pgm');
% % input = imread('15/SI-15_g63_2_2_1.pgm');
% % input = imread('17/SI-17_g12_2_5_0.pgm');
% % input = imread('19/SI-19_g12_2_1_2.pgm');

end

