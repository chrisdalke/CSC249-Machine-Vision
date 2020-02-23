%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------
% Performs Gaussian Blur filter
% on an image, and saves the result to
% a file.
%--------------------------------------

function resultImage = GaussianFilter(inputImage, imageName)

    % Perform basic gaussian blur
    gaussianFilter = fspecial('gaussian',[3 3],1);
    resultImage = filter2(gaussianFilter,inputImage);
    
    % Perform separable gaussian blur
    gaussianH = fspecial('gaussian',[1 3],1);
    gaussianV = fspecial('gaussian',[3 1],1);
    resultImageSeparable = filter2(gaussianH,inputImage);
    resultImageSeparable = filter2(gaussianV,resultImageSeparable);

    % Save results of both
    imwrite(uint8(resultImage),['Outputs/filters/' imageName '_gaussian.png']);
    imwrite(uint8(resultImageSeparable),['Outputs/filters/' imageName '_gaussian_separable.png']);
    freqz2(gaussianFilter,[32 32]); axis tight;
    saveas(gcf,['Outputs/freq/gaussian_freq.png']);

end

%--------------------------------------
% End of Module
%--------------------------------------