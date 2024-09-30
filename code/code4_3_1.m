clear;
clc;

test_image1 = imread("source/test1.jpg");

test_image2 = imrotate(test_image1, -90);
test_image3 = imresize(test_image1, [size(test_image1, 1), 2 * size(test_image1, 2)]);
test_image4 = imadjust(test_image1, [.13, .88]);

%find the face area
L = 5;
trained_feature = training(L);
blocksize = 20;
threshold = 0.8;
image_detect2 = detect(test_image2, blocksize, trained_feature, threshold, L);
image_detect3 = detect(test_image3, blocksize, trained_feature, threshold, L);
image_detect4 = detect(test_image4, blocksize, trained_feature, threshold, L);
%mark the found area
m = blocksize*3;
n = blocksize*3;
x = 1;
image_mark2 = mark(test_image2, image_detect2, m, n, x, blocksize);
image_mark3 = mark(test_image3, image_detect3, m, n, x, blocksize);
image_mark4 = mark(test_image4, image_detect4, m, n, x, blocksize);
%plot it
figure;
imshow(image_mark2);
title("change 1");
figure;
imshow(image_mark3);
title("change 2");
figure;
imshow(image_mark4);
title("change 3");
