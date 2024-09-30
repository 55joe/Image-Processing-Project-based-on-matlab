clear;
clc;

load("source/hall.mat");
load("result/jpegcodes.mat");

%decoding the JPEG
matrix_decoded = decoding(DC, AC, row, col);
%iZigzag, deQuantify and iDCT into blocks
block2 = IDCT_QUANT_ZIG(matrix_decoded, row, col);
%reconstruct
image2 = reconstruct(block2);
%add 128 and transfer to uint8
image2 = add8(image2);

%calculate the PSNR
MSE = sum((double(hall_gray) - double(image2)) .^ 2, 'all') / (row * col);
PSNR = 10 * log10(255^2 / MSE);

%show the two images
figure;
subplot(1, 2, 2);
imshow(image2);
title("decoded","FontSize",20);
subplot(1, 2, 1);
imshow(hall_gray);
title("raw","FontSize",20);
