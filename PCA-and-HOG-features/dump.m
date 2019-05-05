function [outputArg1,outputArg2] = dump(inputArg1,inputArg2)
%DUMP Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end



function [eigenvectors, eigenvalues] = mnist_pca(data_file, class_label, d)

mnist_file = data_file;
fid = fopen(mnist_file, 'r');

[number, count] = fread(fid, 1, 'int32');
if count ~= 1
    disp('failed to read number');
end

[mnist_permutation, count] = fread(fid, number, 'int32');
if count ~= mnist_permutation
    disp('failed to read number');
end


[mnist_labels, count] = fread(fid, number, 'uchar');
if count ~= number
    disp('failed to read number');
end

mnist_digits = fread(fid, [28, 28 * number], 'uint8=>uint8');
mnist_digits = reshape(mnist_digits, [28, 28, number]);

fclose(fid);
% disp('loaded mnist digits');

index_array = find(mnist_labels == class_label);
points = zeros([28*28, length(index_array)]);
for i = 1:length(index_array)
    curr = mnist_digits(:,:,i);
    points(:, i) = curr(:);
end

number = size(points,3);
points = reshape(points, 28*28, number);
average = mean(points,2);
centered_points = zeros(size(points));

for i = 1:number
    centered_points(:,i) = double(points(:,i)) - average;
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



function [eigenvectors, eigenvalues] = mnist_pca(data_file, class_label, d)

mnist_file = data_file;
fid = fopen(mnist_file, 'r');

[number, ~] = fread(fid, 1, 'int32');
fclose(fid);
% disp('loaded mnist digits');
indices = 1:number;
[labels, digits] = load_mnist_selection(data_file, indices);

class_label_indices = labels(:,1) == class_label;
points = digits(:,:,class_label_indices);
number = size(points,3);
points = reshape(points, 28*28, number);
average = mean(points,2);
centered_points = zeros(size(points));

for i = 1:number
    centered_points(:,i) = double(points(:,i)) - average;
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




