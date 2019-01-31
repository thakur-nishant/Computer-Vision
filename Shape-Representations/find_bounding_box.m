function [top, bottom, left, right] = find_bounding_box(curr_filename)
[area, person] = find_max_component_area(curr_filename)

%%
% find coordinates of all non-zero pixels.
[row_coords col_coords] = find(person);

original_image = double(imread(curr_filename));
top = min(row_coords);
bottom = max(row_coords);
left = min(col_coords);
right = max(col_coords);

border_color = [255 255 0];

result_image = draw_rectangle(original_image, border_color, top, bottom, left, right);

imshow(result_image/255);

end

