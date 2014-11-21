function depth = getDepth(imset, imname)
globals;
input = fullfile(DATA_DIR, imset, 'results', 'getDisparity', sprintf('%s_left_disparity.png', imname));
output = fullfile(DATA_DIR, imset, 'results', 'getDepth', sprintf('%s_depth.mat', imname));
im = imread(input);
im = round(double(im)/256);
data = getData(imname, imset,'calib');
f = data.f;
T = data.baseline * 1000;
depth = (f * T) ./ im;
save(output, 'depth');
% iptsetpref('ImshowBorder','tight')
% axis image;
% imout = imagesc(depth);
%set(gcf, 'PaperPosition', [0 0 size(depth,2) size(depth,1)]); %Position plot at left hand corner with width 5 and height 5.
%set(gcf, 'PaperSize', [size(depth,2) size(depth,1)]);
%get(imout)
%size(depth,2)
%size(depth,1)
%axis image;
%axis([0 size(depth,2) 0 size(depth,1)]);
%axis off;
%
%set(gca,'position',[0 0 1 1],'units','normalized');
%options.Format = 'png';
%hgexport(gcf, output, options);
%filemenufcn(imout,);
%saveas(imout, output);
%print((get(imout)).CData, output,'-dpng');

end