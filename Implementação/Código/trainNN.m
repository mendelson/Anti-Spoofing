%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU HAVE SETUP THE ENVIRONMENT PROPERLY.%
% RUNNING 'setupInputImages.m' and 'generateTextureDescriptors.m' SHOULD BE     %
% ENOUGH.                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

[inputDataSet, targetsSet] = setDataSet();

if exist('net/', 'dir') ~= 7
    mkdir('net/');
end

best_perform = Inf;
best_i = 0;
best_j = 0;

for i = 10:25
    
    net = feedforwardnet(i);
    net = configure(net, inputDataSet, targetsSet);
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'tansig';
    net.divideParam.trainRatio = 0.33;
    net.divideParam.valRatio = 0.33;
    net.divideParam.testRatio = 0.34;
    net.trainParam.epochs = 1000;
    net.divideFcn = 'dividerand';
    
    for j = 1:20
        net = init(net);
        net.trainParam.showWindow = true;
        [net, tr] = train(net, inputDataSet, targetsSet);
        SaidasSimuladas = net(inputDataSet(:, tr.testInd));
        ERRO = sum(abs(SaidasSimuladas-targetsSet(:, tr.testInd)))/length(tr.testInd);
        
        if tr.best_tperf < best_perform
            best_perform = tr.best_tperf;
            best_i = i;
            best_j = j;
            save net/nnet.mat
        end
        
        clc
        fprintf('===== Current =====\nNeurons: %d\nTraining attempt: %d\nPerformance: %f\n===== Best =====\nNeurons: %d\nTraining attempt: %d\nPerformance: %f', i, j, tr.best_tperf, best_i, best_j, best_perform);
        
    end
end

% load net/rede.mat

% plotperf(tr)

% houseOutputs = net(houseInputs);
% trOut = houseOutputs(tr.trainInd);
% vOut = houseOutputs(tr.valInd);
% tsOut = houseOutputs(tr.testInd);
% trTarg = houseTargets(tr.trainInd);
% vTarg = houseTargets(tr.valInd);
% tsTarg = houseTargets(tr.testInd);
% plotregression(trTarg,trOut,'Train',vTarg,vOut,'Validation',...
% tsTarg,tsOut,'Testing')

plot(targetsSet(tr.testInd), net(inputDataSet(:, tr.testInd)), 'ro')
xlabel('Original')
ylabel('Predicted')
grid on

[SaidasSimuladas ; targetsSet(tr.testInd)]'