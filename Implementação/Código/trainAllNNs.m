%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU HAVE SETUP THE ENVIRONMENT PROPERLY.%
% RUNNING 'setupInputImages.m' and 'generateTextureDescriptors.m' SHOULD BE     %
% ENOUGH.                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

[inputDataSet, targetsSet] = setDataSet();

trainNN1(inputDataSet, targetsSet);
trainNN2(inputDataSet, targetsSet);
trainNN3(inputDataSet, targetsSet);
trainNN(inputDataSet, targetsSet);