function class_label = nnc_euclidean(test_image)
%   NNC_EUCLIDEAN Recognizes the digit shown in test_image using 
%   nearest neighbor classification under the Euclidean distance. 
%   Argument test_image is a grayscale image, not a filename.

%   Detailed explanation goes here
%   This function measures the Euclidean distance between test_image 
%   and every one of the training examples provided in the digits_training directory.
%   After the code measures the Euclidean distance between test_image and all training examples, 
%   it should identify the training example with the smallest distance, 
%   and return the class label of that training example. 
%   If there are multiple training examples tied for the smallest distance,
%   return any of the class labels of those examples.
min_distance = Inf;

files = dir('digits_training\*.png');
for i = 1:length(files)
    file = files(i);
    file_label = file.name(6);
    curr_image = imread(strcat('digits_training\',file.name));
    curr_image_distance  = euclidean_distance(test_image, curr_image);
    if curr_image_distance < min_distance
        min_distance = curr_image_distance;
        class_label = file_label;
    end
end


end

