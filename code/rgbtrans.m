%pic to rgb to total N
function N = rgbtrans(image, L, row1, col1)
    Red = floor(image(row1, col1, 1) * 2 ^ (L - 8));
    Gre = floor(image(row1, col1, 2) * 2 ^ (L - 8));
    Blu = floor(image(row1, col1, 3) * 2 ^ (L - 8));
    N = Red * 2 ^ (2 * L) + Gre * 2 ^ L + Blu;%the total num
end