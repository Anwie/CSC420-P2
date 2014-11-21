function A4Q1e()
load('../data/test/results/detections.mat');
im1 = imread('../data/test/left/004945.jpg');
im2 = imread('../data/test/left/004964.jpg');
im3 = imread('../data/test/left/005002.jpg');
depth1 = getDepth(imread('../data/test/results/004945_left_disparity.png'));
depth2 = getDepth(imread('../data/test/results/004964_left_disparity.png'));
depth3 = getDepth(imread('../data/test/results/005002_left_disparity.png'));
load('../data/test/results/obj3dlocs.mat');
images = {im1,im2,im3};
depths = {depth1,depth2,depth3};
data = getData('004945', 'test','calib');
[K, R, t] = KRt_from_P(data.P_left);
f = K(1,1);
p_x = K(1,3);
p_y = K(2,3);
%colors = ['r','b','c'];
for k = 1:size(images,2)    %loop through images
    %imshow(images{k});
    seg_im = zeros(size(images{k},1),size(images{k},2),3);
    %hold on;
    detections = {detections_car{k} detections_person{k} detections_bike{k}};
    imObj = obj3dloc{k};
    for m = 1:size(detections,2)    % loop through each class
        for i = 1:size(detections{m},1) %loop through each detection
            x1 = round(max(detections{m}(i,1),0));
            x2 = round(min(detections{m}(i,3),size(images{k},2)));
            y1 = round(max(detections{m}(i,2),0));
            y2 = round(min(detections{m}(i,4),size(images{k},1)));
            color = [random('unif',256),random('unif',256),random('unif',256)];
            for x = x1:x2
                for y = y1:y2
                    Z = depths{k}(y,x);
                    X = (x - p_x) * Z/f;
                    Y = (y - p_y) * Z/f;
                    if(norm([X,Y,Z] - imObj{m,1}(i,:),2) < 3000)
                        seg_im(y,x,:) = color;
                    end
                end
            end
                %agrees = nnz(abs(depths{k}(y1:y2,x1:x2) - depthAtxy) < 2);

            %    plot(x,y,['o',colors(m)],'markersize',10);
             %line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color',colors(m));
        end
    end
    imshow(seg_im);
    %hold off;
    pause;
end
end

