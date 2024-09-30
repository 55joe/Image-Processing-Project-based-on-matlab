%version 3.3
function B = IDCT_QUANT_ZIG3(A, row, col)
    load("source/JpegCoeff.mat");
    para = 1;
    %iZigzag
    block_x = col / 8;    
    block_y = row / 8;
    blocks = cell(block_y, block_x);
    index_writing = 1;
    for temp1 = 1 : block_y
        for temp2 = 1 : block_x
            %the idx of the vector using now
            start_idx = ((temp1-1) *(block_x) + temp2 - 1) * 64 + 1;
            end_idx = start_idx + 63;
            current_block = A(start_idx:end_idx);
            for temp3 = 64 : -1 : 1%find the last no-zero value
                if(current_block(temp3))
                    B(index_writing) = current_block(temp3);%write back
                    index_writing = index_writing + 1;
                    break;
                end
            end
        end
    end
end


