function [ netEvaluation ] = evaluateTextureFile( inputPath )

fprintf('Evaluating texture descriptor file!\n');

load net/nnet.mat;

texDescriptor = load(inputPath, 'textureDescriptor');
texDescriptor = texDescriptor.textureDescriptor;
texDescriptor = texDescriptor';

netEvaluation = net(texDescriptor);

end

