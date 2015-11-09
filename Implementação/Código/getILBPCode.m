function [ ILBPCode ] = getILBPCode( input, dimension )

amountElements = dimension^2;

inputVector = reshape(input.', [1 amountElements]);

% word = getILBPBinaryWord(inputVector, amountElements);
word = getILBPBinaryWord_(double(inputVector), amountElements);

% codes = getPossibleCodes(word, amountElements);
codes = getPossibleCodes_(double(word), amountElements);

ILBPCode = min(codes);

end