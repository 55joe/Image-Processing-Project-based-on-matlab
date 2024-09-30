clear;
clc;

load("source/snow.mat");
load("source/JpegCoeff.mat");

image1 = snow;%the image
[row, col] = size(image1);%size of the image

%sub 128
image1 = sub8(image1);
%split
block1 = split(image1);
%dct2 quantify and zigzag into a matrix
matrix_quantified = DCT_QUANT_ZIG(block1);
%coding DC and AC
[DC, AC] = coding(matrix_quantified);

%decoding the JPEG
matrix_decoded = decoding(DC, AC, row, col);
%iZigzag, deQuantify and iDCT into blocks
block2 = IDCT_QUANT_ZIG(matrix_decoded, row, col);
%reconstruct
image2 = reconstruct(block2);
%add 128 and transfer to uint8
image2 = add8(image2);

%calculate the PSNR
MSE = sum((double(snow) - double(image2)) .^ 2, 'all') / (row * col);
PSNR = 10 * log10(255^2 / MSE);
compressing_rate = row * col * 8 / (length(DC) + length(AC));

%show the two images
figure;
subplot(1, 2, 2);
imshow(image2);
title("decoded","FontSize",20);
subplot(1, 2, 1);
imshow(snow);
title("raw","FontSize",20);