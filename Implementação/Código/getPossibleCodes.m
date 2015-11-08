function [ codes ] = getPossibleCodes( word, amountElements )

codes = zeros(1, amountElements);

for i = 1:amountElements
    for j = 1:amountElements
            codes(i) = codes(i) + (word(amountElements + 1 - j)*(2^(j - 1)));
    end
    
    word = (circshift(word, [0 1]));
end

end

