function [ ] = generateMatrics()
% close all;
clear all;
% clc;

load net/nnet.mat

testInputSet = inputDataSet(:,tr.testInd);
testTargetSet = targetsSet(:,tr.testInd);

FAR = 0;
FRR = 0;
hitRate = 0;

for i = 1:size(testInputSet, 2)
    netEvaluation = net(testInputSet(:, i));
    evaluation = netEvaluation;
    
    %% Classification
    if netEvaluation <= -0.5
%         fprintf('\n%d: Not a finger!\n', i);
        evaluation = -1;
    elseif netEvaluation > -0.5 && netEvaluation <= 0.5
%         fprintf('\n%d: Obfuscated finger!\n', i);
        evaluation = 0;
    elseif netEvaluation > 0.5
%         fprintf('\n%d: Real finger!\n', i);
        evaluation = 1;
    end
    
    %% Updating metrics
    if evaluation == testTargetSet(i)
        hitRate = hitRate + 1;
    elseif evaluation <= 0.5 && testTargetSet(i) == 1
        FRR = FRR + 1;
    elseif evaluation == 1 && testTargetSet(i) <= 0.5
        FAR = FAR + 1;
    end
end

FAR = FAR/i;
FRR = FRR/i;
hitRate = hitRate/i;

fprintf('\n\nnnet:\nHit Rate: %.2f%%\nFalse Accept Rate: %.2f%%\nFalse Negativ Rate: %.2f%%\n', hitRate*100, FAR*100, FRR*100);

%% Ploting regression
netOutputs = net(inputDataSet);
trainOutputs = netOutputs(:, tr.trainInd);
validationOutputs = netOutputs(:, tr.valInd);
testOutputs = netOutputs(:, tr.testInd);
trainTargets = targetsSet(tr.trainInd);
validationTargets = targetsSet(tr.valInd);
testTargets = targetsSet(tr.testInd);
figure, plotregression(trainTargets,trainOutputs,'Training', validationTargets,validationOutputs,'Validation', testTargets,testOutputs,'Test', targetsSet,netOutputs,'All');

figure, plotperform(tr);
end

