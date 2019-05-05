function [accuracy, confusion_matrix] = pca_classifier_stats(data_file, d)
tic;

fid = fopen(data_file, 'r');

[number, count] = fread(fid, 1, 'int32');
if count ~= 1
    disp('failed to read number');
end

[mnist_permutation, count] = fread(fid, number, 'int32');
if count ~= mnist_permutation
    disp('failed to read number');
end


[labels, count] = fread(fid, number, 'uchar');
if count ~= number
    disp('failed to read number');
end
    
digits = fread(fid, [28, 28 * number], 'uint8=>uint8');
digits = reshape(digits, [28, 28, number]);

fclose(fid);
eigenvectors_cache = zeros(28*28, 400, 10);
for c = 0:9 
    class_label_indices = labels(:,1) == c;
    % class_label_indices = find(labels(:,1) == class_label);
    points = digits(:,:,class_label_indices);
    number = size(points,3);
    points = reshape(points, 28*28, number);
    average = mean(points,2);
    centered_points = zeros(size(points));

    for i = 1:number
        point = double(points(:,i));
        centered_points(:,i) = (point - average)/std(point);
    end  

    covariance_matrix = centered_points * centered_points';
    [eigenvectors, eigenvalues] = eig(covariance_matrix);
    % eigenvalues is a matrix, but only the diagonal matters, so we throw
    % away the rest
    eigenvalues = diag(eigenvalues);
    [~, indices] = sort(eigenvalues, 'descend');
    eigenvectors = eigenvectors(:, indices);

    eigenvectors_cache(:,:,c+1) = eigenvectors(:,1:400);
end

count = 0;
files = dir('digits_test\*.png');
confusion_matrix = zeros(10,10);
for i = 1:length(files)
    file = files(i);
    file_label = str2double(file.name(6));
    test_image = imread(strcat('digits_test\',file.name));
    
    % class_label = pca_classifier(test_image, data_file, d);
    image = test_image(:);
    backprojection_error = zeros(1,10);

    for c = 0:9
        eigenvectors = eigenvectors_cache(:,1:d,c+1);
        % centered_image = image;
        projection  = eigenvectors' * image;
        backprojection = eigenvectors * projection;
        diff = backprojection - image;
        squared_error = sum(diff(:).^2);
        backprojection_error(c+1) = squared_error;
    end

    [~, class_label] = min(backprojection_error);
    class_label = class_label - 1;
    
    %%%
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











