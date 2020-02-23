%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------

function Part2(inputImage,imageName)
    colormap('gray');
    colorbar('off');

    fprintf(['  (1/4) Running Gaussian Filter for image ' imageName '...']);
    gaussianFilteredImage = GaussianFilter(inputImage, imageName);
    fprintf('Done.\n');
    
    fprintf(['  (2/4) Running High Pass Filter for image ' imageName '...']);
    highPassFilteredImage = HighPassFilter(inputImage, imageName);
    fprintf('Done.\n');

    fprintf(['  (3/4) Running Median Filter for image ' imageName '...']);
    medianFilteredImage = MedianFilter(inputImage, imageName);
    fprintf('Done.\n');
    
    fprintf(['  (4/4) Running Sobel Edge Filter for image ' imageName '...']);
    sobelFilteredImage = SobelEdgeFilter(inputImage, imageName);
    fprintf('Done.\n');
    
end

%--------------------------------------
% End of Module
%--------------------------------------