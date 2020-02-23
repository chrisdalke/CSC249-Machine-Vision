%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 01
%--------------------------------------
% Takes an input image and converts
% it to a histogram, saving the result.
%--------------------------------------
% Function Definitions
%--------------------------------------

function ImageSaveHistogram(inputImage, outputFilename)
    fprintf(['Creating histogram and outputting to ' outputFilename '...\n']);

    %tempHistogram = histogram(inputImage);
    %xlabel('Grayscale Color Value (0-255)')
    %ylabel('Pixels of Color');
    imhist(inputImage);
    
    saveas(gcf, outputFilename);
end

%--------------------------------------
% End of Module
%--------------------------------------