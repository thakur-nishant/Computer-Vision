function class_label = mei_classifier(filename, start_frame, end_frame)

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
min_distance = -Inf;
test_image = mei_image(filename, start_frame, end_frame);
for i = 1:10
    s_frame = training_info(i,2);
    e_frame = training_info(i,3);
    result = mei_image(training_file, s_frame, e_frame);
    curr_image_distance = corr2(test_image, result);
    if curr_image_distance > min_distance
        min_distance = curr_image_distance;
        class_label = i-1;
        save_img = result;
    end
end
figure(11);
imshow(save_img);
figure(12);
imshow(test_image);

end

