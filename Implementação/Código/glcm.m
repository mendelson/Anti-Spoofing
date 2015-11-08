offset = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, -1; -1, 1];

input = getInputImage;
input2 = rot90(getInputImage);

varglcm = graycomatrix(input, 'NumLevels', 256, 'Offset', offset);
varglcm2 = graycomatrix(input2, 'NumLevels', 256, 'Offset', offset);

stats = graycoprops(varglcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
stats2 = graycoprops(varglcm2, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});

mean(stats.Contrast)
mean(stats2.Contrast)
