%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 03
%--------------------------------------

% Temporarily turn off figure window since we aren't displaying, only
% saving the results. Also, reset the figure to default.
set(0,'DefaultFigureVisible','off');
figure;

% Load images
fprintf('Loading Images...');
image01 = imread('Inputs/PeppersRGB.tif');
image01_RGB = image01;
image01_LST = RGBtoLST(image01);
image01_HSV = rgb2hsv(image01);
fprintf('Done.\n');

% Execute Part 1
fprintf('Executing K-Means Clustering...\n');

fprintf('(1/3) RGB Feature Vector...\n');
RGBCentroids = {[0,0,0],[255,100,100],[100,255,100]};
resultImageRGB = KMeansClustering(image01_RGB,3,RGBCentroids);
imagesc(resultImageRGB);
saveas(gcf,'Outputs/outputRGB.png');

fprintf('(2/3) LST Feature Vector...\n');
LSTCentroids = {[0,0,0],[80,128,0],[80,0,128]};
resultImageLST = KMeansClustering(image01_LST,3,LSTCentroids);
imagesc(resultImageLST);
saveas(gcf,'Outputs/outputLST.png');

fprintf('(3/3) HSV Feature Vector...\n');
HSVCentroids = {[0,0.5,0.0],[0,0.5,1.0],[0.3,0.5,1.0]};
resultImageHSV = KMeansClustering(image01_HSV,3,HSVCentroids);
imagesc(resultImageHSV);
saveas(gcf,'Outputs/outputHSV.png');

fprintf('Done.\n');   

% Reset figure visibility
set(0,'DefaultFigureVisible','on');

%--------------------------------------
% End of Module
%--------------------------------------