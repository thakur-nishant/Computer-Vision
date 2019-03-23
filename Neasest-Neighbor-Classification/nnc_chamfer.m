function class_label = nnc_chamfer(test_image)

min_distance = Inf;

files = dir('digits_training\*.png');
for i = 1:length(files)
    file = files(i);
    file_label = file.name(6);
    curr_image = imread(strcat('digits_training\',file.name));
    curr_image_distance = chamfer_distance(test_image, curr_image);
    if curr_image_distance < min_distance
        min_distance = curr_image_distance;
        class_label = file_label;
    end
end

end

