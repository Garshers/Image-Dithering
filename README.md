# Image Processing Scripts

This repository contains MATLAB scripts for performing various image processing tasks, including binarization and color quantization.

## Tasks Performed

1.  **OTSU Binarization and Floyd-Steinberg Dithering:**
    * Applies OTSU thresholding to convert grayscale images to binary images.
    * Implements Floyd-Steinberg dithering to improve the visual quality of binarized images.
    * Calculates and reports Peak Signal-to-Noise Ratio (PSNR) and Structural Similarity Index (SSIM) for both binarization methods.
2.  **Color Image Quantization:**
    * Quantizes color images to a specified number of colors, with and without dithering.
    * Generates quantized images with different color palettes.
    * Calculates and reports PSNR and SSIM for the quantized images.

## Scripts

* `process_images.m`: Main script that executes all image processing tasks.
* `binarize_image.m`: Function for performing OTSU binarization and Floyd-Steinberg dithering.
* `floyd_steinberg_dithering.m`: Function implementing the Floyd-Steinberg dithering algorithm.
* `quantize_color_image.m`: Function for quantizing color images.

## Input Images

The scripts expect the following input images in the same directory:

* `lena_gray.png`
* `o2_gray.png`
* `lena_rgb.png`
* `O2_rgb.png`

## Output Images

The scripts will generate the following output images:

* `Lena_otsu.png`, `O2_otsu.png`: OTSU binarized images.
* `Lena_otsu_dithering.png`, `O2_otsu_dithering.png`: OTSU binarized images with Floyd-Steinberg dithering.
* `Lena_rgb_16_colors_nodither.png`, `Lena_rgb_256_colors_nodither.png`: Quantized color images (16 and 256 colors) without dithering.
* `O2_rgb_16_colors_nodither.png`, `O2_rgb_256_colors_nodither.png`: Quantized color images (16 and 256 colors) without dithering.
* `Lena_rgb_16_colors_dither.png`, `Lena_rgb_256_colors_dither.png`: Quantized color images (16 and 256 colors) with dithering.
* `O2_rgb_16_colors_dither.png`, `O2_rgb_256_colors_dither.png`: Quantized color images (16 and 256 colors) with dithering.

## Usage

1.  Ensure you have MATLAB installed.
2.  Place the scripts and input images in the same directory.
3.  Open MATLAB and navigate to the directory.
4.  Run the `process_images()` function in the MATLAB command window.
5.  The output images and performance metrics will be generated.

## Performance Metrics

The scripts calculate and display the following performance metrics:

* **PSNR (Peak Signal-to-Noise Ratio):** Measures the quality of the processed images compared to the original images.
* **SSIM (Structural Similarity Index):** Measures the perceived change in structural information between the processed and original images.

The PSNR and SSIM values are printed to the MATLAB command window for each processed image.