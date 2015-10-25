clear all;
close all;
clc
% mex getILBPCode_.cpp
mex -g getILBPCode_.cpp % use this one for debugging purposes
clc
a = [1 2 3; 4 5 6; 7 8 9]
% getILBPCode(a, 3);
