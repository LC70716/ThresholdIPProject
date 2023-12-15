function thresholded = phansalkar_threshold(image, block_size, k, p, R)
    q = 10;
    % Calculate Otsus threshold using block-wise processing
    [rows, cols] = size(image);
    
    % Initialize the output image as the same size and type as the original image
    thresholded = zeros(size(image), 'like', image);
    
    for i = 1:block_size:rows
        for j = 1:block_size:cols
            
            % Extract the block from the original image
            row_indices = i:min(i+block_size-1, size(image, 1));
            col_indices = j:min(j+block_size-1, size(image, 2));
            block = image(row_indices, col_indices);
            block = im2double(block);
            % Calculate the mean intensity of the block

            mean_ = mean(block(:));
            std_dev = std(block(:),0,'all');

            % Compute the weighted average of the global threshold and the mean intensity
            adjusted_thresh = mean_*(1 + k*((std_dev)/(R)-1) + p * exp(-q * mean_));

            % Binarize the block using the adjusted threshold
            thresholded_block = block > adjusted_thresh;

            % Write the binarized block back to the corresponding location in the output image
            thresholded(row_indices, col_indices) = thresholded_block * 255;
            thresholded = im2uint8(thresholded);
        end
    end
end