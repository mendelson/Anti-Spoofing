clear all
close all
clc

% load house_dataset;
% [inputDataSet, targetsSet] = setDataSet();
[houseInputs, houseTargets] = setDataSet();

Perf = Inf;

for i = 20
    
    net = feedforwardnet(i);
    net = configure(net,houseInputs,houseTargets);
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'tansig';
    net.divideParam.trainRatio = 0.7;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0.15;
    net.trainParam.epochs = 200;
    net.divideFcn = 'dividerand';
    
    for j = 10:2:40        
        net = init(net);        
        [net,tr] = train(net,houseInputs,houseTargets);
        SaidasSimuladas = net(houseInputs(:,tr.testInd));
        ERRO = sum(abs(SaidasSimuladas-houseTargets(:,tr.testInd)))/length(tr.testInd);
        [j i tr.best_tperf Perf]
        
        if tr.best_tperf < Perf
            Perf = tr.best_tperf;
            save rede.mat
        end
    end
end

plot(houseTargets(tr.testInd),net(houseInputs(:,tr.testInd)'),'ro')
xlabel('Original')
ylabel('Predito')
grid on

[SaidasSimuladas ; houseTargets(tr.testInd)]'