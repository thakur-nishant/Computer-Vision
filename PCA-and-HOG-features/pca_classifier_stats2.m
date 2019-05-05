function [accuracy, confusion_matrix] = pca_classifier_stats2(data_file, d)
tic;
count = 0;
files = dir('digits_test\*.png');
confusion_matrix = zeros(10,10);
for i = 1:length(files)
    file = files(i);
    file_label = str2double(file.name(6));
    test_image = imread(strcat('digits_test\',file.name));
    class_label = pca_classifier(test_image, data_file, d);
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
toc;
end

