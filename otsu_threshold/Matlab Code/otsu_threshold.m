% Read the noisy/degraded image
img = imread('Thresholding-8bit.jpg'); % Replace with your image path

% Convert to grayscale if the image is in color
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Read the reference image (ground truth)
ref_img = imread('Thresholding-8bit.jpg'); % Replace with the path to your reference image
if size(ref_img, 3) == 3
    ref_img = rgb2gray(ref_img);
end

% Define block sizes and weight factors to test
block_sizes = [16, 32, 48, 64, 80]; % Add more block sizes if needed
weight_factors = 0:0.1:1; % Change the step size if needed

% Initialize arrays to store metrics
metrics = struct('block_size', [], 'weight_factor', [], 'PSNR', [], 'SNR', [], 'MAE', [], 'RMSE', [], 'SSIM', []);

% Open a file to save the metrics
fileID = fopen('metrics_results.txt', 'w');
fprintf(fileID, 'Block_Size, Weight_Factor, PSNR, SNR, MAE, RMSE, SSIM\n');

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
                
                % Apply the Otsu's method to get the threshold value within [0, 1]
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

        % Calculate the metrics
        mae = mean(abs(double(local_otsu) - double(ref_img)), 'all');
        rmse = sqrt(mean((double(local_otsu) - double(ref_img)).^2, 'all'));
        psnr_value = psnr(local_otsu, ref_img);
        snr_value = snr(double(local_otsu), double(local_otsu) - double(ref_img));
        ssim_value = ssim(local_otsu, ref_img); % Calculate SSIM

        % Store metrics
        metrics(end+1) = struct('block_size', block_size, 'weight_factor', weight_factor, ...
                                'PSNR', psnr_value, 'SNR', snr_value, 'MAE', mae, 'RMSE', rmse, 'SSIM', ssim_value);
        
        % Write the metrics to the file
        fprintf(fileID, '%d, %f, %f, %f, %f, %f, %f\n', block_size, weight_factor, psnr_value, snr_value, mae, rmse, ssim_value);
    end
end

% Close the file
fclose(fileID);

% Remove the first empty element
metrics(1) = [];

% Plot the metrics
figure;
subplot(3,2,1); plot([metrics.PSNR], 'DisplayName', 'PSNR'); title('PSNR'); legend;
subplot(3,2,2); plot([metrics.SNR], 'DisplayName', 'SNR'); title('SNR'); legend;
subplot(3,2,3); plot([metrics.MAE], 'DisplayName', 'MAE'); title('MAE'); legend;
subplot(3,2,4); plot([metrics.RMSE], 'DisplayName', 'RMSE'); title('RMSE'); legend;
subplot(3,2,5); plot([metrics.SSIM], 'DisplayName', 'SSIM'); title('SSIM'); legend;