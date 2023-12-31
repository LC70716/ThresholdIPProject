function thresholded = otsu_threshold(image, block_size, weight_factor)
    
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

            % Calculate the global Otsu threshold for the block
            level = graythresh(block);

            % Apply the Otsus method to get the threshold value within [0, 1]
            thresh = level * 255;

            % Calculate the mean intensity of the block
            mean_intensity = mean(block(:));

            % Compute the weighted average of the global threshold and the mean intensity
            adjusted_thresh = weight_factor * thresh + (1 - weight_factor) * mean_intensity;

            % Binarize the block using the adjusted threshold
            thresholded_block = block > adjusted_thresh;

            % Write the binarized block back to the corresponding location in the output image
            thresholded(row_indices, col_indices) = thresholded_block * 255;
            
        end
    end

    %casting image to 8bit unsigned int
    thresholded = im2uint8(thresholded);
end
