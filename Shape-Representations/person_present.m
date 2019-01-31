function result = person_present(curr_filename)
[area, person] = find_max_component_area(curr_filename)
result = (area > 600)
end

