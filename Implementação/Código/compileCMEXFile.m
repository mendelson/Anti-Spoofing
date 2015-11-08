function [ ] = compileCMEXFile( file )

% clear all;
% close all;
% clc
file = strcat(file, '.cpp');
mex (file)
% mex ('-g', file) % use this one for debugging purposes
% clc
% a = [1 2 3 4 5 6 7 8 9];
% profile on
% for i = 1:1000000
%     cpp = getILBPBinaryWord_(a, 9);
% end
% 
% profile on
% for i = 1:1000000
%     cpp = getILBPBinaryWord(a, 9);
% end
% profile off
% profile viewer
% cpp


end

