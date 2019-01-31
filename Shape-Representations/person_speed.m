function [rows_per_frame, cols_per_frame] = person_speed(file1,file2)
[top1, bottom1, left1, right1] = find_bounding_box(file1)
[top2, bottom2, left2, right2] = find_bounding_box(file2)

top_diff = abs(top1-top2)
bot_diff = abs(bottom1-bottom2)
left_diff = abs(left1-left2)
right_diff = abs(right1-right2)

row_diff = (top_diff + bot_diff)/2
col_diff = (left_diff + right_diff)/2

[sequence_name1, frame1] = parse_frame_name(file1);
[sequence_name2, frame2] = parse_frame_name(file2);

frame_diff = abs(frame1-frame2)

rows_per_frame = row_diff/frame_diff
cols_per_frame = col_diff/frame_diff
end

