%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in a region image and
% deletes regions with an aspect ratio
% above 3:1
%--------------------------------------
% Function Definition
%--------------------------------------

function returnImage = DeleteSkinnyRegions(inputImage)

    [height,width,~] = size(inputImage);
    
    numLabels = GetImageLabels(inputImage);
    for n = numLabels
        boundingBox = FindBoundingBox(inputImage,n);
        if ~(isempty(boundingBox))
            % Examine aspect ratio and delete if below a certain ratio
            if (boundingBox(3)/boundingBox(4) > 3)
                %Delete all of these labels from image
                for x = 1:width
                    for y = 1:height
                        if (inputImage(y,x) == n)
                            inputImage(y,x) = 0;
                        end
                    end
                end
            end
        end
    end
    
    % Render image
    DrawRegionLabels(inputImage);
    imwrite(inputImage,'Outputs/inputImage.png');
    saveas(gcf,'Outputs/6_removeSkinnyRegions.png');
    
    returnImage = inputImage;
end

%--------------------------------------
% End of File
%--------------------------------------