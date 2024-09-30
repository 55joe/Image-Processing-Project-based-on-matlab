%sub 8 to the matrix
function B = sub8(A) 
    B = double(A) - 128 .* ones(size(A));
end