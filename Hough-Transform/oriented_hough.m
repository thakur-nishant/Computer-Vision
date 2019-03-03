function votes = oriented_hough(grayscale, thetas, rhos, thr1, thr2)

votes = zeros(length(rhos), length(thetas));
[canny_edge_result, go] = canny(grayscale, thr1);

for i=1:size(canny_edge_result,1)
    for j=1:size(canny_edge_result,2)
        if canny_edge_result(i,j)
            for k=1:length(thetas)
                if orientation_difference(go(i,j), thetas(k)) <= thr2
                    rho = i*sind(thetas(k)) + j*cosd(thetas(k));
                    rho_diff = abs(rhos-rho);
                    rho_index = find(rho_diff == min(rho_diff));
                    votes(rho_index, k) = votes(rho_index, k)+1;
                end
            end
        end
    end
end

end