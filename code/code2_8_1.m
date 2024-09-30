clear;
clc;

load("source/hall.mat");
load("source/JpegCoeff.mat");

image1 = hall_gray;%the image
[col1, row1] = size(image1);%size of the image

%sub 128
image1 = sub8(image1);
%split
block1 = split(image1);
%dct2
matrix_quantified = DCT_QUANT_ZIG(block1);
