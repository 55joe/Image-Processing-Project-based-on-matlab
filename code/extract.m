%extract feature from one image
function B = extract(A, L)
    A = double(A);
    [row, col, ~] = size(A);
    B = zeros(1, 2 ^ (3 * L));%freq mat
    for temp1 = 1 : row
       for temp2 = 1 : col
           N = rgbtrans(A, L, temp1, temp2);%find the frequency
           B(N + 1) = B(N + 1) + 1;%add the frequency 
       end
    end
    B = B / (row * col);
end