%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in a labelled region image and
% finds which objects are hearts.
%--------------------------------------
% Function Definition
%--------------------------------------

function returnImage = DetectHeart(inputImage)
    %Draw existing regions
    DrawRegionLabels(inputImage);
    
    % Figure out which region is a heart and draw a new outline over it
    % I will use a hybrid of the following properties:
    % -Bounding box must be almost square
    % -Sample edge pixels in heart shape
    
    
    labelSet = GetImageLabels(inputImage);
    for label = labelSet
        boundingBox = FindBoundingBox(inputImage,label);
        isHeart = 1;
        
        ratio = boundingBox(3)/boundingBox(4);
        if (ratio > 1.2 || ratio < 0.8)
            isHeart = 0;
        end
        
        %Sample edges of the image to see if it is roughly a heart shape
        sampleFailRate = 0;
        
        % load the sample image
        sampleImage = imread('Inputs/heartSample.png');
        
        % The sample is hardcoded as an 9x9 image
        for x = 0:8
            for y = 0:8
                currentSampleX = round(boundingBox(1) + (x/8)*boundingBox(3));
                currentSampleY = round(boundingBox(2) + (y/8)*boundingBox(4));
                
                sampleSuccess = 0;
                if (sampleImage(y+1,x+1) == 0)
                    if (inputImage(currentSampleY,currentSampleX) == 0)
                        sampleSuccess = 1;
                    end
                else
                    if (inputImage(currentSampleY,currentSampleX) > 0)
                        sampleSuccess = 1;
                    end
                end
                
                if (sampleSuccess == 1) 
                    %rectangle('Position',[currentSampleX currentSampleY 0.1 0.1],'LineWidth',2,'EdgeColor','green');
                else
                    %rectangle('Position',[currentSampleX currentSampleY 0.1 0.1],'LineWidth',2,'EdgeColor','red');
                    sampleFailRate = sampleFailRate + 1;
                end
            end
        end
        
        % If more than 10 of the samples fail, it's probably not a heart.
        if (sampleFailRate > 10)
            isHeart = 0;
        end
        
        if isHeart == 1
            rectangle('Position',boundingBox,'LineWidth',2,'EdgeColor','red');
            text(boundingBox(1)+boundingBox(3)/2,boundingBox(2)+boundingBox(4)/2+3,'Heart','HorizontalAlignment','center','Color','red','BackgroundColor','black');
        end
    end
    
    saveas(gcf,'Outputs/7_detectHeart.png');
    
    returnImage = inputImage;
end

%--------------------------------------
% End of File
%--------------------------------------