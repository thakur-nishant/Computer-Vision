function [top, bottom, left, right] = find_bounding_box(inputArg1,inputArg2)
% improving accuracy by considering frames further away in time.
frame47 = read_gray('walkstraight/frame0047.tif');
frame77 = read_gray('walkstraight/frame0077.tif');
diff1 = abs(frame62 - frame47);
diff2 = abs(frame62 - frame77);
motion2 = min(diff1, diff2);
imshow(motion2, []);

threshold = 10; thresholded = (motion2 > threshold); imshow(thresholded, []);

%%

% connected component analysis
[labels, number] = bwlabel(thresholded, 4);
figure(1); imshow(labels, []);

%%
% find the largest connected component
% create an array of counters, one for each connected component.
counters = zeros(1,number);
for i = 1:number
    % for each i, we count the number of pixels equal to i in the labels
    % matrix
    % first, we create a component image, that is 1 for pixels belonging to
    % the i-th connected component, and 0 everywhere else.
    component_image = (labels == i);
    
    % now, we count the non-zero pixels in the component image.
    counters(i) = sum(component_image(:));
end

% find the id of the largest component
[area, id] = max(counters);    
person = (labels == id);
imshow(person, []);

%%
% Rewriting the previous for loop in a more concise way.
% find coordinates of all non-zero pixels.
[row_coords col_coords] = find(person);
end

