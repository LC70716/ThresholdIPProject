function best_window = best_parameters(img)

    j=0;
    psnr_vals = zeros(1, 10); % Preallocate arrays to store metric values
    ssim_vals = zeros(1, 10);
    w_array = zeros(1, 10);

    for window=5:5:50 
        j=j+1; 
        w_array(j) = window;
        
        % CALLING ZHANG THRESHOLD FUNCTION
        thresholded = zhang_threshold(img, window);

        % Computing metrics
        ssim_val = ssim(thresholded, img);
        psnr_val = psnr(thresholded, img);
        
        % Storing metric values for each window size
        ssim_vals(j) = ssim_val;
        psnr_vals(j) = psnr_val;
    end

    % Finding maximum PSNR and SSIM values and their corresponding window sizes
    [max_psnr, index_psnr] = max(psnr_vals);
    [max_ssim, index_ssim] = max(ssim_vals);

    disp('Max PSNR:');
    disp(max_psnr);
    disp('Window size for max PSNR:');
    disp(w_array(index_psnr));

    disp('Max SSIM:');
    disp(max_ssim);
    disp('Window size for max SSIM:');
    disp(w_array(index_ssim));

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