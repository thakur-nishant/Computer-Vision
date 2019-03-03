function result = ssd_bn_search(grayscale,template)
result = -ones(size(grayscale));
template = template - mean(template(:))
[rows,cols] = size(grayscale);
[t_rows, t_cols] = size(template);
t_rhf = (t_rows-1)/2;
t_chf = (t_cols-1)/2;
for i = 1:rows
    for j = 1:cols
        if i > t_rhf && j > t_chf && i <= rows-t_rhf && j <= cols-t_chf
            window = grayscale(i-t_rhf:i+t_rhf, j-t_chf:j+t_chf);
            window = window - mean(window(:));
            window_vector = window(:) ;
            template_vector = template(:);
            diff_vector = window_vector - template_vector;
            squared_diffs = diff_vector .* diff_vector;
            ssd_score = sum(squared_diffs);
            result(i,j) = ssd_score;
        end
    end
end
end

