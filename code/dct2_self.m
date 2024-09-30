%the dect2 written by myself
function res = dct2_self(in)
    %the size of the two mats    
    [N1, N2] = size(in);
    row1 = (0: N1 - 1)';
    col1 = 1: 2: 2 * N1 - 1;
    %the left matrix
    D1 = cos(row1 * col1 * pi / (2*N1));
    D1(1,:) = sqrt(1/2) * ones(1,N1);
    row2 = (0: N2 - 1)';
    col2 = 1: 2: 2 * N2 - 1;
    %the right matrix
    D2 = cos(row2 * col2 * pi / (2*N2));
    D2(1,:) = sqrt(1/2) * ones(1,N2);
    %left multi and right multi
    res = sqrt(4/N1/N2) * D1 * in * D2';
end