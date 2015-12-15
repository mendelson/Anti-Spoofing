function [ netEvaluation ] = evaluateImage( inputPath )

fprintf('Evaluating image!\n\n');

prepareEnvironment;

load net/nnet.mat;

textureDescriptor = getImageTextureDescriptor(inputPath);

textureDescriptor = textureDescriptor';

netEvaluation = net(textureDescriptor);

end

