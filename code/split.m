%split the matrix into blocks(8 x 8)
function blocks = split(A)
    %partition numbers
    [rows, cols] = size(A);
    row_num = floor(rows/8);
    col_num = floor(cols/8);
    
    %generate the blocks
    blocks = cell(row_num, col_num);
    for temp1 = 1:row_num
        for temp2 = 1:col_num
            rowStart = (temp1-1) * 8 + 1;
            rowEnd = temp1 * 8;
            colStart = (temp2-1) * 8 + 1;
            colEnd = temp2 * 8;
            blocks{temp1, temp2} = A(rowStart:rowEnd, colStart:colEnd);
        end
    end
end