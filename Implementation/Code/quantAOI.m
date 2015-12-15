function [ quantInput ] = quantAOI( input )
%quantAOI quantizes the input
%   This function is used to make the AOI free of undesired
%   'holes' inside of it or undesired disconected data.

global parameter;

padding = (parameter.quantDimension - 1)/2;
amountElements = parameter.quantDimension^2;

[height, width] = size(input);

quantInput = zeros(height, width);

if parameter.useParallel
    parfor i = padding + 1:height - padding
        for j = padding + 1:width - padding
%             if decideQuant(reshape(input(i-padding:i+padding, j-padding:j+padding), [1 amountElements]), amountElements) == 0
            if decideQuant_(double(reshape(input(i-padding:i+padding, j-padding:j+padding), [1 amountElements])), amountElements) == 0
                quantInput(i, j) = 0;
            else
                quantInput(i, j) = 1;
            end
        end
    end
else
    for i = padding + 1:height - padding
        for j = padding + 1:width - padding
%             if decideQuant(reshape(input(i-padding:i+padding, j-padding:j+padding), [1 amountElements]), amountElements) == 0
            if decideQuant_(double(reshape(input(i-padding:i+padding, j-padding:j+padding), [1 amountElements])), amountElements) == 0
                quantInput(i, j) = 0;
            else
                quantInput(i, j) = 1;
            end
        end
    end
end

end