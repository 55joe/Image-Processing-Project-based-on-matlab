load("source/hall.mat");
load("source/JpegCoeff.mat");

image1 = hall_gray;%the image
[row, col] = size(image1);%size of the image

%hide the LSB
LSB_rand = randi([0, 1], row, col);
image1 = bitset(image1, 1, LSB_rand);

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

%compare the LSBs of the raw image and the decoded image
equal_num = 0;%the number of equal values
for temp1 = 1 : row
    for temp2 = 1 : col
        if(bitand(image2(temp1,temp2),1) == LSB_rand(temp1,temp2))
            equal_num = equal_num + 1;
        end
    end
end
total_num = row * col;
equal_rate = equal_num / total_num;%the rate of equal values

disp(equal_rate);


