%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in a region image and
% draws outlines and label text on it.
%--------------------------------------
% Function Definition
%--------------------------------------

function DrawRegionLabels(inputImage)

    imagesc(inputImage);

    % draw bounding boxes and labels for all the regions
    numLabels = GetImageLabels(inputImage);
    for n = numLabels
        boundingBox = FindBoundingBox(inputImage,n);
        if ~(isempty(boundingBox))
            rectangle('Position',boundingBox,'LineWidth',2,'EdgeColor','black');
            text(boundingBox(1)+boundingBox(3)/2,boundingBox(2)+boundingBox(4)/2,['Region ' num2str(n)],'HorizontalAlignment','center','Color','w','BackgroundColor','black');
        end
    end
end

%--------------------------------------
% End of File
%--------------------------------------