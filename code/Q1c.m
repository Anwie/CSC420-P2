function Q1c()
load('../data/test/results/detections.mat');
im1 = imread('../data/test/left/004945.jpg');
im2 = imread('../data/test/left/004964.jpg');
im3 = imread('../data/test/left/005002.jpg');

images = {im1,im2,im3};
% im1_ds = cell(3,1);
% im2_ds = cell(3,1);
% im3_ds = cell(3,1);
% ds = [im1_ds,im2_ds,im3_ds];
% for j = 1:size(ds)
%     (ds(j)){1} = detections_car{j};
%     im_ds = cell(3,1);
%     im_ds{1} = detections_car{j};
%     im_ds{2} = detections_person{j};
%     im_ds{3} = detections_bike{j};
%     im = im_ds;
% end
% ds
for k = 1:size(images,2)
    imshow(images{k});
    hold on;
    car_ds = detections_car{k};
    for i = 1:size(car_ds,1)
        x1 = car_ds(i,1);
        x2 = car_ds(i,3);
        y1 = car_ds(i,2);
        y2 = car_ds(i,4);
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','red');
        rectangle('position',[x1,y1,25,10],'edgecolor','red','facecolor','red');
        text(x1+3,y1+4,'Car');
    end
    person_ds = detections_person{k};
    for i = 1:size(person_ds,1)
        x1 = person_ds(i,1);
        x2 = person_ds(i,3);
        y1 = person_ds(i,2);
        y2 = person_ds(i,4);
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','blue');
        rectangle('position',[x1,y1,40,10],'edgecolor','blue','facecolor','blue');
        text(x1+3,y1+4,'Person');
    end
    bike_ds = detections_bike{k};
    for i = 1:size(bike_ds,1)
        x1 = bike_ds(i,1);
        x2 = bike_ds(i,3);
        y1 = bike_ds(i,2);
        y2 = bike_ds(i,4);
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]','color','cyan');
        rectangle('position',[x1,y1,30,10],'edgecolor','cyan','facecolor','cyan');
        text(x1+3,y1+4,'Bike');
    end
    hold off;
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

