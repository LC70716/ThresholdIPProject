% returns window sizes 2D matrix, bias (k) 2D matrix, and a list of matrices (basically 3D matrix) for each parameter. 
% The FIRST index relates to the ALGORITHM USED, the SECOND to THE IMAGE
% ref_images and corrupted_images ARE INTENDED TO BE ARRAYS CONTAINING THE IMAGES' NAMES in such fashion : 'myimage.tiff'
% make sure to add the WHOLE REPO to your matlab path
% ZHANG doesn't have bias, they are all listed as -1, 
% BERNSEN doesn't have bias but has CONTRAST THRESHOLDING, and that's what is listed in its k matrix row
function [w_matrix,k_matrix,psnr_vals,ssim_vals,mssim_vals] = batch_best_parameters(ref_images,cor_images)
    w_matrix = zeros(5,10); % 3 algorithms, so first index has length 3. 10 different window sizes,so second index has length 10.
    k_matrix = zeros(5,40);
    psnr_vals = zeros(5,size(ref_images));
    ssim_vals = zeros(5,size(ref_images));
    mssim_vals = zeros(5,size(ref_images));
    for i = 1 : size(ref_images) 
        [w_matrix(1,i),k_matrix(1,i),psnr_vals(1,i),ssim_vals(1,i),pmssim_vals(1,i)] = best_parameters_singh(imread(cor_images(i)),imread(ref_images(i)));
    end 
    for i = 1 : size(ref_images)
        [w_matrix(2,i),k_matrix(2,i),psnr_vals(2,i),ssim_vals(2,i),pmssim_vals(2,i)] = best_parameters_niblack(imread(cor_images(i)),imread(ref_images(i)));
    end
    for i = 1 : size(ref_images)
        [w_matrix(3,i),k_matrix(3,i),psnr_vals(3,i),ssim_vals(3,i),pmssim_vals(3,i)] = best_parameters_sauvola(imread(cor_images(i)),imread(ref_images(i)));
    end
    for i = 1 : size(ref_images)
        [w_matrix(4,i),k_matrix(4,i),psnr_vals(4,i),ssim_vals(4,i),pmssim_vals(4,i)] = best_parameters_bernsen(imread(cor_images(i)),imread(ref_images(i)));
    end
    for i = 1 : size(ref_images)
        [w_matrix(5,i),k_matrix(5,i),psnr_vals(5,i),ssim_vals(5,i),pmssim_vals(5,i)] = best_parameters_zhang(imread(cor_images(i)),imread(ref_images(i)));
    end

