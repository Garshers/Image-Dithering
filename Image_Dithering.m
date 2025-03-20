function process_images()
    % Task 1: OTSU binarization and Floyd-Steinberg dithering
    lena_gray = imread('lena_gray.png');
    o2_gray = imread('o2_gray.png');
    
    binarize_image(lena_gray, 'Lena');
    binarize_image(o2_gray, 'O2');

    % Task 2: Color image quantization
    lena_color = imread('lena_rgb.png');
    o3_color = imread('O2_rgb.png');
    quantize_color_image(lena_color, 'Lena_rgb', [16, 256]);
    quantize_color_image(o3_color, 'O2_rgb', [16, 256]);
end

function binarize_image(gray_image, image_name)
    % OTSU binarization
    threshold_level = 0.5; %graythresh(gray_image);
    binary_image_otsu = imbinarize(gray_image, threshold_level);

    % Floyd-Steinberg dithering
    binary_image_dithering = floyd_steinberg_dithering(gray_image, threshold_level);

    % Save binary images
    imwrite(uint8(binary_image_otsu * 255), sprintf('%s_otsu.png', image_name));
    imwrite(uint8(binary_image_dithering * 255), sprintf('%s_otsu_dithering.png', image_name));
    
    % Calculate PSNR and SSIM
    psnr_otsu = psnr(uint8(binary_image_otsu * 255), gray_image);
    psnr_dithering = psnr(uint8(binary_image_dithering * 255), gray_image);
    ssim_otsu = ssim(uint8(binary_image_otsu * 255), gray_image);
    ssim_dithering = ssim(uint8(binary_image_dithering * 255), gray_image);
    
    fprintf('Binarization: %s\n OTSU PSNR: %.2f dB, OTSU+FS PSNR: %.2f dB\n OTSU SSIM: %.4f,  OTSU+FS SSIM: %.4f\n', image_name, psnr_otsu, psnr_dithering, ssim_otsu, ssim_dithering);
end

function dithered_image = floyd_steinberg_dithering(gray_image, threshold_level)
    % Convert the grayscale image to double and normalize it to the range [0, 1]
    gray_image = double(gray_image) / 255; 
    
    % Get the height and width of the image
    [height, width] = size(gray_image);
    
    % Initialize the dithered image with the original grayscale values
    dithered_image = gray_image;
    
    % Iterate over each pixel in the image
    for y = 1:height
        for x = 1:width
            % Get the current pixel value
            old_pixel = dithered_image(y, x);
            
            % Round the pixel value to perform binarization (0 or 1)
            new_pixel = round(old_pixel); 
            
            % Set the current pixel in the dithered image to the binarized value
            dithered_image(y, x) = new_pixel;
            
            % Calculate the quantization error
            error = old_pixel - new_pixel;
            
            % Propagate the error to neighboring pixels using Floyd-Steinberg weights
            if x < width
                dithered_image(y, x+1) = dithered_image(y, x+1) + error * 7/16; % right pixel
            end
            if x > 1 && y < height
                dithered_image(y+1, x-1) = dithered_image(y+1, x-1) + error * 3/16; % bottom-left pixel
            end
            if y < height
                dithered_image(y+1, x) = dithered_image(y+1, x) + error * 5/16; % bottom pixel
            end
            if x < width && y < height
                dithered_image(y+1, x+1) = dithered_image(y+1, x+1) + error * 1/16; % bottom-right pixel
            end
        end
    end
    
    % Apply the threshold to convert the dithered image to a binary image
    dithered_image = dithered_image > threshold_level; 
end

function quantize_color_image(color_image, image_name, num_colors_list)
    for i = 1:length(num_colors_list)
        num_colors = num_colors_list(i);

        % Quantization without dithering
        [quantized_image_nodither, map_nodither] = rgb2ind(color_image, num_colors, 'nodither');
        quantized_nodither_rgb = ind2rgb(quantized_image_nodither, map_nodither);
        imwrite(quantized_nodither_rgb, sprintf('%s_%d_colors_nodither.png', image_name, num_colors));
        
        % Quantization with dithering
        [quantized_image_dither, map_dither] = rgb2ind(color_image, num_colors, 'dither');
        quantized_dither_rgb = ind2rgb(quantized_image_dither, map_dither);
        imwrite(quantized_dither_rgb, sprintf('%s_%d_colors_dither.png', image_name, num_colors));
        
        % Calculate PSNR and SSIM
        psnr_nodither = psnr(uint8(quantized_nodither_rgb * 255), color_image);
        psnr_dither = psnr(uint8(quantized_dither_rgb * 255), color_image);
        ssim_nodither = ssim(uint8(quantized_nodither_rgb * 255), color_image);
        ssim_dither = ssim(uint8(quantized_dither_rgb * 255), color_image);
        
        fprintf('Quantization: %s, %d colors\n No Dither PSNR: %.2f dB, Dither PSNR: %.2f dB\n No Dither SSIM: %.4f,   Dither SSIM: %.4f\n', image_name, num_colors, psnr_nodither, psnr_dither, ssim_nodither, ssim_dither);
    end
end

process_images();
