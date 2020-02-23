function outputImage = KMeansClustering(inputImage,kValue,regions)

    %Each pixel is represented as a 6d vector as follows
    % [r, g, b, x, y, cluster]
    % Add all the pixels of the original image into the pixelValues array
    [height,width,~] = size(inputImage);
    pixelValues = cell(height,width);
    for x = 1:width
        for y = 1:height
            pixelValues{y,x} = [double(inputImage(y,x,1)) double(inputImage(y,x,2)) double(inputImage(y,x,3)) x y 0];
        end
    end
    
    iterationCount = 0;
    while iterationCount <= 30
        iterationCount = iterationCount + 1;

        % Assignment step: Assign every pixel to a region based on which
        % centroid it is closest to
        for x = 1:width
            for y = 1:height
                x1 = pixelValues{y,x}(1);
                y1 = pixelValues{y,x}(2);
                z1 = pixelValues{y,x}(3);
                x2 = regions{1}(1);
                y2 = regions{1}(2);
                z2 = regions{1}(3);
                centroidDist = EuclideanDistance3d(x1,y1,z1,x2,y2,z2);
                centroidId = 1;
                for region = 1:kValue
                    x2 = regions{region}(1);
                    y2 = regions{region}(2);
                    z2 = regions{region}(3);
                    tempDist = EuclideanDistance3d(x1,y1,z1,x2,y2,z2);
                    if (tempDist < centroidDist)
                        centroidDist = tempDist;
                        centroidId = region;
                    end
                end
                
                %Save the current centroid that the pixel is in
                pixelValues{y,x}(6) = centroidId;
            end
        end
        
        % Update step: Recalculate the center of the region based on the
        % pixels that are assigned to that region
        % As we proceed through this, calculate change in region positions
        regionsOld = regions;
        for region = 1:kValue
            
            meanValueX = 0;
            meanValueY = 0;
            meanValueZ = 0;
            numPixels = 0;
            for x = 1:width
                for y = 1:height
                    if (pixelValues{x,y}(6) == region)
                        meanValueX = meanValueX + pixelValues{x,y}(1);
                        meanValueY = meanValueY + pixelValues{x,y}(2);
                        meanValueZ = meanValueZ + pixelValues{x,y}(3);
                        numPixels = numPixels + 1;
                    end
                end
            end
            if (numPixels > 0)
                regions{region}(1) = meanValueX / numPixels;
                regions{region}(1) = meanValueY / numPixels;
                regions{region}(1) = meanValueZ / numPixels;
            end
            
        end
        
        % Check if the sum of the changes in the centroid positions is less
        % than a certain threshold.
        sumCentroidChanges = 0;
        for region = 1:kValue
            regionChangeX = abs(regions{region}(1) - regionsOld{region}(1));
            regionChangeY = abs(regions{region}(2) - regionsOld{region}(2));
            regionChangeZ = abs(regions{region}(3) - regionsOld{region}(3));
            regionChange = EuclideanDistance3d(0,0,0,regionChangeX,regionChangeY,regionChangeZ);
            sumCentroidChanges = sumCentroidChanges + regionChange;
        end
        if (sumCentroidChanges > 0.01)
            iterationCount = 31; % Exit the loop
        end
    end
    
    % Reconstruct a new image based on the pixel values we've saved
    outputImage = zeros(height,width);
    
    for x = 1:width
        for y = 1:height
            % Write label Image
            %outputImage(y,x) = pixelValues{y,x}()
            outputImage(y,x) = pixelValues{y,x}(6);
        end
    end
   
end

