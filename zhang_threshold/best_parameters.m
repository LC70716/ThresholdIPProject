function best_window = best_parameters(img)

    j=0;
    psnr_vals = zeros(1, 3); % Preallocate arrays to store metric values
    ssim_vals = zeros(1, 3);
    w_array = zeros(1, 3);

    for window=15:10:35 
        j=j+1; 
        w_array(j) = window;
        
        %casting image to uint8
        img = uint8(img);
        
        % CALLING ZHANG THRESHOLD FUNCTION
        thresholded = zhang_threshold(img, window);

        % Converting thresholded image to double too
        img = double(img);
        img = mat2gray(img); 
        thresholded = double(thresholded);

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
end