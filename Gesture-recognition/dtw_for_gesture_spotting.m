function scores = dtw_for_gesture_spotting(M,Q)

m = size(M,1);
n = size(Q,1);
scores = zeros(m+1, n+1);
scores(1:m+1, 1) = Inf;

for i = 2:m+1
    for j = 2:n+1
        scores(i,j) = euclidean_distance(M(i-1,:), Q(j-1,:)) + ...
            min([scores(i-1, j), scores(i, j-1), scores(i-1, j-1)]);
    end
end

end

