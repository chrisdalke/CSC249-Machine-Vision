%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in an region image and label ID
% and finds the bounding box for that
% area.
%--------------------------------------
% Function Definition
%--------------------------------------

% Takes in an image and a label and finds the bounding box in the image.
% Returns this as a list with four elements.
function boundingBox = FindBoundingBox(inputImage,layer)
    [height,width,~] = size(inputImage);
    
    boundingBox = [height width 1 1];
    % Loop through the image and find the minimum top left position and
    % maximum bottom right position.
    hasOccurance = 0;
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) == layer)
                hasOccurance = 1;
                if (y < boundingBox(1))
                    boundingBox(1) = y;
                end
                if (x < boundingBox(2))
                    boundingBox(2) = x;
                end
                if (y > boundingBox(3))
                    boundingBox(3) = y;
                end
                if (x > boundingBox(4))
                    boundingBox(4) = x;
                end
                
            end
        end
    end
    
    if (hasOccurance == 1)
        % Transform bounding box to be a [x y w h] format
        boundingBox = [boundingBox(2) boundingBox(1) (boundingBox(4)-boundingBox(2)) (boundingBox(3)-boundingBox(1))];
    else
        boundingBox = [];
    end
end

%--------------------------------------
% End of File
%--------------------------------------