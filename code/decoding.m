%decode the JPEG, input DC and AC stream, output the zigzag quantified
%matrix
function B = decoding(DC, AC, row, col)
load("source/JpegCoeff.mat");
%decoding DC
delta = zeros([row * col/ 64, 1]);%the diff from n1 and n2
index_search = 1;
index_insert = 1;
temp1 = 2;
while temp1 <= length(DC)
    for temp2 = 1 : size(DCTAB, 1)
        %comparing to the huff code
        col1 =  DCTAB(temp2, 1) + 1;
        code_now = DC(index_search : temp1)';
        code_huff = DCTAB(temp2, 2 : col1);
        flag = 0;
        if(length(code_now) == length(code_huff))
            flag = 1;
            for temp3 = 1 : length(code_huff)
                if(code_now(temp3) ~= code_huff(temp3)) 
                    flag = 0;
                    break;
                end
            end
        end
        %if equal, then using huff to find the dleta value
        if (flag)
            if(temp2 == 1)
                temp1 = temp1 + 1;
            else
                num_magl = DC(temp1 + 1: temp1 + temp2 - 1)';
                %find the original value
                if (num_magl(1))
                    num_magl = char(num_magl + '0');
                    delta(index_insert) = bin2dec(num_magl);
                else%less than 0
                    num_magl = char(~num_magl + '0');
                    delta(index_insert) = -bin2dec(num_magl);
                end
            end
            index_search = temp1 + temp2;
            index_insert = index_insert + 1;
            temp1 = temp1 + temp2;
            break;
        end
    end
    temp1 = temp1 + 1;
end
B1 = zeros(size(delta));
B1(1) = delta(1);
%de-diff
for temp1 = 1 : size(B1, 1) - 1
    B1(temp1+1) = B1(temp1) - delta(temp1+1);
end

%decoding AC
B2 = zeros([63, row * col / 64]);
temp1 = 2;
index_search = 1;
ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]';
EOB = [1, 0, 1, 0]';
row_now = 1;
col_now = 1;
while temp1 <= length(AC)
    code_now = AC(index_search: temp1);
    flag1 = 0;
    flag2 = 0;
    %find EOB
    if (length(code_now) == length(EOB))
        flag1 = 1;
        for temp3 = 1 : length(EOB)
            if(code_now(temp3) ~= EOB(temp3)) 
                flag1 = 0;
                break;
            end         
        end
    %find ZRL
    elseif (length(code_now) == length(ZRL))
        flag2 = 1;
        for temp3 = 1 : length(ZRL)
            if(code_now(temp3) ~= ZRL(temp3)) 
                flag2 = 0;
                break;
            end         
        end
    end
    if (flag1)%EOB: actually the end, directly add
        col_now = col_now + 1;
        row_now = 1;
        index_search = temp1 + 1;
        temp1 = index_search;
    elseif (flag2)%ZRL: 16 0s, directly pass
        row_now = row_now + 16;
        index_search = temp1 + 1;
        temp1 = index_search;
    else%other situation
        for temp2 = 1 : size(ACTAB, 1)%find the huff
            col1 =  ACTAB(temp2, 3) + 3;
            code_now = AC(index_search: temp1)';
            code_huff = ACTAB(temp2, 4: col1);
            flag = 0;
            if(length(code_now) == length(code_huff))
                flag = 1;
                for temp3 = 1 : length(code_huff)
                    if(code_now(temp3) ~= code_huff(temp3)) 
                        flag = 0;
                        break;
                    end
                end
            end
            if (flag)%if equal, then using huff to find the amptitude value
                row_now = row_now + ACTAB(temp2, 1);
                num_ampt = AC(temp1 + 1: temp1 + ACTAB(temp2, 2))';
                if (num_ampt(1))
                    num_ampt = char(num_ampt + '0');
                    B2(row_now, col_now) = bin2dec(num_ampt);
                else
                    num_ampt = char(~num_ampt + '0');
                    B2(row_now, col_now) = -bin2dec(num_ampt);
                end
                row_now = row_now + 1;
                index_search = temp1 + ACTAB(temp2, 2) + 1;
                temp1 = index_search;
                break;
            end
        end
    end
    temp1 = temp1 + 1;
end

B = [B1'; B2];
end
