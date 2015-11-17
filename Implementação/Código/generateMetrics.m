close all;
clear all;
clc;

load net/nnet.mat

testInputSet = inputDataSet(:,tr.testInd);
testTargetSet = targetsSet(:,tr.testInd);

falsePositivRate = 0;
falseNegativRate = 0;
hitRate = 0;

for i = 1:size(testInputSet, 2)
    netEvaluation = net(testInputSet(:, i));
    evaluation = netEvaluation;
    
    %% Classification
%     if netEvaluation >= 0 && netEvaluation <= 0.25
    if netEvaluation <= 0.25
        fprintf('\nNot a finger!\n');
        evaluation = 0;
    elseif netEvaluation > 0.25 && netEvaluation <= 0.75
        fprintf('\nDistorted finger!\n');
        evaluation = 0.5;
    elseif netEvaluation > 0.75
        fprintf('\nReal finger!\n');
        evaluation = 1;
    end
    
    %% Updating metrics
    if evaluation == testTargetSet(i)
        hitRate = hitRate + 1;
    elseif evaluation <= 0.5 && testTargetSet(i) == 1
        falseNegativRate = falseNegativRate + 1;
    elseif evaluation == 1 && testTargetSet(i) <= 0.5
        falsePositivRate = falsePositivRate + 1;
    end
end

falsePositivRate = falsePositivRate/i;
falseNegativRate = falseNegativRate/i;
hitRate = hitRate/i;

fprintf('\nHit Rate: %.2f%%\nFalse Positiv Rate: %.2f%%\nFalse Negativ Rate: %.2f%%\n', hitRate*100, falsePositivRate*100, falseNegativRate*100);