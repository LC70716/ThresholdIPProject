% returns window sizes 2D matrix, bias (k) 2D matrix, and a list of 
% matrices (basically 3D matrix) for each parameter. 
% The indexing of the parameters arrays is done in such a way : say the
% image list contains 10 images : the first 10 indexes in the third
% dimension will contain the results for the first algorithm, the next 10
% for the second etc. in total there should be number of images x number of
% algorithms listed matrices, indexed by the third dimension
% ref_images and corrupted_images ARE INTENDED TO BE ARRAYS CONTAINING THE 
% IMAGES' NAMES in such fashion : "myimage.tiff"
% make sure to add the WHOLE REPO to your matlab path
% ZHANG doesn't have bias, they are all listed as -1, 
% BERNSEN doesn't have bias but has CONTRAST THRESHOLDING, and that's what is listed in its k matrix row
function [w_matrix,k_matrix,psnr_vals,ssim_vals,mssim_vals] = batch_best_parameters(ref_images,cor_images)
    w_matrix = zeros(5,11); % 3 algorithms, so first index has length 3. 10 different window sizes,so second index has length 10.
    k_matrix = zeros(5,41);
    psnr_vals = cell([5,10]);
    ssim_vals = cell([5,10]);
    mssim_vals = cell([5,10]);
    for i = 1 : size(ref_images) 
        [w_matrix(1,:),k_matrix(1,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_singh(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{1}{i} = temp_psnr_vals;
        ssim_vals{1}{i} = temp_ssim_vals;
        mssim_vals{1}{i} = temp_mssim_vals;
    end 
    for i = 1 : size(ref_images)
        [w_matrix(2,i),k_matrix(2,i),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_niblack(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{2}{i} = temp_psnr_vals;
        ssim_vals{2}{i} = temp_ssim_vals;
        mssim_vals{2}{i} = temp_mssim_vals;
    end
    for i = 1 : size(ref_images)
        [w_matrix(3,i),k_matrix(3,i),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_sauvola(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{3}{i} = temp_psnr_vals;
        ssim_vals{3}{i} = temp_ssim_vals;
        mssim_vals{3}{i} = temp_mssim_vals;
    end
    for i = 1 : size(ref_images)
        [w_matrix(4,i),k_matrix(4,i),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_bernsen(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{4}{i} = temp_psnr_vals;
        ssim_vals{4}{i} = temp_ssim_vals;
        mssim_vals{4}{i} = temp_mssim_vals;
    end
    for i = 1 : size(ref_images)
        [w_matrix(5,i),k_matrix(5,i),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_zhang(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{5}{i} = temp_psnr_vals;
        ssim_vals{5}{i} = temp_ssim_vals;
        mssim_vals{5}{i} = temp_mssim_vals;
    end

