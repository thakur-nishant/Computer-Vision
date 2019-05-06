function score = compute_dtw(M,Q)

m = size(M,1);
n = size(Q,1);
scores = zeros(m, n);
scores(1, 1) = euclidean_distance(M(1,:), Q(1,:));

for i = 2:m
    scores(i,1) = scores(i-1, 1) + euclidean_distance(M(i,:), Q(1,:));
end

for j = 2:n
    scores(1,j) = scores(1, j-1) + euclidean_distance(M(1,:), Q(j,:));
end

for i = 2:m
    for j = 2:n
        scores(i,j) = euclidean_distance(M(i,:), Q(j,:)) + ...
            min([scores(i-1, j), scores(i, j-1), scores(i-1, j-1)]);
    end
end

score = scores(m,n);
end

