function trajectory = green_hand_trajectory(filename, start_frame, end_frame)

video_frames = read_video_frames(filename);
hand_size = [40 30];

N = end_frame - start_frame + 1;
trajectory = zeros(N,2);
for frame = start_frame:end_frame
    [~, ~, center] = green_hands(video_frames, frame, hand_size);
    trajectory(frame-start_frame+1,:) = center;
end

end

