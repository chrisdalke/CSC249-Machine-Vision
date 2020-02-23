%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------

% Temporarily turn off figure window since we aren't displaying, only
% saving the results. Also, reset the figure to default.
set(0,'DefaultFigureVisible','off');
figure;

% Load images
fprintf('Loading Images...');
image01 = imread('Inputs/image01.png');
image02 = imread('Inputs/image02.png');
fprintf('Done.\n');

% Execute Part 1 
fprintf('Executing Part 1...');
Part1(image01,'1'); 
Part1(image02,'2');
fprintf('Done.\n');   

% Execute Part 2
fprintf('Executing Part 2...\n');
Part2(image01,'1');
Part2(image02,'2');

% Add Gaussian noise to images and repeat steps
imageGaussianNoise01 = imnoise(image01,'gaussian');
imageGaussianNoise02 = imnoise(image02,'gaussian');
% Display the noise images and save to file
imwrite(imageGaussianNoise01,'Outputs/filters/1_gnoise.png');
imwrite(imageGaussianNoise02,'Outputs/filters/2_gnoise.png');
% Run Part 2 again on noise images
Part2(imageGaussianNoise01,'1_gnoise');
Part2(imageGaussianNoise02,'2_gnoise');

% Add Impulse noise to images and repeat steps
imageGaussianNoise01 = imnoise(image01,'salt & pepper');
imageGaussianNoise02 = imnoise(image02,'salt & pepper');
% Display the noise images and save to file
imwrite(imageGaussianNoise01,'Outputs/filters/1_inoise.png');
imwrite(imageGaussianNoise02,'Outputs/filters/2_ifnoise.png');
% Run Part 2 again on noise images
Part2(imageGaussianNoise01,'1_inoise');
Part2(imageGaussianNoise02,'2_inoise');
fprintf('Done.\n');

% Execute Part 3
fprintf('Executing Part 3...');
Part3(image01,'1');
Part3(image02,'2');
fprintf('Done.\n')

% Reset figure visibility
set(0,'DefaultFigureVisible','on');

%--------------------------------------
% End of Module
%--------------------------------------