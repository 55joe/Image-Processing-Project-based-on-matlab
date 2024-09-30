load("source/hall.mat");

image1 = hall_color;%create a copy
[col1, row1, channel1] = size(image1);%size of the image

imshow(image1);
hold on;

centre_x = row1 / 2;%find the centre and the radius of the circle
centre_y = col1 / 2;
r = min(centre_x,centre_y);

theta = 0:pi/20:2*pi;%plot a red circle on the image
x = centre_x + r*cos(theta);%the x coordinate of the circle
y = centre_y + r*sin(theta);%the y coordinate of the circle
plot(x,y,'r','LineWidth',2)
