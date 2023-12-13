function thresholded = singh_threshold(matrix,window_size,bias)
    thresholded = ones(size(matrix,1),size(matrix,2)) * 255; % initializing output as all background
    integral_sum_image = ones(size(matrix,1),size(matrix,2)) * 255;
    integral_sum_image(1,1) = matrix(1,1);
    for row = 1 : size(matrix,1)
        for col = 2 : size(matrix,2)
            if col ~= 1
            integral_sum_image(row,col) = matrix(row,col) + integral_sum_image(row,col-1);
            end 
            if col == 1
            integral_sum_image(row,col) = matrix(row,col) + integral_sum_image(row-1,size(matrix,2));
            end 
        end 
    end
    for row = 1 : size(integral_sum_image,1) %iterating over all rows and colums
        for col = 1 : size(integral_sum_image,2)
            d = round(window_size/2);
            local_sum = 0;
            done = 0;
            T = 0;
            while done == 0
                if (row - d) > 1 && (row + d - 1) <= size(integral_sum_image) && (col - d) > 1 && (col + d - 1) <= size(integral_sum_image)
                   local_sum = (integral_sum_image(row+d-1,col+d-1) + integral_sum_image(row-d,col-d)) - (integral_sum_image(row-d,col+d-1) + integral_sum_image(row+d-1,col-d));
                   mean = local_sum/(window_size^2);
                   mean_deviation = matrix(row,col) - mean;
                   T = mean*(1+bias*((mean_deviation/(1-mean_deviation))-1))*255;
                   done = 1;
                end
            end
            if matrix(row:col) < T 
               thresholded(row,col) = 0;
            end 
        end
    end