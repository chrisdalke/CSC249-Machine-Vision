%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% ImageThreshold takes in an input
% image and a threshold number and 
% returns a new B/W image with those thresholds.
%--------------------------------------
% Function Definitions
%--------------------------------------

function convertedImage = GetImageThreshold(inputImage,threshold)
    [height,width,~] = size(inputImage);
    blankImage = zeros(width,height);
    
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) >= threshold)
                blankImage(y,x) = 1;
            else
                blankImage(y,x) = 0;
            end
        end
    end
    
    % Save the threshold image to a file
    imagesc(blankImage);
    saveas(gcf,'Outputs/1_threshold.png');
    
    convertedImage = blankImage;
end

%--------------------------------------
% End of Module
%--------------------------------------