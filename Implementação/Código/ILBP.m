function [ textureDescriptor ] = ILBP( input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global parameter;

padding = (parameter.ILBPNeighborhoodDimension - 1)/2;

[height, width] = size(input);

textureDescriptor = containers.Map('KeyType', 'int64', 'ValueType', 'int64');

ILBPCodes = zeros(height, width);

fprintf('\nCalculating texture codes...\n');
if parameter.useParallel
    parfor i = padding + 1:height - padding
        for j = padding + 1:width - padding
            if input(i, j) ~= 0
                key = getILBPCode(input(i-padding:i+padding, j-padding:j+padding), parameter.ILBPNeighborhoodDimension, parameter.useParallel); % Testei e consegui o mesmo valor do artigo. Parece que esta função já está certa

                ILBPCodes(i, j) = key;
            end
        end
    end
else
    for i = padding + 1:height - padding
        for j = padding + 1:width - padding
            if input(i, j) ~= 0
                key = getILBPCode(input(i-padding:i+padding, j-padding:j+padding), parameter.ILBPNeighborhoodDimension, parameter.useParallel); % Testei e consegui o mesmo valor do artigo. Parece que esta função já está certa

                ILBPCodes(i, j) = key;
            end
        end
    end
end

fprintf('Counting texture codes...\n');
for i = 1:height
    for j = 1:width
        key = ILBPCodes(i, j);
        if textureDescriptor.isKey(key)
           textureDescriptor(key) = textureDescriptor(key) + 1;
        else
           textureDescriptor(key) = 1;
        end
    end
end

if parameter.showTextureDescriptor    
    ILBPCodes = (ILBPCodes*255)./max(max(ILBPCodes));
    
    figure, imshow(ILBPCodes);
    title('Texture Descriptor');
end

end

