
function best_parameters_bernsen2(currupt_img,ground_truth_img)

currupt_img = double(currupt_img);
ground_truth_img = double(ground_truth_img);

%% 
% s=0;
% [~,~,s]=size(image);
% if s==3 % if the image is an RGB image
%    image= rgb2gray(image); 
% end
%%

window=[15:10:155]; % % Range of window dimentions. window dimensions must be odd numbers.
contrast_threshold=[3:2:45]; % Range of contrast threshold values

contrast_threshold2=contrast_threshold';

i=0;
j=0;
for w=window
     i=i+1;
    for ct=contrast_threshold
         j=j+1;
         thr_img = bernsen(currupt_img,[w w],ct);
         
         ground_truth_img = mat2gray(ground_truth_img);   % For the following evaluations, pixels values should be within the range of 0 and 1
         
         ssim_val = ssim(thr_img,ground_truth_img); % structural similarity index method
         crrcf_val=corrcoef(thr_img,ground_truth_img); % correlation coeficient method
         mssim_val = multissim(thr_img,ground_truth_img); % Multi-Scale Structural Similarity Index
         psnr_val=psnr(thr_img,ground_truth_img); 
       
         % Put all of those results in q_val variable
         q_val(j,1)=ssim_val;
         q_val(j,2)=crrcf_val(2,1);
         q_val(i,3)=mssim_val;
         q_val(i,4)=psnr_val(end);
         
         [~ , num_mth] =size(q_val); % Number of methods for assessing the thresholding
        
    end

    for x=[1:num_mth]
       
         vec_max=q_val(:,x)==max(q_val(:,x));
         index_max=find(vec_max);
         index_max=index_max(end);
         max_val(i,2*x-1)=contrast_threshold2(index_max);
         max_val(i,2*x)=q_val(index_max,x);
      
    end
    
         max_val(i,2*x+1)=w;
         
    j=0;

end

display(max_val)

vec_max=max_val(:,2)==max(max_val(:,2));
index_max=find(vec_max);
index_max=index_max(end);
best_ct_ssim=max_val(index_max,1);
best_window_ssim=max_val(index_max,9);
disp(['Best window dimention by SSIM= ', num2str(best_window_ssim(end))])
disp(['Best contrast threshold value by SSIM = ', num2str(best_ct_ssim(end))])

vec_max=max_val(:,4)==max(max_val(:,4));
index_max=find(vec_max);
index_max=index_max(end);
best_ct_crcf=max_val(index_max,3);
best_window_crcf=max_val(index_max,9);
disp(['Best window dimention by correlation coefficient= ', num2str(best_window_crcf(end))])
disp(['Best contrast threshold value by correlation coefficient = ', num2str(best_ct_crcf(end))])

vec_max=max_val(:,6)==max(max_val(:,6));
index_max=find(vec_max);
index_max=index_max(end);
best_ct_mssim=max_val(index_max,5);
best_window_mssim=max_val(index_max,9);
disp(['Best window dimention by MSSIM = ', num2str(best_window_mssim(end))])
disp(['Best contrast threshold value by MSSIM = ', num2str(best_ct_mssim(end))])

vec_max=max_val(:,8)==max(max_val(:,8));
index_max=find(vec_max);
index_max=index_max(end);
best_ct_psnr=max_val(index_max,7);
best_window_psnr=max_val(index_max,9);
disp(['Best window dimention by PSNR = ', num2str(best_window_psnr(end))])
disp(['Best contrast threshold value by PSNR  = ', num2str(best_ct_psnr(end))])


end 
