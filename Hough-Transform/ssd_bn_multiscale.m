function [result, max_scales] = ssd_bn_multiscale(image, template, scales)

% function result = ssd_bn_multiscale(image, template, scales)
%
% for each pixel, search over the specified scales, and record:
% - in result, the min ssd score for that pixel
%   over all scales
% - in max_scales, the scale that gave the min score 

result = ones(size(image)) * 9223372036854775807;
max_scales = zeros(size(image));

for scale = scales;
    % for efficiency, we either downsize the image, or the template, 
    % depending on the current scale
    if scale >= 1
        scaled_image = imresize(image, 1/scale, 'bilinear');
        temp_result = ssd_bn_search(scaled_image, template);
        temp_result = imresize(temp_result, size(image), 'bilinear');
    else
        scaled_template = resize_template(template, scale);
        temp_result = ssd_bn_search(image, scaled_template);
    end
    higher_maxes = (temp_result < result & temp_result ~= -1);
    max_scales(higher_maxes) = scale;
    result(higher_maxes) = temp_result(higher_maxes);
%border = (result > 9223372036800000000);
%result(border) = -1;
end
