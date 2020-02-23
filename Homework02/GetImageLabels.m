%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in an region image and 
% returns a list of the labels.
%--------------------------------------
% Function Definition
%--------------------------------------

function labelSet = GetImageLabels(inputImage)

    [height,width,~] = size(inputImage);
    
    colors = [];
    
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) > 0)
                colors = unique([colors inputImage(y,x)]);
            end
        end
    end
    
    labelSet = colors;
end

%--------------------------------------
% End of File
%--------------------------------------