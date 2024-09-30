clear;
clc;

test_image1 = imread("source/test1.jpg");
%L = 3
%find the face area
L = 3;
trained_feature = training(L);
blocksize = 20;
threshold = 0.4;
image_detect = detect(test_image1, blocksize, trained_feature, threshold, L);
%mark the found area
m = blocksize*3;
n = blocksize*3;
x = 1;
image_mark = mark(test_image1, image_detect, m, n, x, blocksize);
%plot it
figure;
imshow(image_mark);
title("from L=3");

%L = 4
%find the face area
L = 4;
trained_feature = training(L);
blocksize = 20;
threshold = 0.7;
image_detect = detect(test_image1, blocksize, trained_feature, threshold, L);
%mark the found area
m = blocksize*3;
n = blocksize*3;
x = 1;
image_mark = mark(test_image1, image_detect, m, n, x, blocksize);
%plot it
figure;
imshow(image_mark);
title("from L=4");

%L = 5
%find the face area
L = 5;
trained_feature = training(L);
blocksize = 20;
threshold = 0.8;
image_detect = detect(test_image1, blocksize, trained_feature, threshold, L);
%mark the found area
m = blocksize*3;
n = blocksize*3;
x = 1;
image_mark = mark(test_image1, image_detect, m, n, x, blocksize);
%plot it
figure;
imshow(image_mark);
title("from L=5");