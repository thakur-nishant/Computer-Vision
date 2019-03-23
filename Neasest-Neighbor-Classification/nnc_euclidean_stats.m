function [accuracy, confusion_matrix] = nnc_euclidean_stats()
count = 0;
files = dir('digits_test\*.png');
confusion_matrix = zeros(10,10);
for i = 1:length(files)
    file = files(i);
    file_label = str2double(file.name(6));
    test_image = imread(strcat('digits_test\',file.name));
    class_label = str2double(nnc_euclidean(test_image));
    if file_label == 0
        file_label = 10;
    end
    if class_label == 0
        class_label = 10;
    end
    confusion_matrix(file_label,class_label) = confusion_matrix(file_label,class_label) + 1;
    if file_label == class_label
        count = count + 1;
    end
end
confusion_matrix = confusion_matrix/10;
accuracy = count/length(files);
end

