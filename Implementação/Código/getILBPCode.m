function [ ILBPCode ] = getILBPCode( input, dimension )

amountElements = dimension^2;

input = reshape(input.', [1 amountElements]);

% word = getILBPBinaryWord(input, amountElements);
word = getILBPBinaryWord_(input, amountElements);

% codes = getPossibleCodes(word, amountElements);
codes = getPossibleCodes_(word, amountElements);

ILBPCode = min(codes);

end