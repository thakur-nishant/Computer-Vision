function soccer_analysis(filename)
color = double(imread(filename));
r = color(:,:,1);
g = color(:,:,2);
b = color(:,:,3);

red = ((r - g > 10) & (r - b > 10));
green = ((g - r > 10) & (g - b > 10));
blue = ((b - r > 20) & (b - g > 20));

field = remove_holes(green);
field = get_component(field, 1);

% 4-connected neighbors
neighborhood = ([0,1,0; 1,1,1; 0,1,0]);

red_players = (field & red);
red_players = imerode(red_players, neighborhood);

blue_players = (field & blue);
blue_players = imclose(blue_players, neighborhood);

figure(1); imshow(field);
figure(2); imshow(red_players);
figure(3); imshow(blue_players);
end

