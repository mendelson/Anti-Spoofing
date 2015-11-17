function [ netEvaluation ] = evaluateTextureFile( inputPath )

fprintf('Evaluating texture descriptor file!\n');

load net/nnet.mat;

load(inputPath);
textureDescriptor = textureDescriptor';

netEvaluation = net(textureDescriptor);

end

