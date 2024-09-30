clear;
clc;

load("source/hall.mat");

[row1, col1] = size(hall_gray);
image1 = hall_gray(row1 /8 + 1 : 7 * row1 / 8, col1 /8 + 1 : 7 * col1 / 8);%a part of the image
[col1, row1] = size(image1);%size of the image

%prepare work
image1 = sub8(image1);
block1 = split(image1);

%save the changing parts
[num_row, num_col] = size(block1);
block_dct = cell(num_row, num_col);
block2 = cell(num_row, num_col);
block3 = cell(num_row, num_col);

%change the dct parts
for temp1 = 1:num_row
    for temp2 = 1:num_col
        currentblock = block1{temp1, temp2};
        block_dct{temp1, temp2} = dct2(currentblock);
        
        %rightside 4s -> zeros
        block_dct2 = block_dct{temp1, temp2};
        block_dct2(:,end-3:end) = 0;
        block2{temp1, temp2} = idct2(block_dct2);
        
        %leftside 4s -> zeros
        block_dct3 = block_dct{temp1, temp2};
        block_dct3(:,1:4) = 0;
        block3{temp1, temp2} = idct2(block_dct3);
    end
end

%plus 128 and back to uint8
image2 = reconstruct(block2);
image3 = reconstruct(block3);

image1 = add8(image1);
image2 = add8(image2);
image3 = add8(image3);

%show
figure;
subplot(1,3,1);
imshow(image1);
title("raw picture","FontSize",20);
subplot(1,3,2);
imshow(image2);
title("rightmost 4 columns->zero","FontSize",20);
subplot(1,3,3);
imshow(image3);
title("leftmost 4 columns->zero","FontSize",20);


