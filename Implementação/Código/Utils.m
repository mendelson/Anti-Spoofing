classdef Utils
    
    properties
    end
    
    methods (Static)
        function imagesWithTitle
            a = imread('1.pgm');
            b = imread('2.pgm');
            c = imread('3.pgm');
            subplot(1, 3, 1), imshow(a);
            title('a)');
            subplot(1, 3, 2), imshow(b);
            title('b)');
            subplot(1, 3, 3), imshow(c);
            title('c)');
            
        end
        
    end
    
end

