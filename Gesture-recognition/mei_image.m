function result = mei_image(filename, start_frame, end_frame)

frames = read_video_frames(filename);
frames = frames(:,:,:,start_frame:end_frame);
no_frames = size(frames,4);
temp = frames(:,:,:,1);
previous = 0.3*temp(:,:,1) + 0.59*temp(:,:,2) + 0.11*temp(:,:,3);
[x,y] = size(previous);
result = zeros(x,y);

for k = 2:no_frames
    temp = frames(:,:,:,k);
    temp = 0.3*temp(:,:,1) + 0.59*temp(:,:,2) + 0.11*temp(:,:,3);
    curr = abs(double(previous) - double(temp));
    curr = blur_image(curr, 1);
    curr = curr.*(curr > 30);
    result = result + curr;
    previous = temp;
%     for i=1:x
%         for j=1:y
%             if curr(i,j) > 30
%                 result(i,j)=result(i,j)+curr(i, j);
%             end
%         end
%     end
end

result = uint8(result);

end

