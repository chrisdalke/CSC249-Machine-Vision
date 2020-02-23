%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 01
%--------------------------------------
% Takes an input image and a region
% and crops the region. Converts the 
% coordinates from proportions to absolute
% pixel coordinates.
%--------------------------------------
% Function Definitions
%--------------------------------------

function result = ImageRegion(inputImage, x1,y1,x2,y2)
    fprintf(['Creating cropped image...\n']);
    [width,height,~] = size(inputImage);
    %fprintf(['image size: ' width height ]);
    x = round(width*x1);
    y = round(height*y1);
    w = round(width*(x2-x1));
    h = round(height*(y2-y1));
    result = imcrop(inputImage,[x y w h]);
end

%--------------------------------------
% End of Module
%--------------------------------------