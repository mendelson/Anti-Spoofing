function [ aoi ] = getAOIMask( input )

global parameter;

%% Pre processing
fprintf('Smoothing image...\n');
smoothedInput = preProc(input);

%% Defining threshold
fprintf('\nComputing global threshold...');
threshold = getThreshold(smoothedInput);
fprintf('\nGlobal threshold: %f\n', threshold);

%% Defining AOI (area of interest) mask
fprintf('\nSearching for AOI...\n');
[height, width] = size(input);
rawAOI = uint8(zeros(height, width));

if parameter.useParallel
    parfor i = 1:height
        for j = 1:width
            if smoothedInput(i, j) > threshold
                rawAOI(i, j) = 1;
            else
                rawAOI(i, j) = 0;
            end
        end
    end
else
    for i = 1:height
        for j = 1:width
            if smoothedInput(i, j) > threshold
                rawAOI(i, j) = 1;
            else
                rawAOI(i, j) = 0;
            end
        end
    end
end

if parameter.showRawAOIMask
    figure, imshow(255*rawAOI);
    title('Raw AOI Mask');
end

%% Improving AOI mask with quantization
fprintf('\nQuantizing AOI...\n');
aoi = quantAOI(rawAOI);

if parameter.showAOIMask
    figure, imshow(255*aoi);
    title('Improved AOI Mask');
end

end

