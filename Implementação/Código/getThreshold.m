function [ threshold ] = getThreshold( input )

global parameter;

[height, width] = size(input);

threshold = mean2(input);
previousThreshold = threshold + parameter.thresholdPrecision;

while abs(previousThreshold - threshold) >= parameter.thresholdPrecision
    previousThreshold = threshold;
    
    set1 = [];
    set2 = [];
    positionSet1 = 1;
    positionSet2 = 1;
    
    for i = 1:height
        for j = 1:width
            pixel = input(i, j);
            if pixel > threshold
                set1(positionSet1) = pixel;
                positionSet1 = positionSet1 + 1;
            else
                set2(positionSet2) = pixel;
                positionSet2 = positionSet2 + 1;
            end
        end
    end
    
    avg1 = mean(set1);
    avg2 = mean(set2);
    
    threshold = (avg1 + avg2)/2;
end

end

