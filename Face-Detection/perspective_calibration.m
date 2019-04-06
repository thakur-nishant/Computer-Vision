function camera_matrix = perspective_calibration(correspondences)
A = double.empty(0,11);
B = [];
for i = 1:size(correspondences,1)
    curr = correspondences(i,:);
    temp_A = [curr(1), curr(2), curr(3), 1, 0,0,0,0, -curr(1)*curr(4), -curr(2)*curr(4), -curr(3)*curr(4);...
        0,0,0,0,curr(1), curr(2), curr(3), 1,-curr(1)*curr(5), -curr(2)*curr(5), -curr(3)*curr(5)];
    
    A = cat(1,A,temp_A);
    B = [B curr(4) curr(5)];
end
X = A\B';
X = [X' 1];
camera_matrix = vec2mat(X,4);
end

