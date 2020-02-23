%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------
% High Pass Filter: Performs custom
% High Pass filter on an image, and
% saves the result to a file.
%--------------------------------------

function resultImage = HighPassFilter(inputImage)

    [width,height,~] = size(inputImage);

    highPassFilter = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    resultImage = zeros(height,width);
    
    for y = 1:height
        for x = 1:width
            % compute sum of surrounding values
            pixelSum = 0;
            % Top left
            yy = max(min(y-1,height),1);
            xx = max(min(x-1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(1,1);
            % Top center
            yy = max(min(y-1,height),1);
            xx = max(min(x, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(1,2);
            % Top right
            yy = max(min(y,height),1);
            xx = max(min(x-1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(1,3);
            % Center left
            yy = max(min(y,height),1);
            xx = max(min(x-1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(2,1);
            % Center center
            yy = max(min(y,height),1);
            xx = max(min(x, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(2,2);
            % Center right
            yy = max(min(y,height),1);
            xx = max(min(x+1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(2,3);
            % Bottom left
            yy = max(min(y+1,height),1);
            xx = max(min(x-1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(3,1);
            % Bottom center
            yy = max(min(y+1,height),1);
            xx = max(min(x, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(3,2);
            % Bottom right
            yy = max(min(y+1,height),1);
            xx = max(min(x+1, width),1);
            pixelSum = pixelSum + double(inputImage(yy,xx)) * highPassFilter(3,3);
            
            resultImage(y,x) = min(max(pixelSum,0),255);
        end
    end
    
    % Clamp, convert, save result to file
    imwrite(uint8(resultImage),'Outputs/1_highpass.png');

end

%--------------------------------------
% End of Module
%--------------------------------------