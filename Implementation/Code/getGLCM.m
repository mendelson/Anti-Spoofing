function [ glcm ] = getGLCM( input )

offset = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, -1; -1, 1];

fprintf('\nCalculating GLCM...\n');
glcm = graycomatrix(input, 'NumLevels', 256, 'Offset', offset);

end

