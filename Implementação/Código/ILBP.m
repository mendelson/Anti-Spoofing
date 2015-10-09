function [ textureDescriptor ] = ILBP( input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global parameter;

padding = (parameter.ILBPNeighborhoodDimension - 1)/2;

[height, width] = size(input);

textureDescriptor = containers.Map('KeyType', 'int64', 'ValueType', 'int64');

for i = padding + 1:height - padding
    for j = padding + 1:width - padding
        if input(i, j) ~= 0
            key = getILBPCode(input(i-padding:i+padding, j-padding:j+padding), parameter.ILBPNeighborhoodDimension); % Testei e consegui o mesmo valor do artigo. Parece que esta função já está certa
%             disp(key);
            
            if textureDescriptor.isKey(key)
                textureDescriptor(key) = textureDescriptor(key) + 1;
            else
                textureDescriptor(key) = 1;
            end
        end
    end
end

end

