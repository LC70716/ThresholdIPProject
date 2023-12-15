function [w_array,k_array,psnr_vals,ssim_vals,mssim_vals] = best_parameters_sauvola(corrupt, gr_truth)
    j = 0; % window index
    psnr_vals = zeros(41, 11); % Preallocate arrays to store metric values
    ssim_vals = zeros(41, 11);
    mssim_vals = zeros(41, 11);
    w_array = zeros(1, 11);
    k_array = zeros(1, 41);

    for window = 5:10:105 % window size for loop
        j
        j = j + 1;
        w_array(j) = window;

        k = 1; % Start value for bias index

        for bias_k = 0:0.025:1 % bias for loop
            % CALLING SAUVOLA THRESHOLD FUNCTION
            thresholded = sauvola_threshold(corrupt, window, bias_k);

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