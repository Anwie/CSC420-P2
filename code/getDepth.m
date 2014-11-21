function depth = getDepth(im)
im = round(double(im)/256);
data = getData('004945', 'test','calib');
f = data.f;
T = data.baseline * 1000;
depth = (f * T) ./ im;
%imagesc(depth);
%imwrite(imagesc(depth),'../depth1.png');
