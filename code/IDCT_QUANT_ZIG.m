%iZigzag, deQuantify and iDCT to blocks
function B = IDCT_QUANT_ZIG(A, row, col)
    load("source/JpegCoeff.mat");
    para = 1;
    %iZigzag
    block_x = col / 8;    
    block_y = row / 8;
    blocks = cell(block_y, block_x);
    for temp1 = 1 : block_y
        for temp2 = 1 : block_x
            %the idx of the vector using now
            start_idx = ((temp1-1) *(block_x) + temp2 - 1) * 64 + 1;
            end_idx = start_idx + 63;
            current_block = A(start_idx:end_idx);
            blocks{temp1,temp2} = izigzag(current_block);
        end
    end
    
    %dequantify then idct2
    for temp1 = 1 : block_y
        for temp2 = 1 : block_x
            B{temp1, temp2} = idct2(blocks{temp1, temp2}.*(QTAB ./ para));
        end
    end
end


