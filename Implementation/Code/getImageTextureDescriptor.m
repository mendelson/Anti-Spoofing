function [ textureDescriptor ] = getImageTextureDescriptor( inputPath )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IF YOU DON'T WANT TO USE FUNCTIONS WRITEN IN C++, PLEASE, COMENT THE %
% CALL TO FUNCTIONS TERMINATED WITH AN UNDERSCORE ("_") AND UNCOMENT   %
% THE CALL FOR THE MATLAB FUNCTIONS (THEY SHOULD BE ON THE LINE ABOVE).%
% ALSO, CHANGE THE VALUE OF 'Parameters.useMEXFiles' to 'false'.       %
%                                                                      %
% CURRENTLY, THEY ARE CALLED FROM: getILBPCode AND quantAOI            %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global parameter;

%% Opening input image
input = getInputImage(inputPath);

if parameter.showOriginalImage
    figure, imshow(input);
    title('Original image');
end

%% Getting AOI mask
aoiMask = getAOIMask(input);

%% Getting image's texture
textureDescriptor = getTexture(input, aoiMask);

fprintf('\nTexture Calculations DONE!\n');
end

