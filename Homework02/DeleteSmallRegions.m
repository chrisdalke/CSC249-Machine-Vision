%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in a region image and
% deletes regions below a minimum size.
%--------------------------------------
% Function Definition
%--------------------------------------

function returnImage = DeleteSmallRegions(inputImage,minSize)
    %Loop through each label and delete the label if it has less than the
    %minimum required number of pixels
    
    numLabels = GetImageNumLabels(inputImage);
    
    % Count occurances of each label
    occuranceArray = zeros(1,numLabels);
    [height,width,~] = size(inputImage);
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) > 0)
                occuranceArray(inputImage(y,x)) = occuranceArray(inputImage(y,x)) + 1;
            end
        end
    end
    
    % Delete labelled areas that aren't big enough
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) > 0)
                if (occuranceArray(inputImage(y,x)) < minSize)
                    inputImage(y,x) = 0;
                end
            end
        end
    end
    
    DrawRegionLabels(inputImage);
    saveas(gcf,'Outputs/5_removeSmallRegions.png');
    
    returnImage = inputImage;
end

%--------------------------------------
% End of File
%--------------------------------------