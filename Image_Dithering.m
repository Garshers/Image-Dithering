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
    threshold_level = graythresh(gray_image);
    binary_image_otsu = imbinarize(gray_image, threshold_level);

    % Save binary images
    imwrite(uint8(binary_image_otsu * 255), sprintf('%s_otsu.png', image_name));

    
    % Calculate PSNR and SSIM
    psnr_otsu = psnr(uint8(binary_image_otsu * 255), gray_image);
    ssim_otsu = ssim(uint8(binary_image_otsu * 255), gray_image);
end

process_images();