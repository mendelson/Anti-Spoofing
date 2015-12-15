function [ normalizedTextureDescriptor ] = getTexture( input, aoiMask )

global parameter;

equalizedInput = histeq(input, 256);
equalizedAOI = uint8(aoiMask).*equalizedInput;

if parameter.showAOI
    aoi = uint8(aoiMask).*input;
    figure, imshow(aoi);
    title('AOI');
end

if parameter.showEqualizedAOI
    figure, imshow(equalizedAOI);
    title('Equalized AOI');
end;

textureDescriptor = ILBP(equalizedAOI);

sumOfElements = sum(textureDescriptor);

normalizedTextureDescriptor = textureDescriptor./sumOfElements;

if parameter.showTextureDescriptor
    figure, plot(textureDescriptor);
    title('Texture Descriptor');
end

if parameter.showNormalizedTextureDescriptor
    figure, plot(normalizedTextureDescriptor);
    title('Normalized Texture Descriptor');
end

glcm = getGLCM(equalizedAOI);
stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});

normalizedTextureDescriptor(end + 1) = mean(stats.Contrast);
normalizedTextureDescriptor(end + 1) = mean(stats.Correlation);
normalizedTextureDescriptor(end + 1) = mean(stats.Energy);
normalizedTextureDescriptor(end + 1) = mean(stats.Homogeneity);

end

