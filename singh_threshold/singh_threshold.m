function thresholded = singh_threshold(matrix,window_size,bias)
    Matrix = double(matrix);
    Matrix = Matrix ./ 255;
    thresholded = ones(size(Matrix,1),size(Matrix,2)); % initializing output as all background
    integral_sum_image = integralImage(Matrix);
    d = round(window_size/2);
    for row = 1 : size(Matrix,1) %iterating over all rows and colums
        for col = 1 : size(Matrix,2)
            temp_d = d;
            while true
                logic = [(row - temp_d) >= 1, (row + temp_d - 1) <= size(integral_sum_image,1), (col - temp_d) >= 1, (col + temp_d - 1) <= size(integral_sum_image,2)];
                if temp_d == 1
                   T = -1;
                   break
                end 
                if all(logic,'all')
                   local_sum = (integral_sum_image(row+temp_d-1,col+temp_d-1) + integral_sum_image(row-temp_d,col-temp_d)) - (integral_sum_image(row-temp_d,col+temp_d-1) + integral_sum_image(row+temp_d-1,col-temp_d));
                   mean = local_sum/((window_size)^2);
                   mean_deviation = Matrix(row,col) - mean;
                   T = mean*(1+bias*((mean_deviation/(1-mean_deviation))-1));
                   break
                end
                temp_d = temp_d - 1;
             end
            if Matrix(row,col) <= T 
               thresholded(row,col) = 0;
            end 
        end

        %casting image to 8bit unsigned int
        thresholded = im2uint8(thresholded);
    end