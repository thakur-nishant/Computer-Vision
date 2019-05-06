function [tp, fp, fn] = dtw_spot_accuracy(ground_truth, gestures, iou_threshold)
tp = 0;
fp = 0;
fn = 0;

fid=fopen(ground_truth);
tline = fgetl(fid);
current_gt = zeros(10,3);
 i = 1;
while ischar(tline)
    if tline == ""
        break;
    end
    current_gt(i,:) = (str2double(strsplit(tline, ' ')));
    tline = fgetl(fid);
    i = i + 1;
end
fclose(fid);
gt = zeros(1,size(current_gt, 1));

for i = 1:size(gestures,1)
    curr_fp = 1;
    for j = 1:size(current_gt,1)
        A = current_gt(j,:);
        B = gestures(i,:);
        
        L_ab = max(A(2), B(1));
        R_ab = min(A(3), B(2));
        
        width_ab = R_ab - L_ab + 1;
       
        if width_ab <= 0
            anb = 0;
        else
            anb = width_ab;
        end
        aub = A(3)-A(2) + B(2)-B(1) - anb;
        curr_iou = anb/aub;
        if curr_iou >= iou_threshold && A(1) == B(3) 
            curr_fp = 0;
            gt(j) = 1;
            break;
        end
    end
    if curr_fp == 1
        fp = fp + 1;
    else
        tp = tp + 1;
    end
end
fn = length(gt) - sum(gt);
end

