function [current_tp, current_fp, current_fn] = check_boxes(boxes, current_gt, iou_thr)

current_tp = 0;
current_fp = 0;
current_fn = 0;

gt = zeros(1,size(current_gt, 1));
for i = 1:size(boxes, 1)
    fp = 1;
    for j = 1: size(current_gt, 1)
       A = boxes(i, :);
       B = current_gt(j, :);
       height_A = A(2) - A(1) + 1;
       width_A = A(4) - A(3) + 1;
       area_A = (height_A * width_A);
       
       height_B = B(2) - B(1) + 1;
       width_B = B(4) - B(3) + 1;
       area_B = (height_B * width_B);
       
       T_ab = max(A(1), B(1));
       B_ab = min(A(2), B(2));
       L_ab = max(A(3), B(3));
       R_ab = min(A(4), B(4));
       
       height_ab = B_ab - T_ab + 1;
       width_ab = R_ab - L_ab + 1;
       
       if height_ab <= 0 || width_ab <= 0
           area_anb = 0;
       else
           area_anb = (height_ab*width_ab);
       end
       area_aub = area_A + area_B - area_anb;
       curr_iou = area_anb/area_aub;
       if curr_iou >= iou_thr
           fp = 0;
           gt(j) = 1;
           break;
       end
    end
    if fp == 1
        current_fp = current_fp + 1;
    else
        current_tp = current_tp + 1;
    end
end
current_fn = length(gt) - sum(gt);
end

