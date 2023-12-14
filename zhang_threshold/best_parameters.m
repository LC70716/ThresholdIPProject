function best_window = best_parameters(img)

    j=0;                                                    %window index
    %i=0;                                                   %bias index
    psnr_vals = zeros(1, 10);                               % Preallocate arrays to store metric values
    ssim_vals = zeros(1, 10);
    mssim_vals = zeros(1, 10);
    %corr_coeff_vals = zeros(1, 10);
    w_array = zeros(1, 10);
    %k_array = zeros(1, 10);

    for window=15:10:125                                    %window size for loop
        j=j+1; 
        w_array(j) = window;
        
        %for k=minimum possible value:increment per iteration: maximum possible value      %bias for loop
        % CALLING ZHANG THRESHOLD FUNCTION
        thresholded = zhang_threshold(img, window);

        % Computing metrics
        ssim_val = ssim(thresholded, img);
        psnr_val = psnr(thresholded, img);
        mssim_val = multissim(thresholded, img);
        %corr_coeff_val = corrcoef(thresholded, img);
        
        % Storing metric values for each window size and bias
        psnr_vals(j) = psnr_val;
        ssim_vals(j) = ssim_val;
        mssim_vals(j) = mssim_val;
        %corr_coeff_vals(j) = corr_coeff_val;

        %end

    end

    % Finding maximum PSNR and SSIM values and their corresponding window sizes
    [max_psnr, index_psnr] = max(psnr_vals);
    [max_ssim, index_ssim] = max(ssim_vals);
    [max_mssim, index_mssim] = max(mssim_vals);
    %[max_corr_coeff, index_corr] = max(corr_coeff_vals_vals);


    disp('Max PSNR:');
    disp(max_psnr);
    disp('Window size for max PSNR:');
    disp(w_array(index_psnr));

    disp('Max SSIM:');
    disp(max_ssim);
    disp('Window size for max SSIM:');
    disp(w_array(index_ssim));

    disp('Max MSSIM:');
    disp(max_mssim);
    disp('Window size for max SSIM:');
    disp(w_array(index_mssim));

    %disp('Max CORRELATION COEFF.:');
    %disp(max_corr_coeff);
    %disp('Window size for max SSIM:');
    %disp(w_array(index_corr));

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