function [result,thetas] = canny(image, t1);

% function result = canny(image, t1);
%
% returns canny4(image, 1, 1, t1, 2*t1)

[result,thetas] = canny4(image, 1.4, 1.35, t1, 2*t1);


