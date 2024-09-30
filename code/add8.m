%add 8 to the matrix
function B = add8(A) 
    B = uint8(A + 128 * ones(size(A)));
end