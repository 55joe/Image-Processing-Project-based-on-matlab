%code into dc and ac paras, dc = B1, ac = B2, A is the input matrix after
%quantify and zigzag
function [B1 B2] = coding(A)
load("source/JpegCoeff.mat");
%1 dc
A1 = A(1, :);
A2 = [A1(1); (A1(1: end - 1) - A1(2: end))'];%diff
A3 = ceil(log2(abs(A2) + 1));%category
B1 = [];
for temp1 = 1 : length(A2)
    %1 the huff part of code
    row_huff = A3(temp1) + 1;
    col_huff = DCTAB(row_huff, 1) + 1;
	code_huff = DCTAB(row_huff, 2 : col_huff)';
    
    %2 the maglitude part of the code
    code_magn = dec2bin(abs(A2(temp1)))' - '0';
	if (A2(temp1) < 0)
		code_magn = ~code_magn;
    end%transfer to 1-bin
	B1 = [B1; code_huff; code_magn];
end

%2 ac
A4 = A(2: end, :);
ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]';
EOB = [1, 0, 1, 0]';
[row, col] = size(A4);
B2 = [];
for temp1 = 1 : col
    %counting zero
    zero_count = 0;
    for temp2 = 1 : row
        if (A4(temp2, temp1))
            %1 insert ZRL
            while (zero_count >= 16)
                B2 = [B2; ZRL];
                zero_count = zero_count - 16;
            end
            
            %2 insert the rest 0 and amplitude
            row1 = zero_count * 10 + ceil(log2(abs(A4(temp2, temp1)) + 1));%category
            col1 = ACTAB(row1, 3) + 3;
            code_zero = ACTAB(row1 , 4 : col1)';
            cond_ampt = dec2bin(abs(A4(temp2,temp1)))' - '0';
            if (A4(temp2, temp1) < 0)
                cond_ampt = ~cond_ampt;
            end%transfer to 1-bin
            B2 = [B2; code_zero; cond_ampt];
            zero_count = 0;
        else
            zero_count = zero_count + 1;
        end
    end
    %3 insert EOB
    B2 = [B2; EOB];
end	
end