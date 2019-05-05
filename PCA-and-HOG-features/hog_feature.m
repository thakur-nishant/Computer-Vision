function result = hog_feature(image, top, left, block_size)

block = image(top:top+block_size, left:left+block_size);
cell_size = block_size/2;
cell1 = block(1:cell_size, 1:cell_size);
cell2 = block(1:cell_size, cell_size+1:block_size);
cell3 = block(cell_size+1:block_size, 1:cell_size);
cell4 = block(cell_size+1:block_size, cell_size+1:block_size);
cells = zeros([size(cell1), 4]);
cells(:,:,1) = cell1;
cells(:,:,2) = cell2;
cells(:,:,3) = cell3;
cells(:,:,4) = cell4;

% cell1_go = gradiant orientation of cells
cells_go = zeros([size(cell1), 4]);
cells_go(:,:,1) = gradient_orientations(double(cell1));
cells_go(:,:,2) = gradient_orientations(double(cell2));
cells_go(:,:,3) = gradient_orientations(double(cell3));
cells_go(:,:,4) = gradient_orientations(double(cell4));

range = [20:20:180];
histograms = [];
for k = 1:4
    current_histogram = zeros(1,9);
    cell = cells(:,:,k);
    go = cells_go(:,:,k);
    for i = 1:size(go,1)
        for j = 1:size(go,2)
            if cell(i,j)
                diff = abs(range-go(i,j));
                index = find(diff == min(diff));
                current_histogram(index) = current_histogram(index)+1;
            end
        end
    end
    histograms = [histograms current_histogram];
end

v = histograms;
v = v / norm(v);  % Divide by Euclidean norm
v(v > 0.2) = 0.2; % Clip values over 0.2
v = v / norm(v);  % Divide again by Euclidean norm

result = v;
end

