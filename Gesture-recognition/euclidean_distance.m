function distance  = euclidean_distance(image1, image2)
image1_vector = image1(:);
image2_vector = image2(:);

distance   = sqrt(sum((image1_vector - image2_vector) .^ 2));
end