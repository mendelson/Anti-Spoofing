classdef Utils
    
    properties
    end
    
    methods (Static)
        function imagesWithTitle
            close all;
            
            a = imread('../../Parte escrita/img/tank.jpg');
            b = imread('../../Parte escrita/img/tank_seg.jpg');
            %             c = imread('3.pgm');
            subplot(1, 2, 1), imshow(a);
            title('(a)');
            subplot(1, 2, 2), imshow(b);
            title('(b)');
            %             subplot(1, 3, 3), imshow(c);
            %             title('c)');
            
        end
        
        function segment
            close all;
            
            input = imread('../../Parte escrita/img/misc/7.1.08.tiff');
            
            figure, imshow(input);
            
            threshold = getThreshold(input);
            
            [height, width] = size(input);
            rawAOI = uint8(zeros(height, width));
            
            for i = 1:height
                for j = 1:width
                    if input(i, j) > threshold
                        rawAOI(i, j) = 0;
                    else
                        rawAOI(i, j) = 1;
                    end
                end
            end
            
            figure, imshow(input.*rawAOI);
            
        end
    end
    
end

