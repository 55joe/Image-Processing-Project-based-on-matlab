load("source/hall.mat");

[row1, col1] = size(hall_gray);
image1 = hall_gray(row1 /8 + 1 : 7 * row1 / 8, col1 /8  + 1 : 7 * col1 / 8);%a part of the image
[col2, row2] = size(image1);%size of the image

%sub 128 then dct 
image2 = double(image1) - 128 * ones(size(image1));
image2_dct = dct2(image2);
image2 = idct2(image2_dct);

%dct then "sub 128"
image1_dct = dct2(image1);
image1_dct = image1_dct - dct2(128 * ones(size(image1)));
image1 = idct2(image1_dct);

%compute the similarity
mse = sum((image1-image2) .^2, 'all') / (col2*row2);

%show the images
image1 = uint8(double(image1) + 128 * ones(size(image1)));
image2 = uint8(double(image2) + 128 * ones(size(image2)));

figure;
subplot(1, 2, 1);
imshow(image2);
title("dct after sub image","FontSize",20);
subplot(1, 2, 2);
imshow(image1);
title("sub after dct image","FontSize",20);