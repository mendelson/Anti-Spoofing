close all;
clear all;
clc;

%% Loading parameters into global workspace
loadParameters;

global parameter;

%% Enabling parallel processing
if parameter.useParallel
    if parameter.useSpecificPoolSize
        p = gcp('nocreate');

        if ~isempty(p) && p.NumWorkers ~= parameter.poolSize
            delete(gcp);
            parpool('local', parameter.poolSize);
        elseif isempty(p)
            parpool('local', parameter.poolSize);
        end
    end
else
    p = gcp('nocreate');
    
    if ~isempty(p)
        delete(gcp);
    end
end

%% Desabling image size warning
warning ('off', 'images:initSize:adjustingMag');

%% Opening input image
% input = imread('a.pgm');
% input = imread('1/SI-2_g20_2_10_0.pgm');
% input = imread('6/SI-6_g20_2_3_2.pgm');
% input = imread('13/SI-13_g12_2_3_0.pgm');
input = imread('15/SI-15_g63_2_2_1.pgm');
% input = imread('17/SI-17_g12_2_5_0.pgm');
% input = imread('19/SI-19_g12_2_1_2.pgm');

if parameter.showOriginalImage
    figure, imshow(input);
    title('Original image');
end

%% Getting AOI mask
aoiMask = getAOIMask(input);
aoi = uint8(aoiMask).*input;

if parameter.showAOI
    figure, imshow(aoi);
    title('AOI');
end

%% Evaluating AOI's shape
similarity = evaluateShape(aoi);

%% Getting image's texture
textureDescriptor = getTexture(aoi);

%% Exiting
fprintf('\nDONE!\n');