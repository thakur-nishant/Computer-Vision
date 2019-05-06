function result = compute_mei(filename, start_frame, end_frame)

% function result = compute_mei(filename, start_frame, end_frame, blur_sigma)

frames = read_video_frames(filename);
frames = frames(:,:,:,start_frame:end_frame);
no_frames = size(frames,4);
previous = frames(:,:,:,1);
previous = 0.3*previous(:,:,1) + 0.59*previous(:,:,2) + 0.11*previous(:,:,3);
rows = size(previous, 1);
cols = size(previous, 2);
result = zeros(rows, cols);

for k = 2:no_frames
    current = frames(:,:,:,k);
    current = 0.3*current(:,:,1) + 0.59*current(:,:,2) + 0.11*current(:,:,3);
    diff = abs(current-previous);
    diff = blur_image(diff, 1);
    result = result+double(diff);
    previous = current;
end
result = uint8(result);

end
