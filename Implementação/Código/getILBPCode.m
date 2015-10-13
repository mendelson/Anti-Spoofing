function [ ILBPCode ] = getILBPCode( input, dimension, useParallel )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

amountElements = dimension^2;

input = reshape(input.', [1 amountElements]);

avg = mean(input);

word = zeros(1, amountElements);

ILBPCode = 0;

if useParallel
    parfor i = 1:amountElements
        if input(i) < avg
            word(i) = 0;
        else
            word(i) = 1;
        end
    end
else
    for i = 1:amountElements
        if input(i) < avg
            word(i) = 0;
        else
            word(i) = 1;
        end
    end
end

for i = 1:amountElements
        ILBPCode = ILBPCode + (word(amountElements + 1 - i)*(2^(i - 1)));
end

end