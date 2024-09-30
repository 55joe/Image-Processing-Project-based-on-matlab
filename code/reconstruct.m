%reconstruct the blocks to matrix
function A = reconstruct(blocks)
    %reconstruct numbers
    [row_num, col_num] = size(blocks);
    
    %generate the matrix
    A = zeros(row_num * 8, col_num * 8);
    for temp1 = 1:row_num
        for temp2 = 1:col_num
            rowStart = (temp1-1) * 8 + 1;
            rowEnd = temp1 * 8;
            colStart = (temp2-1) * 8 + 1;
            colEnd = temp2 * 8;
            A(rowStart:rowEnd, colStart:colEnd) = blocks{temp1, temp2};
        end
    end
end