%version 3.3
function B = DCT_QUANT_ZIG3(A, rand_data)
    para = 1;
    load("source/JpegCoeff.mat");
    [num_row, num_col] = size(A);
    block_dct = cell(num_row, num_col);
    
    %dct2 then quantify
    for temp1 = 1 : num_row
        for temp2 = 1 : num_col
            block_dct{temp1, temp2} = round(dct2(A{temp1, temp2})./(QTAB ./ para));
        end
    end
    
    %zigzag then matrix
    [num_row1, num_col1] = size(block_dct);
    num_mat1 = num_row1 * num_col1;
    B = zeros(8^2, num_mat1);%output matrix
    temp3 = 1;%the wrting column
    index_writing = 1;
    for temp1 = 1 : num_row1
        for temp2 = 1 : num_col1
            currentmatrix = block_dct{temp1, temp2};
            currentvector = zigzag(currentmatrix);%zigzag into a vector
            for temp4 = 64 : -1 : 1
                if(currentvector(temp4))%find the last no-zero value
                    if(temp4 == 64)%write in
                        currentvector(temp4) = rand_data(index_writing);
                    else
                        currentvector(temp4 + 1) = rand_data(index_writing);
                    end
                    index_writing = index_writing + 1;
                    break;
                end
            end%write back
            B(:, temp3) = currentvector;
            temp3 = temp3 + 1;
        end
    end

end