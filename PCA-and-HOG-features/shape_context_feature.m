function result = shape_context_feature(edge_image, row, col, r1)

result = zeros(5,12);
angles = [30:30:360];
radius = [r1, r1*2, r1*4, r1*8, r1*16];
center = [row, col];
for i = 1:size(edge_image,1)
    for j = 1:size(edge_image,2)
        if edge_image(i,j)
            point = [i, j];
            delta_x = point(2) - center(2);
            delta_y = point(1) - center(1);
            theta = atan2d(delta_y, delta_x) + 360*(delta_y<0);
            distance  = sqrt(sum((point - center) .^ 2));
            d_index = 0;
            for a= 1:12
                if theta <= angles(a)
                    a_index = a;
                    break;
                end
            end
            for r= 1:5
                if distance <= radius(r)
                    d_index = r;
                    break;
                end
            end
            if d_index
                result(d_index, a_index) = result(d_index, a_index)+1;
            end
        end
    end
end

end

