load("source/hall.mat");

image1 = hall_color;%create a copy
[col1, row1, channel1] = size(image1);%size of the image

for i = 1 : 8%find the row and column to rewrite: 8x8
    for j = 1 : 8
        if(mod((i + j),2))%color black in an area
            image1(1+col1/8*(j-1):col1/8*j,1+row1/8*(i-1):row1/8*i,1) = 0;
            image1(1+col1/8*(j-1):col1/8*j,1+row1/8*(i-1):row1/8*i,2) = 0;
            image1(1+col1/8*(j-1):col1/8*j,1+row1/8*(i-1):row1/8*i,3) = 0;
        end
    end
end

imshow(image1);