function [area, person] = find_max_component_area(curr_filename)
% Get the frame number by parsing the filename.
[sequence_name, frame] = parse_frame_name(curr_filename);
% Return 0 for the frame which do not have 
if frame < 10 
    frame1_filename = make_frame_name(sequence_name, 0);
    frame2_filename = make_frame_name(sequence_name, frame+10);
elseif frame > 114
    frame1_filename = make_frame_name(sequence_name, frame-10);
    frame2_filename = make_frame_name(sequence_name, 124);
else  
    frame1_filename = make_frame_name(sequence_name, frame-10);
    frame2_filename = make_frame_name(sequence_name, frame+10);
    % improving accuracy by considering frames further away in time.
end
frame00 = read_gray(curr_filename);
frame11 = read_gray(frame1_filename);
frame22 = read_gray(frame2_filename);
diff1 = abs(frame00 - frame11);
diff2 = abs(frame00 - frame22);
motion2 = min(diff1, diff2);

threshold = 10; 
thresholded = (motion2 > threshold); 

%%

% connected component analysis
[labels, number] = bwlabel(thresholded, 8);

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
if sum(area(:)) == 0
    person = 0
    area = 0
else
    person = (labels == id);
end
end

