%--------------------------------------
% Chris Dalke
% CSC 249 - Project 01
%--------------------------------------

function Part3(inputImage,imageName)
    colormap(jet);
    colorbar;

    % Run FFT on the image, display without log
    fftResult = fft2(double(inputImage),256,256);
    fftImage = abs(fftResult);
    % Display magnitude and save result
    imagesc(fftImage);
    saveas(gcf,['Outputs/fft/' imageName '_fft.png']);
    % Shift fft and save result
    fftImage = abs(fftshift(fftResult));
    imagesc(fftImage);
    saveas(gcf,['Outputs/fft/' imageName '_fft_shifted.png']);
    

    % Run FFT on the image, display with log
    fftResult = fft2(double(inputImage),256,256);
    fftImage = log(abs(fftResult));
    % Display magnitude and save result
    imagesc(fftImage);
    saveas(gcf,['Outputs/fft/' imageName '_fft_log.png']);
    % Shift fft and save result
    fftImage = log(abs(fftshift(fftResult)));
    imagesc(fftImage);
    saveas(gcf,['Outputs/fft/' imageName '_fft_log_shifted.png']);
end

%--------------------------------------
% End of Module
%--------------------------------------