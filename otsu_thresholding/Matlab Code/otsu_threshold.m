
% Loop over different block sizes and weight factors
for b = 1:length(block_sizes)
    for w = 1:length(weight_factors)
        block_size = block_sizes(b);
        weight_factor = weight_factors(w);

        % Initialize the output image as the same size and type as the original image
        local_otsu = zeros(size(img), 'like', img);

        % Process each block independently
        for i = 1:block_size:size(img, 1)
            for j = 1:block_size:size(img, 2)
                % Extract the block from the original image
                row_indices = i:min(i+block_size-1, size(img, 1));
                col_indices = j:min(j+block_size-1, size(img, 2));
                block = img(row_indices, col_indices);

                % Calculate the global Otsu threshold for the block
                level = graythresh(block);
                
                % Apply the Otsu method to get the threshold value within [0, 1]
                thresh = level * 255;
                
                % Calculate the mean intensity of the block
                mean_intensity = mean(block(:));
                
                % Compute the weighted average of the global threshold and the mean intensity
                adjusted_thresh = weight_factor * thresh + (1 - weight_factor) * mean_intensity;
                
                % Binarize the block using the adjusted threshold
                local_otsu_block = block > adjusted_thresh;
                
                % Write the binarized block back to the corresponding location in the output image
                local_otsu(row_indices, col_indices) = local_otsu_block * 255;
            end
        end
