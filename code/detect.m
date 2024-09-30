%detect the parts of faces: blocksize: length of basic unit; threshold:
%limit value; output: iamge matrix with 0 and 1(1 for faces)
function image_detect = detect(image, blocksize, trained_feature, threshold, L)
    % Input size and output image
    [row, col, ~] = size(image);
    image_detect1 = image; % Start with the original image
    image_detect = zeros(row,col);
    
    % Define the red mask (light red)
    red_mask = cat(3, ones(blocksize, blocksize) * 255, zeros(blocksize, blocksize), zeros(blocksize, blocksize));  
    
    % Scan through each block of the image
    for temp1 = 1 : blocksize : row - blocksize + 1
        for temp2 = 1 : blocksize : col - blocksize + 1
            % The block detecting now
            block = image(temp1 : temp1 + blocksize - 1, temp2 : temp2 + blocksize - 1, :);
            block_feat = extract(block, L); % Convert block to grayscale for feature extraction
            delta = 1 - sum(sqrt(block_feat .* trained_feature));
            
            % Mark the face area
            if delta < threshold
                % Add a light red overlay to the detected area
                image_detect(temp1 : temp1 + blocksize - 1, temp2 : temp2 + blocksize - 1, :) = 1;
                image_detect1(temp1 : temp1 + blocksize - 1, temp2 : temp2 + blocksize - 1, :) = ...
                    0.7 * double(image(temp1 : temp1 + blocksize - 1, temp2 : temp2 + blocksize - 1, :)) + 0.3 * red_mask;
            end
        end
    end
    figure;
    imshow(image_detect1);

end
