function [ evaluation ] = evaluateAcquisition( inputPath )

close all;
% clear all;
clc;

netEvaluation = -1;

%% Evaluating input
if size(strfind(inputPath, '.pgm'), 2) ~= 0
    netEvaluation = evaluateImage(inputPath);
elseif size(strfind(inputPath, '.mat'), 2) ~= 0
    netEvaluation = evaluateTextureFile(inputPath);
end

%% Taking the decision
if netEvaluation >= 0 && netEvaluation <= 0.25
    fprintf('\n\nNot a finger!\n');
    evaluation = 0;
elseif netEvaluation > 0.25 && netEvaluation <= 0.75
    fprintf('\n\nDistorted finger!\n');
    evaluation = 0.5;
elseif netEvaluation > 0.75
    fprintf('\n\nReal finger!\n');
    evaluation = 1;
else
    fprintf('\n\nInvalid input path!\n');
    evaluation = netEvaluation;
end

end

