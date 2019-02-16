function result = remove_holes(binary_image)
%Inverse the input binary image
inverse_binary_image = ~binary_image;
%Max component will be the background
background = get_component(inverse_binary_image, 1);
background = imdilate(background, ones(5,5));
%figure;
%imshow(background);
%title('Background');
%Inverse background to get result
%background = imfill(background,'holes');
result = ~background;
end