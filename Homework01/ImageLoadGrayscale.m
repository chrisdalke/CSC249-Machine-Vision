%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 01
%--------------------------------------
% ImageConvert takes in an input string
% ,loads the image, converts it to grayscale,
% and then saves the grayscale image.
%--------------------------------------
% Function Definitions
%--------------------------------------

function convertedImage = ImageLoadGrayscale(inputFilename)
    tempImage=imread(inputFilename);
    convertedImage = rgb2gray(tempImage);
    
    fprintf(['Converting ' inputFilename ' to grayscale...\n']);
end

%--------------------------------------
% End of Module
%--------------------------------------