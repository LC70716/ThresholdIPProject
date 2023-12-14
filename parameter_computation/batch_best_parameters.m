% returns window sizes 2D matrix, bias (k) 2D matrix, and a list of matrices (basically 3D matrix) for each parameter. 
% The FIRST index relates to the ALGORITHM USED, the SECOND to THE IMAGE
% ref_images and corrupted_images ARE INTENDED TO BE ARRAYS CONTAINING THE IMAGES' NAMES in such fashion : 'myimage.tiff'
% make sure to add the WHOLE REPO to your matlab path
% since ZHANG doesn't have bias, they are all listed as -1, 
% if in the future algos have more or less arguments the same approach should be used to detect problems during data analysis
function [w_matrix,k_matrix,psnr_vals,ssim_vals,mssim_vals] = batch_best_parameters(ref_images,cor_images)
    w_matrix = zeros(3,10); % 3 algorithms, so first index has length 3. 10 different window sizes,so second index has length 10.
    k_matrix = zeros(3,40);
    psnr_vals = zeros(3,size(ref_images));
    ssim_vals = zeros(3,size(ref_images));
    mssim_vals = zeros(3,size(ref_images));
    for i = 1 : size(ref_images) 
        [w_matrix(1,i),k_matrix(1,i),psnr_vals(1,i),ssim_vals(1,i),pmssim_vals(1,i)] = best_parameters_singh(imread(cor_images(i)),imread(ref_images(i)));
    end
    for i = 1 : size(ref_images)
        [w_matrix(2,i),k_matrix(2,i),psnr_vals(2,i),ssim_vals(2,i),pmssim_vals(2,i)] = best_parameters_zhang(imread(cor_images(i)),imread(ref_images(i)));
    end 
    for i = 1 : size(ref_images)
        [w_matrix(3,i),k_matrix(3,i),psnr_vals(3,i),ssim_vals(3,i),pmssim_vals(3,i)] = best_parameters_niblack(imread(cor_images(i)),imread(ref_images(i)));
    end

