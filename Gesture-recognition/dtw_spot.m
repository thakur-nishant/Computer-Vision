function result = dtw_spot(input_video, class_thresholds)

training_file = "gesture_videos/digits_model_quan_ex3.avi";
training_file_location = "gesture_videos/start_end_frames_model_quan_ex3.txt";

fid=fopen(training_file_location);
tline = fgetl(fid);
training_info = zeros(10,3);
 i = 1;
while ischar(tline)
    if tline == ""
        break;
    end
    training_info(i,:) = (str2double(strsplit(tline, ' ')));
    tline = fgetl(fid);
    i = i + 1;
end
fclose(fid);

test = green_hand_trajectory(input_video, 2, 1277);
result = zeros(1, 3);
j = 1;
for i = 1:10
    s_frame = training_info(i,2);
    e_frame = training_info(i,3);
    train = green_hand_trajectory(training_file, s_frame, e_frame);
    scores = dtw_for_gesture_spotting(train, test);
    curr_end_scores = scores(end,:);
    end_frames = find(curr_end_scores < class_thresholds(i));
    for k = 1:length(end_frames)
        [start_frame, end_frame] = backtrack_scores(scores, end_frames(k));
%         disp([start_frame, end_frame, curr_end_scores(end_frames(k)), i-1]);
        if j > 1 && result(j-1,1) == start_frame
            result(j-1,2) = end_frame;
        else
            result(j,:) = [start_frame, end_frame, i-1];
            j = j + 1;
        end
    end
end

end

