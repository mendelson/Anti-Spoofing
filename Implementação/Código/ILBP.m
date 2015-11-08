function [ textureDescriptor ] = ILBP( input )

global parameter;

padding = (parameter.ILBPNeighborhoodDimension - 1)/2;

[height, width] = size(input);

textureDescriptor = zeros(1, 2^(parameter.ILBPNeighborhoodDimension^2));

ILBPCodes = zeros(height, width);

fprintf('\nCalculating texture codes...\n');
if parameter.useParallel
    parfor i = padding + 1:height - padding
        for j = padding + 1:width - padding
            if input(i, j) ~= 0
                key = getILBPCode(input(i-padding:i+padding, j-padding:j+padding), parameter.ILBPNeighborhoodDimension);
                ILBPCodes(i, j) = key;
            end
        end
    end
else
    for i = padding + 1:height - padding
        for j = padding + 1:width - padding
            if input(i, j) ~= 0
                key = getILBPCode(input(i-padding:i+padding, j-padding:j+padding), parameter.ILBPNeighborhoodDimension);
                ILBPCodes(i, j) = key;
            end
        end
    end
end

fprintf('Counting texture codes...\n');
for i = 1:height
    for j = 1:width
        key = ILBPCodes(i, j);
        if key ~= 0
            textureDescriptor(key) = textureDescriptor(key) + 1;
        end
    end
end

end

