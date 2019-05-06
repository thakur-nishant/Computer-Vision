function [start_frame,end_frame] = backtrack_scores(scores, end_frame)

i = size(scores,1);
j = end_frame;
while i ~= 1
    previous_scores = [scores(i-1,j),scores(i,j-1), scores(i-1,j-1)];
    previous_position = find(previous_scores == min(previous_scores));
    if previous_position == 1
        i = i-1;
    elseif previous_position == 2
        j = j-1;
    else
        i = i-1;
        j = j-1;
    end
end
start_frame = j;

end

