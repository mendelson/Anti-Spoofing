function [ ] = generateMetrics1()
% close all;
clear all;
% clc;

load net/nnet1.mat

testInputSet = localInput(:,tr.testInd);
testTargetSet = localTargets(:,tr.testInd);

FAR = 0;
FRR = 0;
hitRate = 0;

for i = 1:size(testInputSet, 2)
    netEvaluation = net(testInputSet(:, i));
    evaluation = netEvaluation;
    
    %% Classification
    if netEvaluation <= 0
%         fprintf('\n%d: Not a finger!\n', i);
        evaluation = -1;
    elseif netEvaluation > 0
%         fprintf('\n%d: Real finger!\n', i);
        evaluation = 1;
    end
    
    %% Updating metrics
    if evaluation == testTargetSet(i)
        hitRate = hitRate + 1;
    elseif evaluation == -1 && testTargetSet(i) == 1
        FRR = FRR + 1;
    elseif evaluation == 1 && testTargetSet(i) == -1
        FAR = FAR + 1;
    end
end

FAR = FAR/i;
FRR = FRR/i;
hitRate = hitRate/i;

fprintf('\n\nnnet1:\nHit Rate: %.2f%%\nFalse Accept Rate: %.2f%%\nFalse Negativ Rate: %.2f%%\n', hitRate*100, FAR*100, FRR*100);

%% Ploting regression
netOutputs = net(localInput);
trainOutputs = netOutputs(:, tr.trainInd);
validationOutputs = netOutputs(:, tr.valInd);
testOutputs = netOutputs(:, tr.testInd);
trainTargets = localTargets(tr.trainInd);
validationTargets = localTargets(tr.valInd);
testTargets = localTargets(tr.testInd);
figure, plotregression(trainTargets,trainOutputs,'Training', validationTargets,validationOutputs,'Validation', testTargets,testOutputs,'Test', localTargets,netOutputs,'All');

figure, plotperform(tr);
end