function best_window = best_parameters(corrupt, gr_truth)
    j = 0; % window index
    i = 0; % bias index
    psnr_vals = zeros(1, 10); % Preallocate arrays to store metric values
    ssim_vals = zeros(1, 10);
    mssim_vals = zeros(1, 10);
    w_array = zeros(1, 10);
    k_array = zeros(1, 10);

    for window = 5:10:105 % window size for loop
        j = j + 1;
        w_array(j) = window;

        k = 1; % Start value for bias index

        for bias_k = 0:1:0 % bias for loop
            % CALLING ZHANG THRESHOLD FUNCTION
            thresholded = zhang_threshold(corrupt, window);

            % Computing metrics
            ssim_val = ssim(thresholded, gr_truth);
            psnr_val = psnr(thresholded, gr_truth);
            mssim_val = multissim(thresholded, gr_truth);
            
            % Storing metric values for each window size and bias
            ssim_vals(k, j) = ssim_val;
            psnr_vals(k, j) = psnr_val;
            mssim_vals(k, j) = mssim_val;
            
            k = k + 1; % Increment the bias index
        end
    end

    % Finding maximum PSNR and SSIM values and their corresponding window sizes
    [max_psnr, index_psnr] = max(psnr_vals(:));
    [max_ssim, index_ssim] = max(ssim_vals(:));
    [max_mssim, index_mssim] = max(mssim_vals(:));

    % Finding the corresponding indices for max values
    [row_psnr, col_psnr] = ind2sub(size(psnr_vals), index_psnr);
    [row_ssim, col_ssim] = ind2sub(size(ssim_vals), index_ssim);
    [row_mssim, col_mssim] = ind2sub(size(mssim_vals), index_mssim);

    disp('Max PSNR:');
    disp(max_psnr);
    disp('Window size and bias for max PSNR:');
    disp([w_array(col_psnr), k_array(row_psnr)]);

    disp('Max SSIM:');
    disp(max_ssim);
    disp('Window size and bias for max SSIM:');
    disp([w_array(col_ssim), k_array(row_ssim)]);

    disp('Max MSSIM:');
    disp(max_mssim);
    disp('Window size and bias for max MSSIM:');
    disp([w_array(col_mssim), k_array(row_mssim)]);

    % Plotting PSNR vs. Window
    figure;
    plot(w_array, psnr_vals, '-o', 'LineWidth', 2);
    xlabel('Window Size');
    ylabel('PSNR');
    title('PSNR vs. Window Size');

    % Plotting SSIM vs. Window
    figure;
    plot(w_array, ssim_vals, '-o', 'LineWidth', 2);
    xlabel('Window Size');
    ylabel('SSIM');
    title('SSIM vs. Window Size');
end