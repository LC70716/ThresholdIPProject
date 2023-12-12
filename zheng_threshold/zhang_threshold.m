function thresholded = zhang_threshold(matrix,window_size)
         for row = 1 : size(matrix,1)
             for col = 1 : size(matrix,2)
                 for w = -window_size : window_size
                     if row + w > 0 && row + w <= size(matrix:1)
                     if col + w > 0 && col + w <= size(matrix:2)
                     end 
                 end
             end
         end