%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 01
%--------------------------------------

% Temporarily turn off figure window since we aren't displaying, only
% saving the results
set(0,'DefaultFigureVisible','off');

% Load our test images as grayscale images
image01 = ImageLoadGrayscale('Inputs/image01.png');
image02 = ImageLoadGrayscale('Inputs/image02.png');

% Save the resulting images to the output folder
imwrite(image01,'Outputs/image01_gray.png');
imwrite(image02,'Outputs/image02_gray.png');

% Generate and save a histogram of the images to the output folder.
ImageSaveHistogram(image01,'Outputs/image01_gray_histogram.png');
ImageSaveHistogram(image02,'Outputs/image02_gray_histogram.png');

% Make zoomed regions from the grey images based on regions I have picked.
image01_zoomed = ImageRegion(image01,0.4963,0.3831,0.5326,0.40318);
image02_zoomed = ImageRegion(image02,0.54779,0.4955,0.59027,0.5184);

% Save the zoomed regions to the output folder.
imwrite(image01_zoomed,'Outputs/image01_zoomed.png');
imwrite(image02_zoomed,'Outputs/image02_zoomed.png');

% Make histograms of the zoomed versions.
ImageSaveHistogram(image01_zoomed,'Outputs/image01_zoomed_histogram.png');
ImageSaveHistogram(image02_zoomed,'Outputs/image02_zoomed_histogram.png');

fprintf('Done.\n');

% Reset figure visibility
set(0,'DefaultFigureVisible','on');

%--------------------------------------
% End of Module
%--------------------------------------