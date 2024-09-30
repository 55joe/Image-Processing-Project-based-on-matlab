close all;
clear;
clc;

load("source/hall.mat");

image1 = hall_gray;%create a copy

image1 = double(image1) - 128 .* ones(size(image1));
dct10 = dct2(image1);
dct20 = dct2_self(image1);%using the self-written dct2

[col row] = size(dct10);
mse = sum((dct10-dct20) .^2, 'all') / (col*row);%get the difference

