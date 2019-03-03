function [result,thetas] = canny4(image, sigma, distance, t1, t2);

% function result = canny4(image, sigma, distance, t1, t2);


b1 = blur_image(image, sigma);

dx = [-1, 0, 1];
dy = dx';  % dy is the transpose of dx

% compute dx, dy, and gradient
dxb1 = double(imfilter(b1, dx, 'same', 'symmetric'));
dyb1 = double(imfilter(b1, dy, 'same', 'symmetric'));
gradient = double((dxb1 .^2 + dyb1 .^2)).^0.5;

% compute edge orientations, in values ranging from 0 to 180 degrees
thetas = gradient_orientations(dxb1, dyb1);

% in the result of gradient_orientations, angles increase clockwise.
% in nonmaxsup, it is assumed that angles increase counterclockwise.
% therefore, we must convert.
thetas = 180-thetas;

% do non-maxima suppression
thinned = nonmaxsup(gradient, thetas, distance);

% for debugging
% result = thinned;

% hysteresis thresholding
result = hysthresh(thinned, t1, t2);



