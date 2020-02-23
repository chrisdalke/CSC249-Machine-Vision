%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------

function Part1(inputImage,imageName)
    % Display image using imshow, and save.
    imshow(inputImage);
    colormap('gray');
    colorbar('off');
    saveas(gcf,['Outputs/images/' imageName '_default.png']);
    
    % Display image using imagesc, and save.
    imagesc(inputImage);
    colormap('default');
    colorbar;
    saveas(gcf,['Outputs/images/' imageName '_colorbar.png']);
    
    % Choose a different colormap / colorbar and save.
    imagesc(inputImage);
    colormap(cool);
    colorbar;
    saveas(gcf,['Outputs/images/' imageName '_colormap.png']);

    colorbar('off');
    colormap('default');

end

%--------------------------------------
% End of Module
%--------------------------------------