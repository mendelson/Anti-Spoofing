function [ word ] = getILBPBinaryWord( input, amountElements )

word = zeros(1, amountElements);

avg = mean(input);

for i = 1:amountElements
    if input(i) < avg
        word(i) = 0;
    else
        word(i) = 1;
    end
end

end

