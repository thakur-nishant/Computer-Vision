function result = orientation_difference(A,B)
C = (tand(A)-tand(B))/(1+tand(A)*tand(B));
result = abs(atand(C));
end

