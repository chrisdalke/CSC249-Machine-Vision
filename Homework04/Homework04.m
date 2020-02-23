%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------

% Temporarily turn off figure window since we aren't displaying, only
% saving the results
set(0,'DefaultFigureVisible','off');
figure;

fprintf('(1/4) Loading source image...');
% Load the input image
I = imread('Inputs/inputImage.png');
fprintf('Done.\n');

fprintf('(2/4) Running High Pass filter...');
% Perform edge detection on the image
I_outline = HighPassFilter(I);
fprintf('Done.\n');

fprintf('(3/4) Computing Hough Transform...');
% Perform hough transform on the image
I_hough = HoughTransform(I_outline);
imagesc(I_hough);
saveas(gcf,'Outputs/2_hough.png');
fprintf('Done.\n');

fprintf('(4/4) Applying Median Filter to transform image...');
I_hough_median = MedianFilter(I_hough);
imagesc(I_hough_median);
saveas(gcf,'Outputs/3_median.png');
fprintf('Done.\n');

% Selected maxima:
maxima = {[0,115],[0,124],[0,134],[0,157],...
    [45,165],[45,169],[135,115],[135,83],[150,123],...
    [90,155],[90,163],[45,141],[90,128]};

fprintf('(5/4) Plotting selected maxima on top of original image...');

imagesc(I_hough);
[height,width,~] = size(I_hough);
[heightImg,widthImg,~] = size(I_outline);
offset = (widthImg + heightImg);

for i = 1:numel(maxima)
    point = maxima{i};
	viscircles([point(1), point(2)], 1,'Color','b');
end

saveas(gcf,'Outputs/4_lines.png');

imagesc(I_outline);
hold on

for i = 1:numel(maxima)
    point = maxima{i};
    x = point(1);
    y = point(2);
    
    % 0 is up, 180 is completely down
    theta = (pi - degtorad(x - 1)) - (pi/2);
    theta_tangent = (pi - degtorad(x - 1));
    
    rho = y - offset;
    
    px = -cos(theta_tangent) * rho;
    py = sin(theta_tangent) * rho;
	%viscircles([px, py], 1,'Color','b');

    %fprintf('\ntheta: %d rho: %d',theta, rho);

    slope = -sin(theta) /  cos(theta);

    xx = -100:widthImg;
    
    % y - y1 = m(x - x1);
    % y = m ( x - x1) + y1;
    
    yy = slope * (xx - px) + py;
    
    plot(xx, yy,'Color','r','LineWidth',1)

end
saveas(gcf,'Outputs/5_extra.png');
hold off

fprintf('Done.\n');

% Reset figure visibility
set(0,'DefaultFigureVisible','on');

%--------------------------------------
% End of Module
%--------------------------------------