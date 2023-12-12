function thresholded = zhang_threshold(matrix,window_size)
    thresholded = ones(size(matrix,1),size(matrix,2)) * 255; % initializing output as all background
    for row = 1 : size(matrix,1) %iterating over all rows and colums
       accepted_points = []; %points which actually lie inside the image
        for col = 1 : size(matrix,2)
            for w = -round(window_size/2) : round(window_size/2)
                if row + w > 0 && row + w <= size(matrix:1) 
                   if col + w > 0 && col + w <= size(matrix:2)
                      accepted_points(end + 1) = matrix(row+w,column+w); % if the point is inside the image then it is accepted
                   end                     
                end     
            end
        mean_ = mean(accepted_points);
        std_dev = std(accepted_points);
        [count,~] = groupcounts(accepted_points); %needed to compute the probability of each gray level
        entropy_ = -1 * sum(count/size(accepted_points)*log2(count/size(accepted_points)));
        threshold = mean_ - (entropy_^2/std_dev);
        if matrix(row,col) < threshold
            thresholded(row,col) = 0;
        end 
        end
    end