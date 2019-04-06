function result = pinhole_location(correspondences)

c1 = perspective_calibration(correspondences);
u1 = correspondences(1,4);
v1 = correspondences(1,5);
u2 = correspondences(5,4);
v2 = correspondences(5,5);

result = estimate_3D_point(c1, c1, u1, v1, u2, v2);

end 

