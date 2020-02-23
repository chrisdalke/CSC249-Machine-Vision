function resultImage = HoughTransform(inputImage)
    % Create new, blank image to represent polar space
    % I'll set the resolution as follows:
    % y is r, x is theta
    % x resolution will be 360 degrees so 360px
    % y resolution will be width^2 + length^2 (longest possible dist)
    
    [height,width,~] = size(inputImage);
    
    xRes = 181;
    yRes = width + height + width + height;
    offset = (width + height);
    
    resultImage = zeros(yRes,xRes);
    
    % Loop through all the points (non-zero pixels)
    for x = 1:width
        for y = 1:height
            if (inputImage(y,x) > 0)
                for angle = 0:180
                    theta = degtorad(angle);
                    convertedPosY = (x * cos(theta) + y * sin(theta));
                    convertedPosY = round(max(1,min(convertedPosY + offset,yRes)));
                    resultImage(convertedPosY,angle + 1) = resultImage(convertedPosY,angle + 1) + 1;
                end
            end
        end
    end

end

