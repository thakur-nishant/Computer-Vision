function class_label = pca_classifier(image, data_file, d)
image = image(:);
backprojection_error = zeros(1,10);

for c = 0:9
    [eigenvectors, ~] = mnist_pca(data_file, c, d);
    % centered_image = image;
    projection  = eigenvectors' * image;
    backprojection = eigenvectors * projection;
    diff = backprojection - image;
    squared_error = sum(diff(:).^2);
    backprojection_error(c+1) = squared_error;
end

[~, class_label] = min(backprojection_error);
class_label = class_label - 1;
end

