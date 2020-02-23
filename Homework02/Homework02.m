%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------

% Temporarily turn off figure window since we aren't displaying, only
% saving the results
set(0,'DefaultFigureVisible','off');
figure;

% Load the input image
I = imread('Inputs/Shapes-blurred.png');

% Convert the input image to a black and white threshold image
% I determined 60 to be the perfect threshold value for this image.
% This will save the file to 'Outputs/threshold.png'
fprintf('(1/5) Getting threshold image and saving...');
thresholdImage = GetImageThreshold(I,60);
fprintf('Done.\n');

% Run the Connected Components algorithm, which will return an image
% labelled with a unique pixel value for each connected component
% This will save two files to 'Outputs/pass1.png' and 'Outputs/pass2.png'
fprintf('(2/5) Getting connected components and saving...');
componentImage = GetConnectedComponents(thresholdImage);
fprintf('Done.\n');

% Find and delete all the components with area <10 pixels.
% This will save the file to 'Outputs/removeSmallRegions.png'
fprintf('(3/5) Deleting small regions and saving...');
componentImage = DeleteSmallRegions(componentImage,10);
fprintf('Done.\n');

% Find and delete all the components that have aspect ratio over 3:1
% This will save the file to 'Outputs/removeSkinnyRegions.png'
fprintf('(4/5) Deleting skinny regions and saving...');
componentImage = DeleteSkinnyRegions(componentImage);
fprintf('Done.\n');

% Find and label the heart shape.
% This will save the file to 'Outputs/final.png'
fprintf('(5/5) Detecting heart and saving...');
finalImage = DetectHeart(componentImage);
fprintf('Done.\n');

% Reset figure visibility
set(0,'DefaultFigureVisible','on');

%--------------------------------------
% End of Module
%--------------------------------------