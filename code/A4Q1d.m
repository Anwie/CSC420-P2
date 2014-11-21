function A4Q1d()
load('../data/test/results/detections.mat');
im1 = imread('../data/test/left/004945.jpg');
im2 = imread('../data/test/left/004964.jpg');
im3 = imread('../data/test/left/005002.jpg');
depth1 = getDepth(imread('../data/test/results/004945_left_disparity.png'));
depth2 = getDepth(imread('../data/test/results/004964_left_disparity.png'));
depth3 = getDepth(imread('../data/test/results/005002_left_disparity.png'));
%imagesc(depth1);
data = getData('004945', 'test','calib');
[K, R, t] = KRt_from_P(data.P_left);
f = K(1,1);
p_x = K(1,3);
p_y = K(2,3);
images = {im1,im2,im3};
depths = {depth1,depth2,depth3};
obj3dloc = {cell(3,2) cell(3,2) cell(3,2)};
colors = ['r','b','c'];
obj = {'car','person','bike'};  % same order as detections
for k = 1:size(images,2)    %loop through images
    imshow(images{k});
    hold on;
    detections = {detections_car{k} detections_person{k} detections_bike{k}};
    for m = 1:size(detections,2)    % loop through each class
        for i = 1:size(detections{m},1) %loop through each detection
            depth = 0;
            agreement = 0;
            x1 = round(max(detections{m}(i,1),0));
            x2 = round(min(detections{m}(i,3),size(images{k},2)));
            y1 = round(max(detections{m}(i,2),0));
            y2 = round(min(detections{m}(i,4),size(images{k},1)));
            for j = 1:30
                rand_x = round(random('unif',x1,x2));
                rand_y = round(random('unif',y1,y2));
                depthAtxy = depths{k}(rand_y,rand_x);
                agrees = nnz(abs(depths{k}(y1:y2,x1:x2) - depthAtxy) < 2);
                if(agrees > agreement)
                    depth = depthAtxy;
                    x = rand_x;
                    y = rand_y;
                    agreement = agrees;
                end
            end
            X = (x - p_x) * depth/f;
            Y = (y - p_y) * depth/f;
            [X,Y,depth]
            obj3dloc{k}{m,1}(i,1:3) = [X,Y,depth];

                plot(x,y,['o',colors(m)],'markersize',10);
             line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color',colors(m));
        end
        obj3dloc{k}{m,2} = obj{m};
%     person_ds = detections_person{k};
%     for i = 1:size(person_ds,1)
%         depth = 0;
%         agreement = 0;
%         x1 = round(person_ds(i,1));
%         x2 = round(person_ds(i,3));
%         y1 = round(person_ds(i,2));
%         y2 = round(person_ds(i,4));
%         for j = 1:30
%             rand_x = round(random('unif',x1,x2));
%             rand_y = round(random('unif',y1,y2));
%             depthAtxy = depths{k}(rand_y,rand_x);
%             agrees = nnz(abs(depths{k}(y1:y2,x1:x2) - depthAtxy) < 2);
%             if(agrees > agreement)
%                 depth = depthAtxy;
%                 x = rand_x;
%                 y = rand_y;
%                 agreement = agrees;
%             end
%         end
%         X = (x - p_x) * depth/f;
%         Y = (y - p_y) * depth/f;
%         obj3dloc{k}.person(i,1:3) = [X,Y,depth];
%             plot(x,y,'ob','markersize',10);
%          line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','b');
%     end
%     
%     bike_ds = detections_bike{k};
%     for i = 1:size(bike_ds,1)
%         depth = 0;
%         agreement = 0;
%         x1 = round(bike_ds(i,1));
%         x2 = round(bike_ds(i,3));
%         y1 = round(bike_ds(i,2));
%         y2 = round(bike_ds(i,4));
%         for j = 1:30
%             rand_x = round(random('unif',x1,x2));
%             rand_y = round(random('unif',y1,y2));
%             depthAtxy = depths{k}(rand_y,rand_x);
%             agrees = nnz(abs(depths{k}(y1:y2,x1:x2) - depthAtxy) < 2);
%             if(agrees > agreement)
%                 depth = depthAtxy;
%                 x = rand_x;
%                 y = rand_y;
%                 agreement = agrees;
%             end
%         end
%         X = (x - p_x) * depth/f;
%         Y = (y - p_y) * depth/f;
%         obj3dloc{k}.bike(i,1:3) = [X,Y,depth];
%             plot(x,y,'oc','markersize',10);
%          line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','c');
%     end
    end
    hold off;
    pause;
end
save('../data/test/results/obj3dlocs.mat','obj3dloc');
end

