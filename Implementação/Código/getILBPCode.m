function [ ILBPCode ] = getILBPCode( input, dimension )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global parameter;

amountElements = dimension^2;

% input = transpose(input);
input = reshape(input.', [1 amountElements]);

avg = mean(input);

word = zeros(1, amountElements);

ILBPCode = 0;

if parameter.useParallel
    parfor i = 1:amountElements
        if input(i) < avg
            word(i) = 0;
        else
            word(i) = 1;
        end
    end

    parfor i = 1:amountElements
        ILBPCode = ILBPCode + (word(amountElements + 1 - i)*(2^(i - 1)));
    end
else
    for i = 1:amountElements
        if input(i) < avg
            word(i) = 0;
        else
            word(i) = 1;
        end
    end

    for i = 1:amountElements
        ILBPCode = ILBPCode + (word(amountElements + 1 - i)*(2^(i - 1)));
    end
end

end