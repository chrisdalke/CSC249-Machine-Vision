%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------
% Sobel Filter: Performs sobel filter
% on an image, and saves the result to
% a file.
%--------------------------------------

function resultImage = SobelEdgeFilter(inputImage, imageName)

    sobelFilter = fspecial('sobel');
    resultImage = filter2(sobelFilter,inputImage);
    
    imagesc(resultImage);
    saveas(gcf,['Outputs/filters/' imageName '_sobel.png']);
    freqz2(sobelFilter,[32 32]); axis tight;
    saveas(gcf,['Outputs/freq/sobel_freq.png']);
end

%--------------------------------------
% End of Module
%--------------------------------------