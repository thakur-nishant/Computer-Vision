function [eigenvectors, eigenvalues] = mnist_pca(data_file, class_label, d)
% number = str2double(data_file(16:20));
% indices = 1:number;
% [labels, digits] = load_mnist_selection(data_file, indices);
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

class_label_indices = labels(:,1) == class_label;
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
[eigenvalues, indices] = sort(eigenvalues, 'descend');
eigenvectors = eigenvectors(:, indices);

eigenvectors = eigenvectors(:,1:d);
eigenvalues = eigenvalues(1:d,:);
end