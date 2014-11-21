function A4Q1b()
im = imread('../data/test/results/005002_left_disparity.png');
im = uint8(double(im)/256);
data = getData('004945', 'test','calib');
f = data.f;
T = data.baseline;
%depth1 = ones(size(im));
%f_mat = ones(size(im,1),size(im,2))*f/1000;
%T_mat = ones(size(im,1),size(im,2))*T;
depth = (f * T) ./ double(im);
%f(size(im,1),size(im,2))
%T(size(im,1),size(im,2))
%im(size(im,1),size(im,2))
%depth(size(im,1),size(im,2))
%depth

% for i = 1:size(im,1)
%     for j = 1:size(im,2)
%         depth(i,j) = f * T / im(i,j);
%         if(depth(i,j) < 1)
%             depth1(i,j)
%         end
%     end
% end
imagesc(depth);
%imwrite(imagesc(depth),'../depth1.png');
