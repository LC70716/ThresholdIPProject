% returns window sizes 2D matrix, bias (k) 2D matrix, and a list of 
% matrices (basically 3D matrix) for each parameter. 
% The indexing of the parameters arrays is done in such a way : 
% psnr (ssim,mssim) CELLS contain the resulting parameters for each thresholding method
% (first index), for each image (second index). accessing for example 
% A = psnr_vals{1}{5} will return the psnr value matrix for the first algorithm (singh) for the fifth image
% then, A(3,4) returns the psnr for the third bias value and fourth window size
% ref_images and corrupted_images ARE INTENDED TO BE ARRAYS CONTAINING THE 
% IMAGES' NAMES in such fashion : ["myimage.tiff","myimage2.tiff",...]
% make sure to add the WHOLE REPO to your matlab path
% ZHANG doesn't have bias, they are all listed as -1, 
% BERNSEN doesn't have bias but has CONTRAST THRESHOLDING, and that's what is listed in its k matrix row
% OTSU doesn't have a proper window size but it has a block size, still it
% listed in the w_matrix
function [w_matrix,k_matrix,psnr_vals,ssim_vals,mssim_vals] = batch_best_parameters(ref_images,cor_images)
    w_matrix = zeros(6,11); % 3 algorithms, so first index has length 3. 10 different window sizes,so second index has length 10.
    k_matrix = zeros(6,41);
    psnr_vals = cell([6,10]);
    ssim_vals = cell([6,10]);
    mssim_vals = cell([6,10]);
    for i = 1 : size(ref_images) 
        [w_matrix(1,:),k_matrix(1,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_singh(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{1}{i} = temp_psnr_vals;
        ssim_vals{1}{i} = temp_ssim_vals;
        mssim_vals{1}{i} = temp_mssim_vals;
    end 
    save('up_to_singh')
    for i = 1 : size(ref_images)
        [w_matrix(2,:),k_matrix(2,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_niblack(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{2}{i} = temp_psnr_vals;
        ssim_vals{2}{i} = temp_ssim_vals;
        mssim_vals{2}{i} = temp_mssim_vals;
    end
    save('up_to_niblack')
    for i = 1 : size(ref_images)
        [w_matrix(3,:),k_matrix(3,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_sauvola(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{3}{i} = temp_psnr_vals;
        ssim_vals{3}{i} = temp_ssim_vals;
        mssim_vals{3}{i} = temp_mssim_vals;
    end
    save('up_to_sauvola')
    for i = 1 : size(ref_images)
        [w_matrix(4,:),k_matrix(4,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_bernsen(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{4}{i} = temp_psnr_vals;
        ssim_vals{4}{i} = temp_ssim_vals;
        mssim_vals{4}{i} = temp_mssim_vals;
    end
    save('up_to_bernsen')
    for i = 1 : size(ref_images)
        [w_matrix(5,:),k_matrix(5,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_otsu(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{5}{i} = temp_psnr_vals;
        ssim_vals{5}{i} = temp_ssim_vals;
        mssim_vals{5}{i} = temp_mssim_vals;
    end
    save('up_to_otsu')
    for i = 1 : size(ref_images)
        [w_matrix(6,:),k_matrix(6,:),temp_psnr_vals,temp_ssim_vals,temp_mssim_vals] = best_parameters_zhang(imread(cor_images(i)),imread(ref_images(i)));
        psnr_vals{6}{i} = temp_psnr_vals;
        ssim_vals{6}{i} = temp_ssim_vals;
        mssim_vals{6}{i} = temp_mssim_vals;
    end
    save('up_to_zhang')

