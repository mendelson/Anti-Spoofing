All samples acquired from the sensor must be placed into the 'Samples' folder identified by a unique sequencial number.

In order to use this code, you must have your samples at Implementação/Samples/

To make all samples available to the code, run the script 'setupInputImages.m'.
To generate all the texture descriptors, run the script 'generateTextureDescriptors.m'
To train the neural network, run the script 'trainNN.m'
To obtain the metrics reported at the paper, run the script 'generateMetrics.m'
To evaluate a specific image or a specific texture descriptor file, call the function 'evaluateAcquisition'