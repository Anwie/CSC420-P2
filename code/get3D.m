function depth = get3D(imset, imname)
globals;
input = fullfile(DATA_DIR, imset, 'results', 'getDisparity', sprintf('%s_left_disparity.png', imname));
output = fullfile(DATA_DIR, imset, 'results', 'get3D', sprintf('%s_3D.mat', imname));
im = imread(input);
im = round(double(im)/256.0); % divide by 256 according to the readme to get disparity
data = getData(imname, imset,'calib');
f = data.f; % in mm
T = data.baseline * 1000; % convert to mm
depth = (f * T) ./ im;
%imagesc(depth);    % display the depth map

in3D = zeros(size(depth, 1), size(depth, 2), 3); % last dimension is X, Y, Z
p_x = data.K(1,3);
p_y = data.K(2,3);
for x = 1:size(depth, 2)
    for y = 1:size(depth, 1)
        in3D(y, x, 1) = (x - p_x) * depth(y,x)/f;
        in3D(y, x, 2) = (y - p_y) * depth(y,x)/f;
        in3D(y, x, 3) = depth(y,x);
    end
end
%pause;
% plot; positive Z is in the direction of the expansion
%surf(in3D(:,:,1), in3D(:,:,2), in3D(:,:,3), 'edgecolor', 'none');
save(output, 'depth', 'in3D');  % save variables depth and in3D
end