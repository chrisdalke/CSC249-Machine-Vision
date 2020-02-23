function convertedImage = RGBtoLST(inputImage)
    %Create output image of equivalent size using LST format
   
    [height,width,~] = size(inputImage);
    convertedImage = zeros(height,width,3);
    
    for x = 1:width
        for y = 1:height
            r = double(inputImage(y,x,1));
            g = double(inputImage(y,x,2));
            b = double(inputImage(y,x,3));
            convertedImage(y,x,1) = (r+g+b)/3;
            convertedImage(y,x,2) = (r-b)/2;
            convertedImage(y,x,3) = ((2*g)-r-b)/4;
        end
    end
end

