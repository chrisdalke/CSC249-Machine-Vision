%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in an region image and 
% returns the number of labels in the image.
%--------------------------------------
% Function Definition
%--------------------------------------

% Gets the number of distinct labels (pixel values) in an image
function numLabels = GetImageNumLabels(inputImage)
    numLabels = numel(GetImageLabels(inputImage));
end

%--------------------------------------
% End of File
%--------------------------------------