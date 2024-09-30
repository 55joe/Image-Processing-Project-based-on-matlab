clear;
clc;

load("source/hall.mat");
load("source/JpegCoeff.mat");

image1 = hall_gray;%the image
[row, col] = size(image1);%size of the image

%sub 128
image1 = sub8(image1);
%split
block1 = split(image1);
%dct2 quantify and zigzag into a matrix
matrix_quantified = DCT_QUANT_ZIG(block1);
%coding DC and AC
[DC AC] = coding(matrix_quantified);
save('result/jpegcodes.mat', 'DC', 'AC', 'row', 'col');
