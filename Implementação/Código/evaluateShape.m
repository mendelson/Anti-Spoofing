function [ similarityIndex ] = evaluateShape( input )
%This function evaluates how similar the shape of the input image is to the
%shape of a finger.
%   TODO: define possible values to be returned and their meanings.



fprintf('\nRunning Hough...\n');

% [centers, radii, metric] = imfindcircles(input,[35 300]);
% 
% centersStrong5 = centers(1:5,:);
% radiiStrong5 = radii(1:5);
% metricStrong5 = metric(1:5);
% 
% viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

%%

% hedge = vision.EdgeDetector;
% hhoughtrans = vision.HoughTransform(pi/360,'ThetaRhoOutputPort', true);
% hfindmax = vision.LocalMaximaFinder(1,	'HoughMatrixInput', true);
% hhoughlines = vision.HoughLines('SineComputation','Trigonometric function');
% 
% BW = step(hedge, input);
% [ht, theta, rho] = step(hhoughtrans, BW);
% idx = step(hfindmax, ht);
% linepts = step(hhoughlines, theta(idx(1)-1), rho(idx(2)-1), input);
% 
% imshow(input); hold on;
% line(linepts([1 3])-1, linepts([2 4])-1,'color',[1 1 0]);


similarityIndex = 0.5;

end

