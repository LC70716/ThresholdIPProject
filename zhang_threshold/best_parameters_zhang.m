function [w_array,k_array,psnr_vals,ssim_vals,mssim_vals] = best_parameters_zhang(corrupt, gr_truth)
    j = 0; % window index
    psnr_vals = zeros(40, 10); % Preallocate arrays to store metric values
    ssim_vals = zeros(40, 10);
    mssim_vals = zeros(40, 10);
    w_array = zeros(1, 10);
    k_array = ones(1, 40) .* -1; % since they are not used in the algo, but needed for consistency in the batch

    for window = 5:10:105 % window size for loop
        j
        j = j + 1;
        w_array(j) = window;
        thresholded = zhang_threshold(corrupt, window);

        % Computing metrics
        ssim_val = ssim(thresholded, gr_truth);
        psnr_val = psnr(thresholded, gr_truth);
        mssim_val = multissim(thresholded, gr_truth);
            
        k = 1; % Start value for bias index (usefull ONLY FOR CONSISTENCY)

        for bias_k = 0:0.025:1 % bias for loop
            ssim_vals(k, j) = ssim_val;
            psnr_vals(k, j) = psnr_val;
            mssim_vals(k, j) = mssim_val;
            
            k = k + 1; % Increment the bias index
        end
    end