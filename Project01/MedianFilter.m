%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------
% Performs Median filter
% on an image, and saves the result to
% a file.
%--------------------------------------

function resultImage = MedianFilter(inputImage,imageName)
    resultImage = medfilt2(inputImage);
    imwrite(uint8(resultImage),['Outputs/filters/' imageName '_median.png']);
end

%--------------------------------------
% End of Module
%--------------------------------------