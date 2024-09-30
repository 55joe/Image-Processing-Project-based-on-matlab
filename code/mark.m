function image_mark = mark(image, image_detect, m, n, x, blocksize)
    [row, col] = size(image_detect);
    image_mark = image;

    for temp1 = 1 : blocksize :row
        for temp2 = 1 : blocksize : col
            if (image_detect(temp1,temp2) == 1)
                %find a nozero point, then find its neighbours to check if
                %this area is big enough representing human head
                [left, right, up, down] = find_neighbour(image_detect, temp1, temp2,blocksize);
                if(right - left >= m && down- up >= n)
                    %if larger than pre input size of head, then draw a red
                    %rectangle
                    image_mark(up, left : right , 1) = 255;
                    image_mark(up, left : right , 2) = 0;
                    image_mark(up, left : right , 3) = 0;
                    image_mark(down, left : right , 1) = 255;
                    image_mark(down, left : right , 2) = 0;
                    image_mark(down, left : right , 3) = 0;
                    image_mark(up : down, left , 1) = 255;
                    image_mark(up : down, left , 2) = 0;
                    image_mark(up : down, left , 3) = 0;
                    image_mark(up : down, right , 1) = 255;
                    image_mark(up : down, right , 2) = 0;
                    image_mark(up : down, right , 3) = 0;
                end
            end
        end
    end
end

%find the neighbours of 1, the neighbour of is means its value is 1 and it
%is connected to the "host" 1
function [left, right, up ,down] = find_neighbour(image_detect, row, col, blocksize)
    left = col;
    right = col;
    up = row;
    down = row;

    queue = [row, col];
    image_detect(row : row + blocksize - 1, col : col + blocksize - 1) = 0;

    %using queue to store the points to check
    while ~isempty(queue)
        current = queue(1, :);
        queue(1, :) = [];
        
        r = current(1);
        c = current(2);
        %record the area of the neighbour area in rectangle
        left = min(left, c);
        right = max(right, c);
        up = min(up, r);
        down = max(down, r);
        %check the neighbours around, four directions
        neighbors = [r+blocksize, c;
            r, c+blocksize;
            r-blocksize, c;
            r, c-blocksize];
        for k = 1:size(neighbors, 1)
            nr = neighbors(k, 1);
            nc = neighbors(k, 2);
            
            %if == 1, into queue and let it be 0
            if (image_detect(nr, nc) == 1)
                queue = [queue; nr, nc];
                image_detect(nr : nr + blocksize - 1, nc : nc + blocksize - 1) = 0;
            end
        end
    end
    right = right + blocksize;
    down = down + blocksize;
end
