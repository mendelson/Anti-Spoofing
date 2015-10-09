function [ threshold ] = getThreshold( input )
%getThreshold computes the global threshold for an image
%   This function computes the global threshold for an image

global parameter;

[height, width] = size(input);

threshold = mean2(input);
previousThreshold = threshold + parameter.thresholdPrecision;

while abs(previousThreshold - threshold) >= parameter.thresholdPrecision
    previousThreshold = threshold;
    
    set1 = [];
    set2 = [];
    
    for i = 1:height
        for j = 1:width
            pixel = input(i, j);
            if pixel > threshold
                set1(end + 1) = pixel;
            else
                set2(end + 1) = pixel;
            end
        end
    end
    
    avg1 = mean(set1);
    avg2 = mean(set2);
    
    threshold = (avg1 + avg2)/2;
end

end

