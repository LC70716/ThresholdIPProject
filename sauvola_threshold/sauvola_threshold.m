function thresholded = sauvola_threshold(matrix,window_size, bias)
    thresholded = ones(size(matrix,1),size(matrix,2)) * 255; % initializing output as all background
    for row = 1 : size(matrix,1) %iterating over all rows and colums
        for col = 1 : size(matrix,2)
            accepted_points_to_reshape = zeros(1,window_size^2); %points which actually lie inside the image
            index_to_modify = 1; %avoiding multiple resizing of accepted_points
            for w = -round(window_size/2) : round(window_size/2)
                if row + w > 0 && row + w <= size(matrix,1) 
                   if col + w > 0 && col + w <= size(matrix,2)
                      accepted_points_to_reshape(index_to_modify) = matrix(row+w,col+w); % if the point is inside the image then it is accepted
                      index_to_modify = index_to_modify + 1;
                   end                     
                end     
            end
        accepted_points = accepted_points_to_reshape(1:index_to_modify);
        mean_ = mean(accepted_points);
        std_dev = std(accepted_points);
        R = 128;
        threshold = mean_*(1 + bias*((std_dev)/(R)-1));
        if matrix(row,col) < threshold
            thresholded(row,col) = 0;
        end
        if matrix(row,col) >= threshold
            thresholded(row, col) = 255;
        end
        end
    end

    %casting image to 8bit unsigned int
    thresholded = im2uint8(thresholded);

end