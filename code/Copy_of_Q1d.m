function Q1d()
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
obj3dloc = cell(3,1);
for k = 1:size(images,2)
    imshow(images{k});
    hold on;
    car_ds = detections_car{k};
    for i = 1:size(car_ds,1)
        depth = 0;
        agreement = 0;
        x1 = round(max(car_ds(i,1),0));
        x2 = round(min(car_ds(i,3),size(images{k},2)));
        y1 = round(max(car_ds(i,2),0));
        y2 = round(min(car_ds(i,4),size(images{k},1)));
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
        obj3dloc{k}.car(i,1:3) = [X,Y,depth];
            plot(x,y,'or','markersize',10);
         line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','r');
    end

    person_ds = detections_person{k};
    for i = 1:size(person_ds,1)
        depth = 0;
        agreement = 0;
        x1 = round(person_ds(i,1));
        x2 = round(person_ds(i,3));
        y1 = round(person_ds(i,2));
        y2 = round(person_ds(i,4));
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
        obj3dloc{k}.person(i,1:3) = [X,Y,depth];
            plot(x,y,'ob','markersize',10);
         line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','b');
    end
    
    bike_ds = detections_bike{k};
    for i = 1:size(bike_ds,1)
        depth = 0;
        agreement = 0;
        x1 = round(bike_ds(i,1));
        x2 = round(bike_ds(i,3));
        y1 = round(bike_ds(i,2));
        y2 = round(bike_ds(i,4));
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
        obj3dloc{k}.bike(i,1:3) = [X,Y,depth];
            plot(x,y,'oc','markersize',10);
         line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','c');
    end
    hold off;
    pause;
end
% 
% imshow(im1);
% hold on;
% car_ds = detections_car{1}
% for i = 1:size(car_ds,1)
%     %width = bike_ds(i,3) - bike_ds(i,1);
%     %height = bike_ds(i,4) - bike_ds(i,2);
%     x1 = car_ds(i,1)
%     x2 = car_ds(i,3);
%     y1 = car_ds(i,2)
%     y2 = car_ds(i,4);
%     line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','red');
%     rectangle('position',[x1,y1,25,10],'edgecolor','red','facecolor','red');
%     text(x1+3,y1+4,'Car');
% 
%     %rectangle('position',[bike_ds(i,3),bike_ds(i,4),width,height],'edgecolor','cyan');
% end
% person_ds = detections_person{1}
% for i = 1:size(person_ds,1)
%     x1 = person_ds(i,1)
%     x2 = person_ds(i,3);
%     y1 = person_ds(i,2)
%     y2 = person_ds(i,4);
%     line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','blue');
%     rectangle('position',[x1,y1,40,10],'edgecolor','blue','facecolor','blue');
%     text(x1+3,y1+4,'Person');
% end
% hold off;

end

