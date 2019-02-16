function ocean_segmentation(filename)
input_image = imread(filename);
sky = remove_holes((input_image > 195));
figure(1);
imshow(sky);

ocean = (input_image>=120 & input_image< 160);
% 8-connected neighbors
ocean = imopen(ocean, ones(3,3))
ocean = get_component(ocean, 1);
figure(2);
imshow(ocean);
end
