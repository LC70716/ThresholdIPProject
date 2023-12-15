function [w_array,k_array,R_array,p_array,psnr_vals,ssim_vals,mssim_vals] = best_parameters_phansalkar(corrupt_list, gr_truth_list)
    j = 0; % window index
    psnr_vals = zeros(41, 11); % Preallocate arrays to store metric values
    psnr_vals2 = cell([41 41]);
    ssim_vals = zeros(41, 11);
    ssim_vals2 = cell([41 41]);
    mssim_vals = zeros(41, 11);
    mssim_vals2 = cell([41 41]);
    w_array = zeros(1, 11);
    k_array = zeros(1, 41);
    R_array = zeros(1,41);
    p_array = zeros(1,41);


    for window = 5:10:105 % window size for loop
        j
        j = j + 1;
        w_array(j) = window;

        k = 1; % Start value for bias index

        for bias_k = 0:0.025:1 % bias for loop
            k = k + 1; % Increment the bias index
            R = 1;   %Start value for R index

            for R_param = 0:0:0
                p = 1;   %Start value for p index
                for p_param = 0:0:0
                    % CALLING SINGH THRESHOLD FUNCTION
                    thresholded = phansalkar_threshold(corrupt_list(i), window, bias_k, R_param, p_param);

                    % Computing metrics
                    ssim_val = ssim(thresholded, gr_truth_list);
                    psnr_val = psnr(thresholded, gr_truth_list);
                    mssim_val = multissim(thresholded, gr_truth_list);

                    % Storing metric values for each window size and bias
                    ssim_vals(R, p) = ssim_val;
                    psnr_vals(R, p) = psnr_val;
                    mssim_vals(R, p) = mssim_val;
                end
            end

            ssim_vals2{w}{k} = ssim_vals;
            psnr_vals2{w}{k} = psnr_vals;
            mssim_vals2{w}{k} = mssim_vals;
        end
    end