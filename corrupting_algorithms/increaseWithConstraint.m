function updated_matrix = increaseWithConstraint(matrix)
    [rows, cols] = size(matrix);
    updated_matrix = matrix;
    for col = 1:cols
        increment = ((cols - (col - 1))/cols)*240;
        column_values = matrix(:, col) - round(increment);
        column_values(column_values > 255) = 255; % Applying the constraint
        column_values(column_values < 0) = 0; % Applying the constraint
        updated_matrix(:, col) = column_values;
    end
end