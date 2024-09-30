clear;
clc;

load("source/hall.mat");
load("source/JpegCoeff.mat");

%the prepare stage:
image1 = hall_gray;%the image
[row, col] = size(image1);%size of the image

%sub 128
image1 = sub8(image1);
%split
block1 = split(image1);
%generate the information
rawdata = randi([0, 1], row, col);
rand_data = split(rawdata);


%the hiding and unhiding stage:
%dct2 quantify and zigzag into a matrix
%coding DC and AC
%decoding the JPEG
%iZigzag, deQuantify and iDCT into blocks

%version 1
hide1 = DCT_QUANT_ZIG1(block1, rand_data);
[DC1, AC1] = coding(hide1);
decode1 = decoding(DC1, AC1, row, col);

recover1 = IDCT_QUANT_ZIG1(decode1, row, col);
recover1 = reconstruct(recover1);%the LSB of the decoded image in time

unhide1 = IDCT_QUANT_ZIG(decode1, row, col);
unhide1 = reconstruct(unhide1);
unhide1 = add8(unhide1);

%version 2
hide2 = DCT_QUANT_ZIG2(block1, rand_data);
[DC2, AC2] = coding(hide2);
decode2 = decoding(DC2, AC2, row, col);

recover2 = IDCT_QUANT_ZIG1(decode2, row, col);
recover2 = reconstruct(recover2);%the LSB of the decoded image in time

unhide2 = IDCT_QUANT_ZIG(decode2, row, col);
unhide2 = reconstruct(unhide2);
unhide2 = add8(unhide2);

%version 3
rawdata_2 = randi([0, 1], 1, row*col);  
rawdata_2(rawdata_2 == 0) = -1;

hide3 = DCT_QUANT_ZIG3(block1, rawdata_2);
[DC3, AC3] = coding(hide3);
decode3 = decoding(DC3, AC3, row, col);

recover3 = IDCT_QUANT_ZIG3(decode3, row, col);%the LSB of the decoded image in time

unhide3 = IDCT_QUANT_ZIG(decode3, row, col);
unhide3 = reconstruct(unhide3);
unhide3 = add8(unhide3);


%the output stage:
%compare the LSBs of the raw image and the decoded image
equal_num1 = 0;
for temp1 = 1 : row
    for temp2 = 1 : col
        if(recover1(temp1,temp2) == rawdata(temp1,temp2))
            equal_num1 = equal_num1 + 1;
        end
    end
end
total_num1 = row * col;
equal_rate1 = equal_num1 / total_num1;

equal_num2 = 0;
for temp1 = 1 : row
    temp2 = col;
    if(recover1(temp1,temp2) == rawdata(temp1,temp2))
        equal_num2 = equal_num2 + 1;
    end
end
total_num2 = row;
equal_rate2 = equal_num2 / total_num2;

equal_num3 = 0;
for temp1 = 1 : length(recover3)
    if(recover3(temp1) == rawdata_2(temp1))
        equal_num3 = equal_num3 + 1;
    end
end
total_num3 = length(recover3);
equal_rate3 = equal_num3 / total_num3;

%compute the PSNR and compressing rate
image1 = add8(image1);
MSE1 = sum((double(unhide1) - double(image1)) .^ 2, 'all') / (row * col);
PSNR1 = 10 * log10(255^2 / MSE1);
compressing_rate1 = row * col * 8 / (length(DC1) + length(AC1));

MSE2 = sum((double(unhide2) - double(image1)) .^ 2, 'all') / (row * col);
PSNR2 = 10 * log10(255^2 / MSE2);
compressing_rate2 = row * col * 8 / (length(DC2) + length(AC2));

MSE3 = sum((double(unhide3) - double(image1)) .^ 2, 'all') / (row * col);
PSNR3 = 10 * log10(255^2 / MSE3);
compressing_rate3 = row * col * 8 / (length(DC3) + length(AC3));

figure;
subplot(2,2,1);
imshow(image1);
title("raw","FontSize",20);
subplot(2,2,2);
imshow(unhide1);
title("method1","FontSize",20);
subplot(2,2,3);
imshow(unhide2);
title("method2","FontSize",20);
subplot(2,2,4);
imshow(unhide3);
title("method3","FontSize",20);


