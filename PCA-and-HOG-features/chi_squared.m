function result = chi_squared(sc1, sc2)
sc1 = sc1(:);
sc2 = sc2(:);
result = sum( ((sc1 - sc2) .^ 2) ./ (sc1 + sc2) ) / 2;
end
