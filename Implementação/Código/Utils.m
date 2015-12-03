classdef Utils
    %% Don't use this class. It has been created just to provide a faster
    %% way to generate and save the results for the paper.
    
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
        
        function quantize
            close all;
            
            prepareEnvironment
            
            input = imread('../../Parte escrita/img/misc/7.1.08.tiff');
            
            figure, imshow(input);
            
%             figure, imshow(getAOIMask(input));
            mask = getAOIMask(input);
            figure, imshow(uint8(mask).*input);
            
            for i = 1:50
                mask = quantAOI(mask);
            end
            
            figure, imshow(uint8(mask).*input);
        end
        
        function gray
            close all;
            
            input = imread('../../Parte escrita/img/lena_cortada.jpg');
            
            input = rgb2gray(input);
            
            subplot(2, 3, 1), imshow(input);
            title('(a)');
            
            input = Utils.downL(input, 4);
            
            subplot(2, 3, 2), imshow(input);
            title('(b)');
            
            input = Utils.downL(input, 3);
            
            subplot(2, 3, 3), imshow(input);
            title('(c)');
            
            input = Utils.downL(input, 2);
            
            subplot(2, 3, 4), imshow(input);
            title('(d)');
            
            input = Utils.downL(input, 1);
            
            subplot(2, 3, 5), imshow(input);
            title('(e)');
        end
        
        function [ newImage ] = downL( image, bits )
            L = 2.^bits;
            
            newScale = Utils.getScale(L);
            
            newImage = zeros(size(image, 1), size(image, 2));
            
            for i = 1:size(image, 1)
                for j = 1:size(image, 2)
                    newImage(i, j) = newScale(image(i, j) + 1);
                end
            end
            
            newImage = uint8(newImage);
            
        end
        
        function [ transformationVector ] = getScale( L )
            transformationVector = zeros(256);
            
            indexOffset = 255/(L-1);
            
            for i = 1:indexOffset:(256 - indexOffset)
                initial = i;
                final = initial + indexOffset;
                half_way = (initial + final - 1)/2;
                transformationVector(initial:half_way) = initial - 1;
                transformationVector((half_way + 1):final) = final - 1;
            end
            
        end
        
        function vader
            close all;
            
            a = imread('../../Parte escrita/img/originais/vader_side_original.jpg');
            figure, imshow(a);
            
            a = rgb2gray(a);
            figure, imshow(a);
            
            b = histeq(a);
            figure, imshow(b);
        end
        
        function monotonic
            close all;

            x = linspace(0, 1, 1000000);
            y = 0.5 + 4*(x - 0.5).^3;
            
            figure, plot(x, y, 'LineWidth', 2);
            xlabel({'Níveis de cinza', '(0 \leq r \leq 1)'}, 'FontSize', 14);
            ylabel({'T(r) = (1 + 8*(x - 0.5)^3/2', '(0 \leq s \leq 1)'}, 'FontSize', 14);
            
        end
        
        function descriptor
            close all;
            
            prepareEnvironment;
            
            input = imread('../../Parte escrita/img/textures/1.1.13.tiff');
            
%             input = rgb2gray(input);
            
            figure, imshow(input);
            
            textureDescriptor = ILBP(input);
            
            sumOfElements = sum(textureDescriptor);
            
            normalizedTextureDescriptor = textureDescriptor./sumOfElements;
            
            figure, plot(normalizedTextureDescriptor);
            
        end
        
        function glcm
            close all;
            
            input = imread('../../Parte escrita/img/textures/1.1.13.tiff');
            
            offset = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, -1; -1, 1];
            glcm = graycomatrix(input, 'NumLevels', 256, 'Offset', offset);
            
            stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
            
            fprintf('Contrast: %f\nCorrelation: %f\nEnergy: %f\nHomogeneity: %f\n', mean(stats.Contrast), mean(stats.Correlation), mean(stats.Energy), mean(stats.Homogeneity));
            
        end
        
        function go
            close all;
            clear all;
            clc;
            
%             profile on;
            evaluateAcquisition('../../Parte escrita/img/originais/SI-2_g15_2_2_1.pgm');
%             evaluateAcquisition('input/5/SI-5_g63_2_1_0.pgm');
%             evaluateAcquisition('input/6/SI-6_g20_2_7_0.pgm');
%             evaluateAcquisition('input/7/SI-7_g20_2_10_1.pgm');
%             profile off;
%             profile viewer;
        end
        
        function plotSigmoid
            close all;
            
            x = -2:0.1:10;
            y = sigmf(x,[2 4]);
            plot(x,y)
%             xlabel('sigmf, P = [2 4]')
            ylim([-0.05 1.05])
        end
        
        function plotStep
            close all;
            
            syms x
            ezplot(heaviside(x), [-10, 10])
        end
        
        function plotTanSig
            close all;
            
            n = -5:0.1:5;
            a = tansig(n);
            plot(n,a)
        end
        
        function plotPurelin
            close all;
            
            n = -5:0.1:5;
            a = purelin(n);
            plot(n,a)
        end
        
        function plotNN
            close all;
            clear all;
            clc;
            
            load net/nnet1.mat;
            
            plot(localTargets(tr.testInd), net(localInput(:, tr.testInd)), 'ro')
            xlabel('Expected')
            ylabel('Predicted')
            grid on
            
            [netTestOutputs ; localTargets(tr.testInd)]'
        end
        
    end
    
end

