function [top_row, bottom_row, left_column, right_column] = find_bounding_box(curr_filename)
[area, person] = find_max_component_area(curr_filename)

%%
% find coordinates of all non-zero pixels.
[row_coords col_coords] = find(person);

original_image = double(imread(curr_filename));
top_row = min(row_coords);
bottom_row = max(row_coords);
left_column = min(col_coords);
right_column = max(col_coords);

border_color = [255 255 0];

result_image = draw_rectangle(original_image, border_color, top, bottom, left, right);

imshow(result_image/255);

end

