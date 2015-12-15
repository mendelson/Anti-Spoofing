function [ evaluation ] = evaluateAcquisition( inputPath )

close all;
clc;

netEvaluation = -2;

%% Evaluating input
if size(strfind(inputPath, '.pgm'), 2) ~= 0
    netEvaluation = evaluateImage(inputPath);
elseif size(strfind(inputPath, '.mat'), 2) ~= 0
    netEvaluation = evaluateTextureFile(inputPath);
end

%% Taking the decision
if netEvaluation >= -1 && netEvaluation <= -0.5
    fprintf('\n\nNot a finger!\n');
    evaluation = -1;
elseif netEvaluation > -0.5 && netEvaluation <= 0.5
    fprintf('\n\nObfuscated finger!\n');
    evaluation = 0;
elseif netEvaluation > 0.5
    fprintf('\n\nReal finger!\n');
    evaluation = 1;
else
    fprintf('\n\nInvalid input path!\n');
    evaluation = netEvaluation;
end

end

