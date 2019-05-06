function distance = chamfer_distance(image1, image2)

image1_binary = (image1 ~= 0);
n1 = sum(image1_binary(:));
dt1 = bwdist(image2);
chamfer_image1_to_image2 = sum(sum(image1_binary .* dt1)) / n1;

image2_binary = (image2 ~= 0);
n2 = sum(image2_binary(:));
dt2 = bwdist(image1);
chamfer_image2_to_image1 = sum(sum(image2_binary .* dt2)) / n2;

distance = chamfer_image1_to_image2 + chamfer_image2_to_image1; 
end
