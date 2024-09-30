clear;
clc;

L = [3 4 5];
%training 3 times with different Ls
feature3 = training(L(1));
feature4 = training(L(2));
feature5 = training(L(3));
%plot
subplot(3, 1, 1);
plot(feature3);
title("features from L=3");
subplot(3, 1, 2);
plot(feature4);
title("features from L=4");
subplot(3, 1, 3);
plot(feature5);
title("features from L=5");




